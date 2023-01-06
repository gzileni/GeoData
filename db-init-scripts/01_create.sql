GRANT ALL PRIVILEGES ON DATABASE geodata TO geodata;
CREATE SCHEMA IF NOT EXISTS gis;
ALTER DATABASE geodata SET search_path=public,gis;
GRANT ALL PRIVILEGES ON SCHEMA gis TO geodata;

CREATE EXTENSION postgis;
CREATE EXTENSION postgis_raster;

ALTER DATABASE postgres SET postgis.enable_outdb_rasters = true;
ALTER DATABASE postgres SET postgis.gdal_enabled_drivers TO 'ENABLE_ALL';

ALTER DATABASE geodata SET postgis.enable_outdb_rasters = true;
ALTER DATABASE geodata SET postgis.gdal_enabled_drivers TO 'ENABLE_ALL';

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;