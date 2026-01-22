# Development Guide

Complete guide to developing and running Diseños (Embroidery Design Management System) locally with Docker.

## Prerequisites

- [Docker](https://www.docker.com/get-started) (20.10 or higher)
- [Docker Compose](https://docs.docker.com/compose/install/) (1.29 or higher)
- Git

You don't need Ruby, Rails, or MySQL installed locally. Docker handles all dependencies.

## Initial Setup

### 1. Clone and Configure

```bash
git clone https://github.com/dewittn/rails-sbc-disenos
cd rails-sbc-disenos

# Copy environment variables
cp .env.example .env

# (Optional) Edit .env to customize database credentials
```

### 2. Start Services

```bash
# Build and start all services
docker-compose up -d

# Wait for services to start (about 30 seconds)
docker-compose ps
```

### 3. Initialize Database

```bash
# Run the database setup script
./docker/db_setup.sh

# Or manually run:
docker-compose exec web bundle exec rake db:create db:migrate db:seed
```

### 4. Access Application

Open your browser to:

```
http://localhost:3000
```

## Development Workflow

### Starting the Application

```bash
# Start all services in the background
docker-compose up -d

# View logs (follow mode)
docker-compose logs -f web

# View logs for all services
docker-compose logs -f
```

### Stopping the Application

```bash
# Stop all services
docker-compose down

# Stop and remove volumes (WARNING: This deletes database data!)
docker-compose down -v
```

### Working with the Rails Console

```bash
# Open Rails console
docker-compose exec web bundle exec rails console

# Example usage:
# Diseno.count
# Color.all
# exit
```

## Database Commands

### Basic Database Operations

```bash
# Create databases
docker-compose exec web bundle exec rake db:create

# Run migrations
docker-compose exec web bundle exec rake db:migrate

# Rollback migration
docker-compose exec web bundle exec rake db:rollback

# Seed database
docker-compose exec web bundle exec rake db:seed

# Reset database (drop, create, migrate, seed)
docker-compose exec web bundle exec rake db:reset
```

### Accessing the Database Directly

```bash
# Access MySQL console
docker-compose exec db mysql -u root -ppassword hilos_development

# Example SQL commands:
# SHOW TABLES;
# SELECT * FROM disenos LIMIT 5;
# exit
```

## Testing

### Running Tests

```bash
# Run all tests
docker-compose exec web bundle exec rake test

# Run specific test file
docker-compose exec web bundle exec ruby -I test test/unit/diseno_test.rb

# Run unit tests only
docker-compose exec web bundle exec rake test:units

# Run functional tests only
docker-compose exec web bundle exec rake test:functionals
```

### Test Structure

- `test/unit/` - Model tests
- `test/functional/` - Controller tests
- `test/integration/` - Integration tests
- `test/fixtures/` - Test data

## Installing New Gems

```bash
# Edit Gemfile locally
nano Gemfile

# Rebuild the web container
docker-compose build web

# Restart the services
docker-compose restart web
```

## Viewing Logs

```bash
# View logs for web service
docker-compose logs web

# Follow logs in real-time
docker-compose logs -f web

# View last 100 lines
docker-compose logs --tail=100 web

# View logs for database
docker-compose logs db
```

## Docker Services

### Web Service (Rails)

- **Port**: 3000
- **Image**: Built from Dockerfile (Ruby 2.3.8, Rails 4.2.11.3)
- **Volumes**:
  - Application code mounted from `.` to `/app`
  - Bundler cache for faster rebuilds

### Database Service (MySQL)

- **Port**: 3307 (external) → 3306 (internal)
- **Image**: mysql:8.0
- **Volumes**:
  - Persistent data storage in `mysql_data` volume
  - Initialization script mounted from `docker/mysql/init.sql`
- **Health Check**: Ensures database is ready before Rails starts

## Environment Variables

Configure these in your `.env` file:

| Variable            | Default             | Description                             |
| ------------------- | ------------------- | --------------------------------------- |
| `DB_HOST`           | `db`                | Database hostname (use 'db' for Docker) |
| `DB_USERNAME`       | `root`              | MySQL username                          |
| `DB_PASSWORD`       | `password`          | MySQL password (change in production!)  |
| `DB_NAME`           | `hilos_development` | Database name                           |
| `RAILS_ENV`         | `development`       | Rails environment                       |
| `RAILS_MAX_THREADS` | `5`                 | Database connection pool size           |

## Troubleshooting

### Port Already in Use

**Error**: "Bind for 0.0.0.0:3000 failed: port is already allocated"

```bash
# Find and kill process using port 3000
lsof -ti:3000 | xargs kill -9

# Or change the port in docker-compose.yml
```

**Error**: "Bind for 0.0.0.0:3307 failed: port is already allocated"

```bash
# Change the MySQL port mapping in docker-compose.yml
# From: "3307:3306"
# To:   "3308:3306"
```

### Container Won't Start

```bash
# Check container status
docker-compose ps

# View detailed logs
docker-compose logs web
docker-compose logs db

# Rebuild containers
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

### Database Connection Refused

```bash
# Ensure database is healthy
docker-compose ps

# Check database logs
docker-compose logs db

# Restart services
docker-compose restart

# If problems persist, recreate containers
docker-compose down -v
docker-compose up -d
./docker/db_setup.sh
```

### Permission Issues with Uploaded Files

```bash
# Fix permissions on public/system directory
docker-compose exec web chmod -R 755 public/system
```

### Gem Installation Failures

```bash
# Clear bundle cache and rebuild
docker-compose down
docker volume rm rails-sbc-disenos_bundle_cache
docker-compose build --no-cache web
docker-compose up -d
```

## Project Structure

```
.
├── app/
│   ├── assets/          # JavaScript, CSS, images
│   ├── controllers/     # Application controllers
│   ├── helpers/         # View helpers
│   ├── models/          # ActiveRecord models
│   └── views/           # View templates (HAML)
├── config/
│   ├── database.yml     # Database configuration
│   ├── routes.rb        # Application routes
│   └── environments/    # Environment-specific configs
├── db/
│   ├── migrate/         # Database migrations
│   └── seeds.rb         # Seed data
├── docker/
│   ├── mysql/
│   │   └── init.sql     # MySQL initialization script
│   └── db_setup.sh      # Database setup script
├── lib/                 # Custom libraries
├── public/              # Static files
│   └── system/          # Uploaded files (Paperclip)
├── test/                # Test files
├── vendor/
│   └── plugins/         # Custom plugins (coto_solutions, etc.)
├── docker-compose.yml   # Docker Compose configuration
├── Dockerfile           # Docker image definition
├── Gemfile              # Ruby dependencies
└── README.md            # Main README
```

## Quick Reference

```bash
# Start development
docker-compose up -d

# View logs
docker-compose logs -f web

# Rails console
docker-compose exec web bundle exec rails console

# Run migrations
docker-compose exec web bundle exec rake db:migrate

# Run tests
docker-compose exec web bundle exec rake test

# Access database
docker-compose exec db mysql -u root -ppassword hilos_development

# Stop everything
docker-compose down
```

## See Also

- [Architecture](architecture.md) - Technical design and domain models
- [Main README](../README.md) - Project overview
- [CLAUDE.md](../CLAUDE.md) - Detailed project documentation for AI assistants
