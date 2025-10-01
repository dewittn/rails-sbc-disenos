# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Rails 3.1.0 application (named "Hilos") for managing embroidery designs (diseños). The application tracks designs with their associated thread colors (hilos), supports file attachments for design files (DST/PES formats), and includes timeline tracking functionality.

**Ruby Version:** 1.9.3-p286 (configured in Dockerfile)
**Database:** SQLite3 (development, test, production)

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

### Server
```bash
# Development server
bundle exec rails server

# Using Docker (Ruby 1.9.3-p286)
docker build -t rails-sbc-disenos .
docker run -p 3000:3000 rails-sbc-disenos
```

### Database
```bash
# Run migrations
bundle exec rake db:migrate

# Load schema
bundle exec rake db:schema:load

# Seed database
bundle exec rake db:seed

# Console access
bundle exec rails console
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

- **haml** (4.0.4): Template engine
- **paperclip** (4.2.2): File attachments
- **timeline_fu** (0.3.0): Activity timeline tracking
- **exception_notification_rails3**: Error notifications
- **jquery-rails** (3.1.4): jQuery integration

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

## Important Notes

- Application module name is `Hilos` (see `config/application.rb:9`)
- Sphinx search configuration exists but is commented out in models (`define_index` blocks)
- Email configuration in `config/initializers/email.rb` and `setup_email.rb`
- Custom inflections defined in `config/initializers/inflections.rb`
- Uses `timeline_fu` fires for tracking create/update events on Diseno model
