#!/usr/bin/env python3
"""Rebuild the large Contoso CSV files from verified binary fragments."""

from __future__ import annotations

import hashlib
import json
import os
import sys
import tempfile
from pathlib import Path, PurePosixPath
from typing import Any


CHUNK_DIRECTORY = "fragmented"
MANIFEST_NAME = "manifest.json"
BUFFER_SIZE = 1024 * 1024


def fail(message: str) -> ValueError:
    return ValueError(message)


def safe_fragment_path(fragment_root: Path, relative_name: Any) -> Path:
    if not isinstance(relative_name, str) or "\\" in relative_name:
        raise fail(f"Invalid fragment path: {relative_name!r}")

    relative_path = PurePosixPath(relative_name)
    if relative_path.is_absolute() or any(
        part in ("", ".", "..") for part in relative_path.parts
    ):
        raise fail(f"Invalid fragment path: {relative_name!r}")

    path = fragment_root.joinpath(*relative_path.parts)
    try:
        path.resolve().relative_to(fragment_root.resolve())
    except ValueError as error:
        raise fail(f"Fragment path escapes its folder: {relative_name!r}") from error

    if path.is_symlink() or not path.is_file():
        raise fail(f"Missing or invalid fragment: {relative_name}")
    return path


def file_sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        while block := source.read(BUFFER_SIZE):
            digest.update(block)
    return digest.hexdigest()


def load_manifest(manifest_path: Path) -> dict[str, Any]:
    with manifest_path.open("r", encoding="utf-8") as source:
        manifest = json.load(source)

    if not isinstance(manifest, dict) or manifest.get("format_version") != 1:
        raise fail("Unsupported or invalid manifest format.")
    if not isinstance(manifest.get("files"), list) or not manifest["files"]:
        raise fail("The manifest has no file entries.")
    return manifest


def rebuild_file(
    csv_directory: Path,
    name: str,
    size_bytes: int,
    expected_sha256: str,
    fragments: list[tuple[Path, int, str]],
) -> str:
    destination = csv_directory / name
    temporary_path: Path | None = None
    whole_digest = hashlib.sha256()
    whole_size = 0

    try:
        with tempfile.NamedTemporaryFile(
            mode="wb",
            prefix=f".{name}.",
            suffix=".tmp",
            dir=csv_directory,
            delete=False,
        ) as output:
            temporary_path = Path(output.name)
            for fragment_path, expected_size, expected_fragment_hash in fragments:
                fragment_digest = hashlib.sha256()
                fragment_size = 0
                with fragment_path.open("rb") as fragment:
                    while block := fragment.read(BUFFER_SIZE):
                        output.write(block)
                        fragment_digest.update(block)
                        whole_digest.update(block)
                        fragment_size += len(block)
                        whole_size += len(block)

                if fragment_size != expected_size:
                    raise fail(
                        f"Wrong size for {fragment_path.name}: "
                        f"expected {expected_size}, got {fragment_size}."
                    )
                if fragment_digest.hexdigest() != expected_fragment_hash:
                    raise fail(f"Checksum mismatch: {fragment_path}")

        if whole_size != size_bytes:
            raise fail(
                f"Wrong reconstructed size for {name}: "
                f"expected {size_bytes}, got {whole_size}."
            )
        if whole_digest.hexdigest() != expected_sha256:
            raise fail(f"Final checksum mismatch: {name}")

        if destination.exists():
            if destination.is_file() and file_sha256(destination) == expected_sha256:
                return f"Already verified: {name} (fragments and checksums validated)"
            raise fail(
                f"Output already exists and does not match the manifest: {destination}"
            )

        os.replace(temporary_path, destination)
        temporary_path = None
        return f"OK: {name} ({len(fragments)} fragments; SHA-256 verified)"
    finally:
        if temporary_path is not None:
            temporary_path.unlink(missing_ok=True)


def main() -> int:
    csv_directory = Path(__file__).resolve().parent
    fragment_root = csv_directory / CHUNK_DIRECTORY
    manifest_path = fragment_root / MANIFEST_NAME

    try:
        manifest = load_manifest(manifest_path)
        expected_paths: set[str] = set()
        entries: list[tuple[str, int, str, list[tuple[Path, int, str]]]] = []
        output_names: set[str] = set()

        for entry in manifest["files"]:
            if not isinstance(entry, dict):
                raise fail("Invalid file entry in manifest.")

            name = entry.get("name")
            size_bytes = entry.get("size_bytes")
            expected_sha256 = entry.get("sha256")
            if (
                not isinstance(name, str)
                or not name
                or "/" in name
                or "\\" in name
                or name in (".", "..")
            ):
                raise fail(f"Invalid output filename: {name!r}")
            if name in output_names:
                raise fail(f"Duplicate output filename in manifest: {name}")
            output_names.add(name)
            if not isinstance(size_bytes, int) or size_bytes < 0:
                raise fail(f"Invalid size for {name}.")
            if not isinstance(expected_sha256, str) or len(expected_sha256) != 64:
                raise fail(f"Invalid SHA-256 checksum for {name}.")

            raw_fragments = entry.get("fragments")
            if not isinstance(raw_fragments, list) or not raw_fragments:
                raise fail(f"No fragments listed for {name}.")

            fragments: list[tuple[Path, int, str]] = []
            for fragment in raw_fragments:
                if not isinstance(fragment, dict):
                    raise fail(f"Invalid fragment entry for {name}.")
                relative_name = fragment.get("path")
                fragment_size = fragment.get("size_bytes")
                fragment_hash = fragment.get("sha256")
                if relative_name in expected_paths:
                    raise fail(f"Duplicate fragment listed: {relative_name}")
                if not isinstance(fragment_size, int) or fragment_size < 0:
                    raise fail(f"Invalid fragment size: {relative_name}")
                if not isinstance(fragment_hash, str) or len(fragment_hash) != 64:
                    raise fail(f"Invalid fragment checksum: {relative_name}")

                fragment_path = safe_fragment_path(fragment_root, relative_name)
                expected_paths.add(relative_name)
                fragments.append((fragment_path, fragment_size, fragment_hash))

            entries.append((name, size_bytes, expected_sha256, fragments))

        actual_paths = {
            path.relative_to(fragment_root).as_posix()
            for path in fragment_root.rglob("*")
            if path.is_file()
            and path.relative_to(fragment_root).as_posix() != MANIFEST_NAME
        }
        if actual_paths != expected_paths:
            missing = sorted(expected_paths - actual_paths)
            extra = sorted(actual_paths - expected_paths)
            raise fail(
                f"Fragment set does not match manifest. "
                f"Missing: {missing}; extra: {extra}"
            )

        for name, size_bytes, expected_sha256, fragments in entries:
            print(
                rebuild_file(
                    csv_directory, name, size_bytes, expected_sha256, fragments
                )
            )
        print(f"All {len(entries)} CSV files passed integrity checks.")
        return 0
    except (OSError, ValueError, KeyError, TypeError, json.JSONDecodeError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
