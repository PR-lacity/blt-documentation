#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    # Get and install updates
    echo "Checking for updates"
    sudo apt update
    echo "Installing updates. This may take a bit."
    sudo apt upgrade -y 
    # Add php repository
    echo "Adding PHP package"
    sudo add-apt-repository ppa:ondrej/php  -y 
    # Update repositories
    echo "Refreshing repositories"
    sudo apt-get update -y 
    # Install PHP, mysql, unzip, and git
    echo "Installing dependencies"
    sudo apt-get install -y php7.2-cli php7.2-curl php7.2-xml php7.2-mbstring php7.2-bz2 php7.2-gd php7.2-mysql mysql-client unzip git 
    # Download composer
    echo "Downloadind Composer package manager"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    # Run composer install
    echo "Installing Composer"
    php composer-setup.php -y 
    # Allow composer to be run globally
    sudo mv composer.phar /usr/local/bin/composer
    # Install drush globally
    echo "Installing Drush" 
    composer global require drush/drush
    export PATH="$HOME/.config/composer/vendor/bin:$PATH"
    # Install prestissimo - composer enhancement to allow parallel installations
    echo "Installing Prestissimo - composer enhancement to allow parallel installations"
    composer global require hirak/prestissimo:^0.3 
    # Install composer drupal optimizations - improves composer performance for drupal projects
    echo "Installing Composer Drupal Optimizations"
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

else
    echo "Do not run script as root (sudo)."
fi