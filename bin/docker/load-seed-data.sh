#!/bin/bash
# This script runs during MySQL's first initialization
# It finds the newest SQL dump in /data and loads it

set -e

DATA_DIR="/data"
DB_NAME="${DB_NAME:-hilos_development}"
DB_PASSWORD="${DB_PASSWORD:-password}"

echo "=== Seed Data Loader ==="

# Check if data directory exists and is mounted
if [ ! -d "$DATA_DIR" ]; then
    echo "No data directory found at $DATA_DIR. Skipping seed data load."
    exit 0
fi

# Find newest SQL file (either .sql or .sql.gz) sorted by modification time
NEWEST_SQL=$(ls -t "$DATA_DIR"/*.sql "$DATA_DIR"/*.sql.gz 2>/dev/null | head -1)

if [ -z "$NEWEST_SQL" ]; then
    echo "No SQL files found in $DATA_DIR. Skipping seed data load."
    exit 0
fi

echo "Found newest SQL file: $NEWEST_SQL"
echo "Loading into database: $DB_NAME"

# Load the SQL file (handle both .sql and .sql.gz)
if [[ "$NEWEST_SQL" == *.gz ]]; then
    echo "Decompressing and loading gzipped SQL file..."
    gunzip -c "$NEWEST_SQL" | mysql -u root -p"$DB_PASSWORD" "$DB_NAME"
else
    echo "Loading SQL file..."
    mysql -u root -p"$DB_PASSWORD" "$DB_NAME" < "$NEWEST_SQL"
fi

echo "=== Seed data loaded successfully ==="
