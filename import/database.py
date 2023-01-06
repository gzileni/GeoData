
import os
import pathlib

from dotenv import load_dotenv
from sqlalchemy import *
from sqlalchemy.engine import create_engine
from sqlalchemy.schema import *

dotenv_path = pathlib.Path('../.env')
load_dotenv(dotenv_path=dotenv_path)

def uri():
    url = "postgresql://" + \
        str(os.getenv('POSTGRES_USER')) + ":" + \
        str(os.getenv('POSTGRES_PASSWORD')) + "@" + \
        str(os.getenv('PGHOST')) + ":" + \
        str(os.getenv('PGPORT')) + "/" + \
        str(os.getenv('POSTGRES_DATABASE_NAME'))
    return url

def engine():
    return create_engine(uri())

def save_geo(geo_df, table, replace, schema):
      geo_df.to_postgis(table, 
                        engine(), 
                        if_exists=replace, 
                        schema=schema)
