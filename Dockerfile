# Use an official PHP 8 image with FPM
FROM php:8.2-fpm

# Install required packages
RUN apt-get update && apt-get install -y \
    nginx \
    unzip \
    curl \
    git \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    && docker-php-ext-configure gd \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_mysql zip mbstring

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . /var/www/html

# Copy Nginx configuration
COPY ./nginx.conf /etc/nginx/nginx.conf

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

ENV TZ="Asia/Bangkok"

# Start PHP-FPM and Nginx
CMD service nginx start && php-fpm
