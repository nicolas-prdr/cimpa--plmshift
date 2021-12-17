#/bin/bash

set -e

DRUSH_VERSION=${DRUSH_VERSION:-^10.0}
DRUSH_LAUNCHER=${DRUSH_LAUNCHER:-0.9.3}
DRUPAL_VERSION=${DRUPAL_VERSION:-9.4.x}

mkdir -p /opt/app-root/bin

wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/${DRUSH_LAUNCHER}/drush.phar
chmod +x drush.phar
mv drush.phar /opt/app-root/bin/drush

curl https://drupalconsole.com/installer -L -o drupal.phar
chmod +x drupal.phar
mv drupal.phar /opt/app-root/bin/drupal

curl -sS https://getcomposer.org/installer | php -- --install-dir=/opt/app-root/bin --filename=composer

cd /opt/app-root

composer global require drush/drush:${DRUSH_VERSION};
composer clear-cache;

git clone https://github.com/drupal/recommended-project/ --branch=${DRUPAL_VERSION} drupal-dist
cd drupal-dist && rm -rf .git && composer install
cd /opt/app-root/src

fix-permissions ./
