# bash script
#/bin/bash
# Get and install updates
sudo apt update && sudo apt upgrade
# Add php repository
sudo add-apt-repository ppa:ondrej/php 
# Update repositories
sudo apt-get update
# Install PHP, mysql, unzip, and git
sudo apt-get install -y php7.2-cli php7.2-curl php7.2-xml php7.2-mbstring php7.2-bz2 php7.2-gd php7.2-mysql mysql-client unzip git
# Download composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# Run composer install
php composer-setup.php
# Allow composer to be run globally
sudo mv composer.phar /usr/local/bin/composer
# Install drush globally
composer global require drush/drush
# Install prestissimo - composer enhancement to allow parallel installations
composer global require hirak/prestissimo:^0.3
# Install composer drupal optimizations - improves compooser performance for drupal projects
composer global require zaporylie/composer-drupal-optimizations:^1.1
# Prompt user to enter git email address
echo Enter git email
# Get user input for git email.  
# Add input validation
read gitEmail
# Set git email
git config --global user.email "$gitEmail"
# Prompt user to enter git username
echo Enter git username
# Get user input for git username
read gitName
# Set git username
git config --global user.name "$gitName"
# End of script