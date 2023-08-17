FROM python:3.6-slim
ARG MYSQL_PORT
ENV MYSQL_SERVICE_PORT=$MYSQL_PORT
ARG DB_NAME="userapi_db"
ENV db_name=$DB_NAME

RUN apt-get clean \
    && apt-get -y update

RUN apt-get -y install \
    nginx \
    python3-dev \
    build-essential \
    libpcre3 \
    libpcre3-dev 

WORKDIR /app

COPY app/requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt --src /usr/local/src

COPY app/userapi.py /app/userapi.py
COPY app/startup.sh /app/startup.sh
COPY app/uwsgi.ini /app/uwsgi.ini

RUN chmod +x ./startup.sh

EXPOSE 80

CMD [ "./startup.sh" ]
