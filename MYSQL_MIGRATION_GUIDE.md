# MySQL 8 Migration Guide

This guide documents the migration from SQLite3 to MySQL 8 with Docker Compose for the Hilos Rails application.

## Summary of Changes

### 1. Gemfile Updates
- **Replaced**: `sqlite3 (~> 1.3.6)` → `mysql2 (~> 0.5.3)`
- The mysql2 gem is compatible with both Rails 4.2 and MySQL 8

### 2. Database Configuration (`config/database.yml`)
- Switched adapter from `sqlite3` to `mysql2`
- Configured UTF-8 support with `utf8mb4` encoding and `utf8mb4_unicode_ci` collation
- Added environment variable support for all database credentials
- Configured `mysql_native_password` authentication plugin for MySQL 8 compatibility
- Set connection pool size to 5 (configurable via `RAILS_MAX_THREADS`)

### 3. Dockerfile Updates
- **Replaced**: `libsqlite3-dev` → `default-libmysqlclient-dev` and `default-mysql-client`
- Added MySQL client libraries needed to build the mysql2 gem

### 4. Docker Compose Configuration
- Added MySQL 8.0 service with:
  - Persistent volume storage (`mysql_data`)
  - Health checks to ensure database readiness
  - Initialization script support
  - Environment variable configuration
- Updated web service to:
  - Depend on healthy database service
  - Wait for MySQL to be ready before starting Rails
  - Pass database credentials via environment variables
- Added dedicated network (`rails-network`) for service communication
- **Port Mappings**:
  - MySQL: `3307:3306` (external:internal) - uses 3307 to avoid conflicts with local MySQL
  - Rails: `3000:3000`

### 5. Database Initialization
- Created `docker/mysql/init.sql` script that:
  - Creates databases for all environments (development, test, production)
  - Sets UTF-8 character encoding (utf8mb4)
  - Grants necessary privileges
- Created `docker/db_setup.sh` script for initial database setup:
  - Waits for MySQL to be ready
  - Creates databases
  - Runs migrations
  - Seeds data (if seed file exists)

### 6. Environment Configuration
- Created `.env.example` template with all required variables
- Added `.env` to `.gitignore` for security
- **Default Values**:
  - `DB_HOST=db`
  - `DB_USERNAME=root`
  - `DB_PASSWORD=password`
  - `DB_NAME=hilos_development`

### 7. Documentation Updates
- Updated `CLAUDE.md` with:
  - New database information (MySQL 8)
  - Docker Compose commands
  - Environment variable documentation
  - Local development instructions
  - Updated Ruby version (2.3.8) and Rails version (4.2.11.3)

## Setup Instructions

### First-Time Setup

1. **Copy Environment Variables**:
   ```bash
   cp .env.example .env
   # Edit .env if you want to change default values
   ```

2. **Start Docker Services**:
   ```bash
   # Build and start services
   docker-compose up -d
   ```

3. **Initialize Database**:
   ```bash
   # Wait for MySQL to be healthy, then run setup
   ./docker/db_setup.sh
   ```

4. **Verify Application**:
   ```bash
   # Check logs
   docker-compose logs -f web

   # Access application at http://localhost:3000
   ```

### Daily Development

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f web

# Rails console
docker-compose exec web bundle exec rails console

# Run migrations
docker-compose exec web bundle exec rake db:migrate

# Run tests
docker-compose exec web bundle exec rake test

# Access MySQL directly
docker-compose exec db mysql -u root -ppassword hilos_development
```

## Migration from SQLite to MySQL

If you have existing SQLite data that needs to be migrated:

1. **Export SQLite Data**:
   ```bash
   # Dump data to SQL
   sqlite3 db/development.sqlite3 .dump > sqlite_dump.sql
   ```

2. **Convert and Import** (manually adapt SQLite SQL to MySQL syntax):
   - Remove SQLite-specific syntax
   - Adjust data types if necessary
   - Import into MySQL using `docker-compose exec`

3. **Alternative: Use Rails Migration**:
   ```ruby
   # Create a migration to copy data from old models
   # This approach is more reliable for complex data
   ```

## Troubleshooting

### Port Conflicts

If you see "port is already allocated" errors:

**MySQL (3306)**:
- The docker-compose.yml uses port 3307 externally to avoid conflicts
- If this still conflicts, change the mapping in docker-compose.yml

**Rails (3000)**:
```bash
# Find and kill process using port 3000
lsof -ti:3000 | xargs kill -9
```

### Database Connection Issues

```bash
# Check MySQL service health
docker-compose ps

# View MySQL logs
docker-compose logs db

# Verify database exists
docker-compose exec db mysql -u root -ppassword -e "SHOW DATABASES;"
```

### Permission Issues

```bash
# Rebuild containers with no cache
docker-compose down -v
docker-compose build --no-cache
docker-compose up -d
```

### MySQL 8 Authentication Issues

The configuration uses `mysql_native_password` plugin for compatibility. If you still have authentication issues:

```bash
# Access MySQL
docker-compose exec db mysql -u root -ppassword

# Run these SQL commands:
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'password';
FLUSH PRIVILEGES;
```

## Verification Checklist

- [ ] Docker containers start successfully
- [ ] MySQL service is healthy
- [ ] Rails connects to MySQL database
- [ ] Migrations run successfully
- [ ] Application loads at http://localhost:3000
- [ ] Can create/read/update/delete records
- [ ] Tests pass with new database
- [ ] File attachments work correctly
- [ ] Timeline tracking works

## Code Compatibility

The codebase was analyzed for SQLite-specific queries:
- **Result**: No SQLite-specific SQL found in application code
- All queries use ActiveRecord DSL, which is database-agnostic
- Migrations use standard Rails migration syntax compatible with both databases

## Performance Considerations

- MySQL 8 provides better performance for concurrent access
- utf8mb4 encoding supports full Unicode including emoji
- Connection pooling configured for optimal resource usage
- Persistent volumes ensure data survives container restarts

## Production Deployment

For production deployment:

1. **Use Strong Passwords**: Change all default passwords in `.env`
2. **Secrets**: Generate new `SECRET_KEY_BASE` with `bundle exec rake secret`
3. **Database**: Use managed MySQL service (AWS RDS, Google Cloud SQL, etc.)
4. **Environment Variables**: Set all variables without defaults
5. **Backup**: Implement regular database backup strategy
6. **SSL**: Configure SSL/TLS for database connections

## Rollback Plan

If you need to rollback to SQLite:

1. Restore original `Gemfile`, `database.yml`, and `Dockerfile`
2. Run `bundle install`
3. Restore SQLite database files from backup
4. Restart application

## Additional Resources

- [MySQL 8 Documentation](https://dev.mysql.com/doc/refman/8.0/en/)
- [mysql2 Gem](https://github.com/brianmario/mysql2)
- [Rails Database Configuration](https://guides.rubyonrails.org/configuring.html#configuring-a-database)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
