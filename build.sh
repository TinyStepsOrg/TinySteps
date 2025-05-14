#!/bin/bash
echo "Starting build process..."

# Make this script executable
chmod +x manage.py

# Install dependencies
pip install -r requirements.txt

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
  echo "WARNING: DATABASE_URL is not set. Will use SQLite for deployment."
fi

# Run Django checks and migrations
python manage.py check --deploy
python manage.py migrate

# Load fixture data if it exists
if [ -f "data_dump.json" ]; then
  python manage.py loaddata data_dump.json
else
  echo "No data_dump.json found, skipping data loading."
fi

echo "Build completed successfully."