#!/usr/bin/env bash
set -o errexit

pip install --upgrade pip
pip install -r requirements.txt

# Si no hay DATABASE_URL en build, usa SQLite local para collectstatic/migrate
if [ -z "$DATABASE_URL" ]; then
  export DATABASE_URL="sqlite:///db.sqlite3"
fi

# Run Django commands
python manage.py collectstatic --noinput
python manage.py migrate
