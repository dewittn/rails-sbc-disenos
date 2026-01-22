# Diseños Documentation

Complete technical documentation for Diseños, an embroidery design management system.

## Getting Started

New to this project? Start here:

1. Read the main [README](../README.md) for project overview and quick start
2. Follow the [Development Guide](development.md) for detailed Docker workflow
3. Review [Architecture](architecture.md) to understand the system design

## Documentation Index

### Core Documentation

- **[Development Guide](development.md)** - Docker setup, database commands, testing, and development workflow
- **[Architecture](architecture.md)** - System design, domain models, custom plugins, and technical decisions

### Case Study

- **[Business Impact Analysis](case-study.md)** - Detailed analysis of how this system supported $1.55M in revenue over 6 years, including operational efficiency gains and design library cache effects

### Migration Documentation

Historical upgrade documentation (archived for reference):

- **[MySQL 8 Migration](migration/mysql8-upgrade.md)** - Upgrading from MySQL 5 to MySQL 8
- **[Rails 4.2 Compatibility](migration/rails-4.2-fixes.md)** - Compatibility fixes for Rails 4.2
- **[Upgrade Notes](migration/upgrade-notes.md)** - General upgrade documentation

## Quick Reference

### Common Commands

```bash
# Start development
docker-compose up -d

# Rails console
docker-compose exec web bundle exec rails console

# Run migrations
docker-compose exec web bundle exec rake db:migrate

# Run tests
docker-compose exec web bundle exec rake test
```

### Key Technologies

- Ruby 2.3.8
- Rails 4.2.11.3
- MySQL 8.0
- Paperclip for file attachments
- Haml templating
- Docker & Docker Compose

### Domain Models

- **Diseno** - Main entity for embroidery designs
- **Hilo** - Thread color assignments (join model)
- **Color** - Thread color definitions
- **Marca** - Thread brand/manufacturer
- **TimelineEvent** - Activity tracking

## Contributing to Documentation

When updating documentation:

1. Keep README.md concise (entry point only)
2. Detailed technical content belongs in docs/
3. Use clear, descriptive headings
4. Include code examples where helpful
5. Update this index when adding new docs

## File Organization

```
docs/
├── README.md           # This file - documentation index
├── development.md      # Development workflow and commands
├── architecture.md     # Technical design and architecture
├── case-study.md       # Business impact analysis
└── migration/          # Historical migration docs
    ├── mysql8-upgrade.md
    ├── rails-4.2-fixes.md
    └── upgrade-notes.md
```
