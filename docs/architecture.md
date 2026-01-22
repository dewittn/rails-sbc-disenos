# Architecture

Technical overview of Diseños, an embroidery design management system.

## Technology Stack

- **Ruby**: 2.3.8 (configured in Dockerfile)
- **Rails**: 4.2.11.3
- **Database**: MySQL 8.0 (development, test, production)
- **Template Engine**: Haml 4.0.4
- **File Attachments**: kt-paperclip ~6.4 (updated fork of Paperclip)
- **Timeline Tracking**: timeline_fu 0.3.0
- **Containerization**: Docker & Docker Compose

## Domain Model

### Core Entities

**Diseno (Design)**
- Main entity representing an embroidery design
- Has multiple file attachments via Paperclip
- Has many `hilos` (threads) through join model
- Uses `timeline_fu` for activity tracking

**Hilo (Thread)**
- Join model connecting designs to colors
- Belongs to both `diseno` and `color`

**Color**
- Thread color definitions with hex codes
- Associated with a `marca` (brand)

**Marca (Brand)**
- Thread brand/manufacturer
- Has many colors

**TimelineEvent**
- Activity timeline tracking using the `timeline_fu` gem
- Tracks create and update events on Diseno model

### Domain Relationships

```
Marca (Brand)
  └── has many Colors
        └── has many Hilos (through)
              └── belongs to Diseno (Design)
                    └── has many TimelineEvents
```

## File Attachments

Uses Paperclip gem for handling file uploads. Diseno model has multiple attachments:

| Attachment      | Purpose                           | Styles                      |
| --------------- | --------------------------------- | --------------------------- |
| `image`         | Design preview image              | medium: 300x300, small: 100x100 |
| `original`      | Original image file               | N/A                         |
| `archivo_dst`   | Embroidery machine file (DST format) | N/A                      |
| `archivo_pes`   | Embroidery machine file (PES format) | N/A                      |
| `names`         | Names/labels file                 | N/A                         |

Files are stored in: `public/system/:attachment/:id/:style/:basename.:extension`

## Custom Plugin: coto_solutions

Located in `vendor/plugins/coto_solutions/`, this custom plugin provides:

### acts_as_cached

Model-level caching with automatic cache invalidation on save/destroy.

Adds the following class methods to models:
- `all_cached` - Returns cached version of all records
- `delete_cached` - Clears cache for model
- `detect_from_cached` - Find record from cached collection

### CotoHelper

Helper methods available across all views.

### PathPrefix

JavaScript asset utilities for path management.

## Routes Structure

RESTful resources with custom AJAX endpoints:

| Resource Type | Resources                                                   |
| ------------- | ----------------------------------------------------------- |
| Standard      | `disenos`, `colores`, `hilos`, `letters` (show only)        |
| Custom AJAX   | `add_hilos`, `add_colors`, `colores`, `email_image`, `timeline` |
| Root          | `disenos#index`                                             |

## Asset Pipeline

Assets organized in `app/assets/`:

- `javascripts/` - JavaScript files (uses CoffeeScript)
- `stylesheets/` - SASS stylesheets
- `images/` - Image assets

## Localization

Translations in `config/locales/`. Uses I18n for timeline events:

- `design.timeline.new`
- `design.timeline.edit`

Spanish and English supported.

## Database Configuration

The application uses MySQL 8 with the following configuration:

- **Encoding**: UTF-8 (utf8mb4) for full Unicode support including emoji
- **Collation**: utf8mb4_unicode_ci
- **Connection Pool**: Configurable via RAILS_MAX_THREADS (default: 5)
- **Authentication**: mysql_native_password plugin for MySQL 8 compatibility

### Docker Compose Services

**db service:**
- MySQL 8.0 with persistent volume storage
- Health check ensures database is ready before Rails starts

**web service:**
- Rails application dependent on database health
- Mounts application directory for live code reloading

### Persistent Storage

- MySQL data: Docker volume `mysql_data`
- Bundler cache: Docker volume `bundle_cache`
- Application files: Bind mount to local directory

## Notable Dependencies

| Gem | Version | Purpose |
|-----|---------|---------|
| mysql2 | ~0.5.3 | MySQL database adapter for MySQL 8 |
| haml | 4.0.4 | Template engine |
| kt-paperclip | ~6.4 | File attachments (updated fork) |
| timeline_fu | 0.3.0 | Activity timeline tracking |
| exception_notification | ~4.2 | Error notifications |
| jquery-rails | ~4.3 | jQuery integration |

## Custom Vendor Plugins

Located in `vendor/plugins/`:

- **coto_solutions** - Custom caching and helper utilities
- **auto_complete** - Autocomplete functionality
- **translate** - Translation management
- **selenium-on-rails** - Selenium testing integration
- **exception_notification** - Exception handling

## Key Design Decisions

### Why Paperclip for File Uploads?

Paperclip was the standard Rails file upload solution when this application was built (2009-2011). It provided:
- Simple attachment API
- Multiple file versions/styles
- Validation support
- Easy storage configuration

While Paperclip is now deprecated, this application uses `kt-paperclip`, an actively maintained fork.

### Why Custom Caching Plugin?

The `acts_as_cached` plugin was built before Rails had sophisticated caching built-in. It provided:
- Simple model-level caching
- Automatic cache invalidation
- Transparent caching API

### Why timeline_fu for Activity Tracking?

Timeline_fu provided a simple DSL for tracking model changes:
- Automatic event creation on model callbacks
- I18n support for event descriptions
- Clean separation of concerns

## System Integrations

### Production Deployment (2009-2011)

The application was deployed and maintained remotely via:
- **Hamachi VPN** - Remote network access
- **Capistrano** - Automated deployment
- **NewRelic** - Production monitoring

### Search (Disabled)

Sphinx search configuration exists but is commented out in models (`define_index` blocks). The application currently uses basic database queries for search.

## Important Notes

- Application module name is `Hilos` (see `config/application.rb:9`)
- Email configuration in `config/initializers/email.rb` and `setup_email.rb`
- Custom inflections defined in `config/initializers/inflections.rb`
- Uses `timeline_fu` fires for tracking create/update events on Diseno model

## See Also

- [Development Guide](development.md) - Setup and workflow
- [Main README](../README.md) - Project overview
- [CLAUDE.md](../CLAUDE.md) - Complete technical documentation
