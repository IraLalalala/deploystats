#!/bin/bash
python3 /srv/carstats/manage.py migrate
python3 /srv/carstats/manage.py runserver