# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Rails 4.2.11.3 application (named "Hilos") for managing embroidery designs (diseños). The application tracks designs with their associated thread colors (hilos), supports file attachments for design files (DST/PES formats), and includes timeline tracking functionality.

**Ruby Version:** 2.3.8 (configured in Dockerfile)
**Database:** MySQL 8.0 (development, test, production)
**Containerization:** Docker Compose for development environment

## Core Domain Models

- **Diseno** (Design): Main entity with attached files (image, original, archivo_dst, archivo_pes, names). Uses Paperclip for file attachments. Has many `hilos` (threads) and uses `timeline_fu` for activity tracking.
- **Hilo** (Thread): Join model connecting designs to colors (belongs to both `diseno` and `color`)
- **Color**: Thread colors with hex codes, associated with a `marca` (brand)
- **Marca** (Brand): Thread brand/manufacturer
- **TimelineEvent**: Activity timeline tracking using the `timeline_fu` gem

## Key Architecture Patterns

### Custom Plugin: coto_solutions
Located in `vendor/plugins/coto_solutions/`, provides:
- **acts_as_cached**: Model-level caching with automatic cache invalidation on save/destroy
  - Adds `all_cached`, `delete_cached`, and `detect_from_cached` class methods to models
- **CotoHelper**: Helper methods available across views
- **PathPrefix**: JavaScript asset utilities

### File Attachments
Uses Paperclip gem (v4.2.2) for file uploads. Diseno model has multiple attachments:
- `image`: Design image with styles (medium: 300x300, small: 100x100)
- `original`: Original image file
- `archivo_dst`, `archivo_pes`: Embroidery machine files
- `names`: Names/labels file

Files stored in `public/system/:attachment/:id/:style/:basename.:extension`

### Routes Structure
RESTful resources with custom AJAX endpoints in `javascripts_controller`:
- Standard resources: `disenos`, `colores`, `hilos`, `letters` (show only)
- Custom AJAX routes: `add_hilos`, `add_colors`, `colores`, `email_image`, `timeline`
- Root path: `disenos#index`

## Development Commands

### Docker Compose Setup (Recommended)

First-time setup:
```bash
# Copy environment variables template
cp .env.example .env

# Start services (builds images if needed)
docker-compose up -d

# Wait for services to be healthy, then setup database
./docker/db_setup.sh

# View logs
docker-compose logs -f web
```

Common Docker Compose commands:
```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# Rebuild containers (after Gemfile changes)
docker-compose build

# View logs
docker-compose logs -f

# Access Rails console
docker-compose exec web bundle exec rails console

# Run migrations
docker-compose exec web bundle exec rake db:migrate

# Run tests
docker-compose exec web bundle exec rake test

# Access MySQL console
docker-compose exec db mysql -u root -ppassword hilos_development

# Restart services
docker-compose restart
```

### Local Development (without Docker)

If running locally without Docker, ensure MySQL 8 is installed and running:
```bash
# Set environment variables (or use .env file)
export DB_HOST=localhost
export DB_USERNAME=root
export DB_PASSWORD=your_password

# Development server
bundle exec rails server

# Console access
bundle exec rails console
```

### Database
```bash
# Create databases
bundle exec rake db:create

# Run migrations
bundle exec rake db:migrate

# Load schema
bundle exec rake db:schema:load

# Seed database
bundle exec rake db:seed

# Drop and recreate database
bundle exec rake db:reset
```

### Testing
```bash
# Run all tests
bundle exec rake test

# Run specific test file
bundle exec ruby -I test test/unit/diseno_test.rb

# Run functional tests
bundle exec rake test:functionals

# Run unit tests
bundle exec rake test:units
```

Test structure:
- `test/unit/`: Model tests
- `test/functional/`: Controller tests
- `test/integration/`: Integration tests
- `test/fixtures/`: Test data

## Notable Dependencies

- **mysql2** (~> 0.5.3): MySQL database adapter for MySQL 8
- **haml** (4.0.4): Template engine
- **kt-paperclip** (~> 6.4): File attachments (updated fork of paperclip)
- **timeline_fu** (0.3.0): Activity timeline tracking
- **exception_notification** (~> 4.2): Error notifications
- **jquery-rails** (~> 4.3): jQuery integration

## Asset Pipeline

Assets organized in `app/assets/`:
- `javascripts/`: JavaScript files (uses CoffeeScript)
- `stylesheets/`: SASS stylesheets
- `images/`: Image assets

## Localization

Translations in `config/locales/`. Uses I18n for timeline events (e.g., `design.timeline.new`, `design.timeline.edit`)

## Custom Vendor Plugins

- **coto_solutions**: Custom caching and helper utilities
- **auto_complete**: Autocomplete functionality
- **translate**: Translation management
- **selenium-on-rails**: Selenium testing integration
- **exception_notification**: Exception handling

## Environment Variables

The application uses environment variables for database configuration. See `.env.example` for all available variables.

### Required Variables:
- `DB_HOST`: Database host (default: `db` for Docker, `localhost` for local)
- `DB_USERNAME`: Database username (default: `root`)
- `DB_PASSWORD`: Database password (default: `password`)
- `DB_NAME`: Database name prefix (default: `hilos_development`)
- `RAILS_ENV`: Rails environment (development, test, production)

### Optional Variables:
- `RAILS_MAX_THREADS`: Database connection pool size (default: 5)
- `SECRET_KEY_BASE`: Secret key for production (generate with `bundle exec rake secret`)

## Database Configuration

The application uses MySQL 8 with the following configuration:
- **Encoding**: UTF-8 (utf8mb4) for full Unicode support including emoji
- **Collation**: utf8mb4_unicode_ci
- **Connection Pool**: Configurable via RAILS_MAX_THREADS (default: 5)
- **Authentication**: mysql_native_password plugin for MySQL 8 compatibility

### Docker Compose Services:
- **db**: MySQL 8.0 service with persistent volume storage
- **web**: Rails application service dependent on database health

### Persistent Storage:
- MySQL data: Docker volume `mysql_data`
- Bundler cache: Docker volume `bundle_cache`
- Application files: Bind mount to local directory

## Important Notes

- Application module name is `Hilos` (see `config/application.rb:9`)
- Sphinx search configuration exists but is commented out in models (`define_index` blocks)
- Email configuration in `config/initializers/email.rb` and `setup_email.rb`
- Custom inflections defined in `config/initializers/inflections.rb`
- Uses `timeline_fu` fires for tracking create/update events on Diseno model
- MySQL 8 uses `mysql_native_password` for compatibility with mysql2 gem
