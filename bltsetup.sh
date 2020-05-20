#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    # Get and install updates
    echo "==================================================="
    echo "Checking for updates"
    echo "==================================================="
    echo ""
    sudo apt update
    echo "==================================================="
    echo "Installing updates. This may take a bit."
    echo "==================================================="
    echo ""
    sudo apt upgrade -y 
    # Add php repository
    echo "==================================================="
    echo "Adding PHP package"
    echo "==================================================="
    echo ""
    sudo add-apt-repository ppa:ondrej/php  -y 
    # Update repositories
    echo "==================================================="
    echo "Refreshing repositories"
    echo "==================================================="
    echo ""
    sudo apt-get update -y 
    # Install PHP, mysql, unzip, and git
    echo "==================================================="
    echo "Installing dependencies"
    echo "==================================================="
    echo ""
    sudo apt-get install -y php7.2-cli php7.2-curl php7.2-xml php7.2-mbstring php7.2-bz2 php7.2-gd php7.2-mysql mysql-client unzip git 
    # Download composer
    echo "==================================================="
    echo "Downloading Composer package manager"
    echo "==================================================="
    echo ""
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    # Run composer install
    echo "==================================================="
    echo "Installing Composer"
    echo "==================================================="
    echo ""
    php composer-setup.php -y 
    # Allow composer to be run globally
    sudo mv composer.phar /usr/local/bin/composer
    # Install prestissimo - composer enhancement to allow parallel installations
    echo "==================================================="
    echo "Installing Prestissimo"
    echo "==================================================="
    echo ""
    composer global require hirak/prestissimo:^0.3 
    # Install composer drupal optimizations - improves composer performance for drupal projects
    echo "==================================================="
    echo "Installing Composer Drupal Optimizations"
    echo "==================================================="
    echo ""
    composer global require zaporylie/composer-drupal-optimizations:^1.1 
    # Install drush globally
    echo "==================================================="
    echo "Installing Drush" 
    echo "==================================================="
    echo ""
    composer global require drush/drush
    echo "==================================================="
    echo "Adding drush to system path"
    echo "==================================================="
    echo ""
    echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc
    echo ""
    echo ""
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
    echo "==================================================="
    echo "Clearing composer cache"
    echo "==================================================="
    echo ""
    composer clear-cache
    # Set composer timeout
    # echo "==================================================="
    # echo "Setting composer timeout"
    # echo "==================================================="
    # echo ""
    # echo 'export COMPOSER_PROCESS_TIMEOUT=2000'
    # unlink composer setup
    php -r "unlink('composer-setup.php');"

    echo "Done.  To finsh setup, run the following command from powershell as administrator, then relaunch WSL."
    echo "Get-Service LxssManager | Restart-Service"
else
    echo "Do not run script as root (sudo)."
fi