#!/bin/bash
# Database Setup Script for Hilos Application
# Run this script after starting Docker Compose for the first time

set -e

echo "======================================"
echo "Hilos Application - Database Setup"
echo "======================================"
echo ""

# Wait for MySQL to be ready
echo "Waiting for MySQL to be ready..."
until docker-compose exec db mysqladmin ping -h localhost -u root -p${DB_PASSWORD:-password} --silent; do
  echo "MySQL is unavailable - sleeping"
  sleep 2
done

echo "MySQL is ready!"
echo ""

# Create databases (already done by init.sql, but just in case)
echo "Creating databases..."
docker-compose exec web bundle exec rake db:create

# Run migrations
echo "Running migrations..."
docker-compose exec web bundle exec rake db:migrate

# Seed database (if seed file exists)
if [ -f db/seeds.rb ]; then
  echo "Seeding database..."
  docker-compose exec web bundle exec rake db:seed
fi

echo ""
echo "======================================"
echo "Database setup complete!"
echo "======================================"
echo ""
echo "You can now access the application at http://localhost:3000"
