# Development Dockerfile for Rails 4.2 application
FROM ruby:2.3.8

# Update apt sources to use Debian archive (Stretch is EOL)
RUN sed -i 's|http://deb.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    echo 'APT::Get::AllowUnauthenticated "true";' > /etc/apt/apt.conf.d/99allow-unauthenticated

# Install dependencies
RUN apt-get update -o Acquire::AllowInsecureRepositories=true -qq && apt-get install -y \
  build-essential \
  default-libmysqlclient-dev \
  default-mysql-client \
  nodejs \
  imagemagick \
  libmagickwand-dev \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install bundler version that matches Gemfile.lock
RUN gem install bundler -v 1.15.4

# Copy Gemfile
COPY Gemfile ./

# Install gems (generate new Gemfile.lock for Rails 4.2.11.3)
RUN bundle install

# Copy application code
COPY . .

# Create directories for file uploads
RUN mkdir -p public/system tmp/cache

# Expose port 3000
EXPOSE 3000

# Start the Rails server in development mode
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
