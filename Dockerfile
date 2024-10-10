# Use a basic PHP5 Apache image
FROM php:5.6-apache

# Update sources list to use the archived repositories over HTTP and avoid deb-src and stretch-updates
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list && \
    sed -i '/deb-src/d' /etc/apt/sources.list && \
    apt-get -o Acquire::Check-Valid-Until=false update && \
    apt-get install -y \
    libcurl4-openssl-dev \
    libxml2-dev \
    unzip \
    wget \
    zlib1g-dev \
    libmcrypt-dev \
    && docker-php-ext-install curl xml zip

# Install the mcrypt extension (mcrypt is deprecated in PHP 7 but available in PHP 5.6)
RUN docker-php-ext-install mcrypt

# Install and configure OpenSSL (to handle x509 certificates)
RUN apt-get install -y openssl

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80

# Copy the project files to the container
COPY . /var/www/html/

# Ensure the web server user can access the web root
RUN chown -R www-data:www-data /var/www/html
