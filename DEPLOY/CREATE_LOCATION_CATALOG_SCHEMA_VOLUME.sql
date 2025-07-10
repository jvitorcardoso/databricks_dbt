CREATE EXTERNAL LOCATION IF NOT EXISTS `data4all_dev`
URL 's3://data4all-lake-dev/'
WITH (STORAGE CREDENTIAL `data4all-lake`)
COMMENT 'Criação da external location para o container data4all em ambiente de desenvolvimento';

GRANT ALL PRIVILEGES
ON EXTERNAL LOCATION `data4all_dev`
TO `joaocardoso.dataengineer@outlook.com`;

CREATE CATALOG IF NOT EXISTS `one_lake_dev`
MANAGED LOCATION 's3://data4all-lake-dev'
COMMENT '[MAIN CATALOG] - Catálogo vinculado ao diretório "data4all-lake-dev" no bucket principal';

GRANT ALL PRIVILEGES
ON CATALOG `one_lake_dev`
TO `joaocardoso.dataengineer@outlook.com`;

CREATE SCHEMA IF NOT EXISTS `one_lake_dev`.`bronze`
MANAGED LOCATION 's3://data4all-lake-dev/bronze'
COMMENT '[BRONZE LAYER] - Camada de ingestão de dados brutos, sem transformações. Contém dados em seu formato original, provenientes de diversas fontes (Kafka, S3, APIs, arquivos etc.). Utilizada para auditoria, reprocessamento e histórico completo dos dados.';

GRANT ALL PRIVILEGES
ON SCHEMA `one_lake_dev`.`bronze`
TO `joaocardoso.dataengineer@outlook.com`;

CREATE SCHEMA IF NOT EXISTS `one_lake_dev`.`silver`
MANAGED LOCATION 's3://data4all-lake-dev/silver'
COMMENT '[SILVER LAYER] - Camada de dados limpos, integrados e com transformações intermediárias. Responsável por tratar nulos, normalizar tipos, aplicar regras de negócio básicas e integrar dados de múltiplas fontes. Serve como base confiável para análise e modelagem.';

GRANT ALL PRIVILEGES
ON SCHEMA `one_lake_dev`.`silver`
TO `joaocardoso.dataengineer@outlook.com`;

CREATE SCHEMA IF NOT EXISTS `one_lake_dev`.`gold`
MANAGED LOCATION 's3://data4all-lake-dev/gold'
COMMENT '[GOLD LAYER] - Camada de dados analíticos, otimizados para consumo de negócios. Contém métricas, KPIs, dimensões e fatos, muitas vezes modelados em star schema ou data marts. Usada por dashboards, relatórios e análises avançadas.';

GRANT ALL PRIVILEGES
ON SCHEMA `one_lake_dev`.`gold`
TO `joaocardoso.dataengineer@outlook.com`;

CREATE EXTERNAL VOLUME IF NOT EXISTS `one_lake_dev`.`bronze`.`landzone`
LOCATION 's3://data4all-lake-dev/bronze/landzone';

GRANT ALL PRIVILEGES
ON VOLUME `one_lake_dev`.`bronze`.`landzone`
TO `joaocardoso.dataengineer@outlook.com`;
