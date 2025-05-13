#!/usr/bin/env bash
set -o errexit

echo "Python version:"
python --version

pip install --upgrade pip
pip install -r requirements.txt

# Print environment variables for debugging (masking secrets)
echo "Environment variables:"
env | grep -v SECRET | grep -v PASSWORD | grep -v KEY

# Check DATABASE_URL
if [ -z "$DATABASE_URL" ]; then
  echo "WARNING: DATABASE_URL is not set. Database operations may fail."
else
  echo "DATABASE_URL is set (value hidden for security)"
fi

# Run Django commands
python manage.py collectstatic --noinput
python manage.py migrate