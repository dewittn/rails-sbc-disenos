# Prompt: Migrate Rails Application to MySQL 8 with Docker Compose

Please update this Rails 3.1.0 application to use MySQL 8 instead of SQLite3, with full Docker Compose integration for development.

## Requirements

### 1. Database Configuration
- Replace SQLite3 with MySQL 8 as the database
- Configure database.yml for development, test, and production environments
- Use MySQL 8 compatible settings and character encoding (utf8mb4)
- Set up proper connection pooling and timeout settings

### 2. Gemfile Updates
- Replace `sqlite3` gem with `mysql2` gem (use a version compatible with Rails 3.1 and Ruby 1.9.3)
- Ensure the mysql2 gem version is compatible with MySQL 8

### 3. Docker Compose Setup
- Add a MySQL 8 service to docker-compose.yml
- Configure persistent volume for MySQL data
- Set up proper environment variables for MySQL credentials
- Configure the Rails service to depend on and link to the MySQL service
- Add health checks to ensure MySQL is ready before Rails starts
- Use appropriate network configuration for service communication

### 4. Dockerfile Updates
- Add MySQL client libraries and development headers to the Dockerfile
- Ensure all dependencies needed to build the mysql2 gem are installed
- Update any build steps as needed

### 5. Database Initialization
- Provide instructions or scripts for initial database setup
- Include commands for creating databases, running migrations, and seeding data
- Consider adding a database initialization script or rake task

### 6. Environment Variables
- Use environment variables for database credentials (don't hardcode)
- Set sensible defaults for development while allowing production overrides
- Document all required environment variables

### 7. Migration Path
- Provide clear instructions for migrating existing SQLite data to MySQL (if needed)
- Document the steps to set up the database from scratch
- Include commands for development setup

### 8. Testing
- Ensure test environment uses a separate MySQL database
- Update any test configuration as needed
- Verify all tests pass with the new database

### 9. Documentation
- Update CLAUDE.md with new database information
- Update README if one exists
- Document Docker Compose commands for common operations
- Add troubleshooting section for common MySQL/Docker issues

## Constraints

- Maintain compatibility with Ruby 1.9.3-p286
- Maintain compatibility with Rails 3.1.0
- Preserve all existing functionality
- Don't modify core application logic unless necessary for MySQL compatibility
- Keep development workflow simple with Docker Compose

## Expected Deliverables

1. Updated Gemfile and Gemfile.lock
2. Updated config/database.yml
3. Updated docker-compose.yml with MySQL 8 service
4. Updated Dockerfile with MySQL dependencies
5. Database initialization script or documentation
6. Updated CLAUDE.md documentation
7. Sample .env file or environment variable documentation

## Additional Considerations

- Check for any SQLite-specific SQL queries in the codebase and update for MySQL
- Verify that the Paperclip attachment paths work correctly with MySQL
- Test the caching layer (acts_as_cached) works with MySQL
- Ensure timeline_fu gem compatibility with MySQL
- Check that all date/time handling is MySQL compatible

Please implement these changes systematically, test thoroughly, and provide clear documentation for developers setting up the project for the first time.
