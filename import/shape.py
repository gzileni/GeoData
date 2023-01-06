
# TODO: Read links
# ----------------------------------
# SHAPE: https://geopandas.org/en/stable/docs/reference/api/geopandas.read_file.html
# GPX: https://www.riannek.de/2022/gpx-to-geopandas/
# GPX: https://www.riannek.de/2022/elevation-to-gps-track-python/
# GPX: https://www.riannek.de/2022/runkeeper-gps-tracks-python-part-1/
# GPX: https://www.riannek.de/2022/runkeeper-gps-tracks-python-part-2/
# ----------------------------------
# Datasets
# https://github.com/pcm-dpc/DPC-Centri-Storici-Rischio-Sismico
# https://www.geocorsi.it/N1153/dataset-ispra-mosaicature-nazionali-di-pericolosita-in-open-data.html

import os
import database
import pandas as pd
from argparse import ArgumentParser, ArgumentDefaultsHelpFormatter

os.environ['USE_PYGEOS'] = '0'

# Parse command line arguments
parser = ArgumentParser(formatter_class=ArgumentDefaultsHelpFormatter)
parser.add_argument("-f", "--file", default="",
                    help="shape file name to import")
parser.add_argument("-t", "--table", default="",
                    help="table's name")
parser.add_argument("-e", "--exists", default="replace", 
                    help="Method to write data append/replace")
parser.add_argument("-s", "--schema", default="public", 
                    help="Database schema")
args = vars(parser.parse_args())

from geopandas import GeoDataFrame  # Loading boundaries Data

def main():
    
    fileData = args["file"]
    table = args["table"]
    ifexists = args["exists"]
    schema = args["schema"]
    
    if (fileData == ""):
        raise ValueError(
            "E' necessario il nome del file con l'opzione -f. \n Usare --help per maggiori informazioni.")
    else:
        if (table == ""):
            table = str(fileData).lower()
        path = os.getcwd() + '/data/' + fileData + '.shp'
        geo_df = GeoDataFrame.from_file(path).to_crs(4326)
        geo_df.set_geometry('geometry', crs=4326)
        # geo_df.sindex
        # Setting a Projection
        # geo_df.to_crs(4326)
        database.save_geo(geo_df, table, ifexists, schema)     
    
if __name__ == '__main__':
    main()
