#!/bin/sh

chown -R www-data:www-data /var/www/html/

# Download WordPress core if not already downloaded
wp --allow-root --path="/var/www/html/" core download || true

# Ensure wp-config.php is in place after downloading WordPress
if [ ! -f "/var/www/html/wp-config.php" ] || [ "$(grep -c 'WP_REDIS_HOST' /var/www/html/wp-config.php)" -eq 0 ]; then
    echo "Copying wp-config.php..."
    cp -f /tmp/wp-config.php /var/www/html/wp-config.php
    chown www-data:www-data /var/www/html/wp-config.php
fi

sleep 10

# Install WordPress if not already installed
if ! wp --allow-root --path="/var/www/html/" core is-installed;
then
    wp  --allow-root --path="/var/www/html/" core install \
        --url=$WP_URL \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL
fi;

# Ensure user exists
if ! wp --allow-root --path="/var/www/html/" user get $WP_USER;
then
    wp  --allow-root --path="/var/www/html/" user create \
        $WP_USER \
        $WP_EMAIL \
        --user_pass=$WP_PASSWORD \
        --role=$WP_ROLE
fi;

# Install and activate the Redis Object Cache plugin
wp --allow-root --path="/var/www/html/" plugin install redis-cache --activate

# Enable Redis caching (this should also work automatically after the plugin is activated)
wp --allow-root --path="/var/www/html/" redis enable

# Install and activate theme
wp --allow-root --path="/var/www/html/" theme install raft --activate 

# Start PHP-FPM
exec "$@"
