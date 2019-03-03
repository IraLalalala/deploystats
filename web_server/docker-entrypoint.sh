#!/bin/bash
function postgres_ready(){
python3 << END
import psycopg2
import json
import os
import sys
django_path = os.environ["DJANGO"]
secrets_path = os.path.join(django_path, "secrets.json")
with open(secrets_path) as f:
	secrets = json.load(f)
try:
	conn = psycopg2.connect(dbname=secrets["DB_NAME"],
							user=secrets["DB_USER"],
							password=secrets["DB_PASSWORD"],
							host=secrets["DB_HOST"])
except psycopg2.OperationalError as e:
	print(e)
	sys.exit(-1)
sys.exit(0)
END
}

until postgres_ready; do
	>&2 echo "Postgres starting..."
	sleep 1
done


python3 $DJANGO/manage.py makemigrations
python3 $DJANGO/manage.py makemigrations carstats
python3 $DJANGO/manage.py migrate
python3 $SCRAPER/main.py --send
python3 $DJANGO/manage.py runserver 0.0.0.0:8000