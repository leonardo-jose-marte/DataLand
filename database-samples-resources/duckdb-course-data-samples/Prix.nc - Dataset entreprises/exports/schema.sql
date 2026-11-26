


CREATE TABLE activites(code_ape VARCHAR PRIMARY KEY, libelle_naf VARCHAR, division_naf INTEGER, libelle_division_naf VARCHAR, section_naf VARCHAR, libelle_section_naf VARCHAR);
CREATE TABLE formes_juridiques(code_formjur VARCHAR PRIMARY KEY, libelle_formjur VARCHAR);
CREATE TABLE provinces_entreprises(code_province VARCHAR PRIMARY KEY, libelle_province VARCHAR);
CREATE TABLE communes_entreprises(code_commune VARCHAR PRIMARY KEY, libelle_commune VARCHAR, code_province VARCHAR, FOREIGN KEY (code_province) REFERENCES provinces_entreprises(code_province));
CREATE TABLE entreprises(rid7 VARCHAR PRIMARY KEY, denomination VARCHAR, date_entreprise_active DATE, date_emploi DATE, code_formjur VARCHAR, code_ape VARCHAR, code_commune VARCHAR, a_salaries BOOLEAN, FOREIGN KEY (code_commune) REFERENCES communes_entreprises(code_commune), FOREIGN KEY (code_formjur) REFERENCES formes_juridiques(code_formjur), FOREIGN KEY (code_ape) REFERENCES activites(code_ape));
CREATE TABLE etablissements(ridet VARCHAR PRIMARY KEY, rid7 VARCHAR, date_etablis_actif DATE, num_etablissement INTEGER, denomination VARCHAR, sigle VARCHAR, enseigne VARCHAR, code_formjur VARCHAR, code_ape VARCHAR, code_commune VARCHAR, hors_nc VARCHAR, FOREIGN KEY (rid7) REFERENCES entreprises(rid7), FOREIGN KEY (code_formjur) REFERENCES formes_juridiques(code_formjur), FOREIGN KEY (code_ape) REFERENCES activites(code_ape), FOREIGN KEY (code_commune) REFERENCES communes_entreprises(code_commune));
CREATE TABLE magasins_entreprises(id VARCHAR PRIMARY KEY, ridet VARCHAR, FOREIGN KEY (ridet) REFERENCES etablissements(ridet));




