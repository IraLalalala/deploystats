#!/bin/bash
python3 /srv/carstats/manage.py migrate
python3 /srv/carstats/manage.py runserver 0.0.0.0:8000