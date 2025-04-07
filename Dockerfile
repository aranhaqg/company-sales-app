# syntax=docker/dockerfile:1
# Development Dockerfile for Rails application

# Base image with Ruby
ARG RUBY_VERSION=3.3.6
FROM ruby:$RUBY_VERSION-slim AS base

# Set working directory
WORKDIR /app

# Define build arguments
ARG DB_USERNAME=postgres
ARG DB_PASSWORD=postgres
ARG DB_NAME=company-sales-db-dev

# Set environment variables
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="production" \
    DB_USERNAME=${DB_USERNAME} \
    DB_PASSWORD=${DB_PASSWORD} \
    DB_NAME=${DB_NAME}

# Install base dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    postgresql-client \
    build-essential \
    git \
    libpq-dev \
    libyaml-dev \
    pkg-config \
    nodejs \
    npm && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application code
COPY . .

# Expose port 4000 for the Rails server
EXPOSE 4000

# Entrypoint script to prepare the database and start the server
ENTRYPOINT ["./bin/docker-entrypoint"]

# Default command to start the Rails server
CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "4000"]
