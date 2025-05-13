#!/usr/bin/env bash
set -o errexit

pip install --upgrade pip
pip install -r requirements.txt

# Run Django commands
python manage.py collectstatic --noinput
python manage.py migrate