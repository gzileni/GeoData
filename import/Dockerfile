FROM python:3.9

# Install Java dependencies
RUN apt-get -y update
RUN apt-get install -y software-properties-common\
    && apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main'

# Install Java, GDAL & utils
RUN apt-get update && apt-get install -y\
    openjdk-8-jdk\
    libgdal-dev\
    ant\
    ca-certificates-java\
    wget\
    tar\
    bash\
    nmap\
    vim\
    && apt-get clean\
    && update-ca-certificates -f

WORKDIR /app
COPY . /app

ENV VIRTUAL_ENV=/app/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV PATH_DATA = "/app/data"

RUN python3 -m venv $VIRTUAL_ENV
RUN pip3 install -r requirements.txt --no-cache-dir
RUN pip3 install load_dotenv
RUN pip3 install psycopg2
RUN pip install geoalchemy2