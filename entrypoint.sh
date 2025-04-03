#!/bin/bash

# Wait for PostgreSQL
echo "⏳ Waiting for PostgreSQL..."
until bash -c "</dev/tcp/db/5432" &>/dev/null; do
  sleep 1
done
echo "✅ PostgreSQL is up and running!"

# Set environment if needed
export FLASK_APP=manage.py

# Run migrations
echo "📦 Running database migrations..."
flask db upgrade || (flask db init && flask db migrate -m "Initial" && flask db upgrade)

# Start Flask app
echo "🚀 Starting Flask server..."
exec python manage.py
