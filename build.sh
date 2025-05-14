#!/bin/bash
echo "Running build script..."
python -c "
import os
import time
import sys
import psycopg2

print('Waiting for PostgreSQL database...')
db_url = os.environ.get('DATABASE_URL')
if not db_url:
    print('No DATABASE_URL found, skipping database check')
    sys.exit(0)

# Extract connection details from DATABASE_URL
from urllib.parse import urlparse
url = urlparse(db_url)
dbname = url.path[1:]
user = url.username
password = url.password
host = url.hostname
port = url.port or 5432

# Wait for database to be ready
max_retries = 10
retries = 0
while retries < max_retries:
    try:
        conn = psycopg2.connect(
            dbname=dbname,
            user=user,
            password=password,
            host=host,
            port=port
        )
        conn.close()
        print('Database is ready!')
        break
    except psycopg2.OperationalError:
        retries += 1
        print(f'Database not ready yet, retry {retries}/{max_retries}')
        time.sleep(5)
else:
    print('Could not connect to database after multiple retries')
    sys.exit(1)
"
echo "Build script completed"
chmod +x manage.py