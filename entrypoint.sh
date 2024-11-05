#!/bin/bash

# Run Django commands with error handling
echo "Running migrations..."
python3 manage.py makemigrations || exit 1
python3 manage.py migrate || exit 1

echo "Collecting static files..."
python3 manage.py collectstatic --noinput || exit 1

echo "Creating admin user..."
python3 manage.py createhorillauser \
    --first_name admin \
    --last_name admin \
    --username admin \
    --password admin \
    --email admin@example.com \
    --phone 1234567890 || true  # Don't exit if user already exists

echo "Starting Gunicorn..."
exec gunicorn --bind 0.0.0.0:8000 horilla.wsgi:application
