# Contoso CSV fragmentation

Five CSV files exceed GitHub's 100 MiB per-file limit. Their original bytes are
stored as binary fragments under `CSVs/fragmented/`, with each fragment limited
to 45 MiB. The fragments are named `part-000001.bin`, `part-000002.bin`, and so
on; they are not standalone CSV files. There are 55 fragments in total.

| Reconstructed CSV | Fragment folder | Parts |
| --- | --- | ---: |
| `FactInventory.csv` | `CSVs/fragmented/FactInventory.csv/` | 10 |
| `FactOnlineSales.csv` | `CSVs/fragmented/FactOnlineSales.csv/` | 27 |
| `FactSales.csv` | `CSVs/fragmented/FactSales.csv/` | 6 |
| `FactSalesQuota.csv` | `CSVs/fragmented/FactSalesQuota.csv/` | 9 |
| `FactStrategyPlan.csv` | `CSVs/fragmented/FactStrategyPlan.csv/` | 3 |

## Rebuild the CSV files

The repository includes `CSVs/rebuild_csvs.py`. It uses only Python's standard
library; no packages need to be installed. Run it from any operating system:

```text
python database-samples-resources/sql-server-db-samples/database/contoso-data-warehouse-db/CSVs/rebuild_csvs.py
```

In Google Colab, clone the repository and run the same script:

```python
!git clone https://github.com/leonardo-jose-marte/DataLand.git
%run /content/DataLand/database-samples-resources/sql-server-db-samples/database/contoso-data-warehouse-db/CSVs/rebuild_csvs.py
```

The five complete CSV files are written directly into the `CSVs/` folder beside
the script. In Colab, they are in the cloned repository under
`/content/DataLand/.../CSVs/`.

## Integrity and duplicate checks

`CSVs/fragmented/manifest.json` is the integrity reference for the data. It
records the expected fragments, their byte sizes and SHA-256 checksums, and the
expected size and SHA-256 checksum of each complete CSV.

The script checks that no fragments are missing, duplicated, or unexpected;
verifies each fragment; then verifies the size and checksum of each rebuilt CSV.
It only writes a CSV after all its checks pass. An existing CSV is left alone
if it is not identical to the expected file. A successful run prints `OK` for
each file and a final integrity confirmation.

The rebuilt large CSVs are ignored by Git in this folder so they cannot
accidentally be committed as files over GitHub's limit.
