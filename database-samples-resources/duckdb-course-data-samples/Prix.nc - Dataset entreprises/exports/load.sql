COPY activites FROM 'exports/activites.parquet' (FORMAT 'parquet');
COPY formes_juridiques FROM 'exports/formes_juridiques.parquet' (FORMAT 'parquet');
COPY provinces_entreprises FROM 'exports/provinces_entreprises.parquet' (FORMAT 'parquet');
COPY communes_entreprises FROM 'exports/communes_entreprises.parquet' (FORMAT 'parquet');
COPY entreprises FROM 'exports/entreprises.parquet' (FORMAT 'parquet');
COPY etablissements FROM 'exports/etablissements.parquet' (FORMAT 'parquet');
COPY magasins_entreprises FROM 'exports/magasins_entreprises.parquet' (FORMAT 'parquet');
