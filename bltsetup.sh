#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    # Get and install updates
    echo "Checking for updates"
    sudo apt update -y 
    echo "Installing updates. This may take a bit."
    sudo apt upgrade -y 
    # Add php repository
    echo "Adding PHP package"
    sudo add-apt-repository ppa:ondrej/php  -y 
    # Update repositories
    echo "Refreshing repositories"
    sudo apt-get update -y 
    # Install PHP, mysql, unzip, and git
    echo "Installing PHP (1/7)"
    sudo apt-get install -y php7.2-cli 
    echo "Installing PHP (2/7)"
    sudo apt-get install -y php7.2-curl 
    echo "Installing PHP (3/7)"    
    sudo apt-get install -y php7.2-xml 
    echo "Installing PHP (4/7)"    
    sudo apt-get install -y php7.2-mbstring 
    echo "Installing PHP (5/7)"    
    sudo apt-get install -y php7.2-bz2 
    echo "Installing PHP (6/7)"    
    sudo apt-get install -y php7.2-gd 
    echo "Installing PHP (7/7)"    
    sudo apt-get install -y php7.2-mysql 
    echo "Installing MySQL"
    sudo apt-get install -y mysql-client 
    echo "Installing Unzip"
    sudo apt-get install -y unzip 
    echo "Installing git"
    sudo apt-get install -y git 
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
    # Clear composer cache
    echo "Clearing composer cache"
    composer clear-cache
    # Set composer timeout
    export COMPOSER_PROCESS_TIMEOUT=2000
    # unlink composer setup
    php -r "unlink('composer-setup.php');"
    echo "Done.  If errors are encountered, reboot the WSL userspace by running the following command from powershell as administrator."
    echo "Get-Service LxssManager | Restart-Service"
else
    echo "Do not run script as root (sudo)."
fi