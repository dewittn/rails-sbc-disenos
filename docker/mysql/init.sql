-- MySQL 8 Initialization Script for Hilos Application
-- This script runs automatically when MySQL container is first created

-- Create databases for all environments
CREATE DATABASE IF NOT EXISTS hilos_development CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS hilos_test CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS hilos_production CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Grant all privileges on databases to root user
GRANT ALL PRIVILEGES ON hilos_development.* TO 'root'@'%';
GRANT ALL PRIVILEGES ON hilos_test.* TO 'root'@'%';
GRANT ALL PRIVILEGES ON hilos_production.* TO 'root'@'%';

-- Flush privileges to ensure they take effect
FLUSH PRIVILEGES;

-- Display success message
SELECT 'Databases created successfully!' AS message;
