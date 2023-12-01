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
    # Get php version to install
    echo "Enter php version to use. e.g. 7.3"
    echo "Entering an invalid version number will likely result in errors."
    read PHPver
    # Install PHP, mysql, unzip, and git
    echo "==================================================="
    echo "Installing dependencies using PHP " $PHPver 
    echo "==================================================="
    echo ""
    sudo apt-get install -y php$PHPver-cli
    sudo apt-get install -y php$PHPver-curl
    sudo apt-get install -y php$PHPver-xml
    sudo apt-get install -y php$PHPver-mbstring
    sudo apt-get install -y php$PHPver-bz2
    sudo apt-get install -y php$PHPver-gd
    sudo apt-get install -y php$PHPver-mysql
    sudo apt-get install -y php$PHPver-zip
    sudo apt-get install -y mysql-client
    sudo apt-get install -y unzip
    sudo apt-get install -y git 
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
    # Install drush globally
    echo "==================================================="
    echo "Installing Drush" 
    echo "==================================================="
    echo ""
    composer global require drush/drush
    echo "Setting environment variables for Drush"
    echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' | tee -a ~/.profile ~/.zprofile >/dev/null
    echo "==================================================="
    echo "Installing Acquia BLT"
    echo "==================================================="
    echo ""
    echo "Setting up BLT Launcher"
    wget -O blt.phar https://github.com/acquia/blt-launcher/releases/latest/download/blt.phar
    chmod +x blt.phar
    sudo mv blt.phar /usr/local/bin/blt
    # Prompt user to enter git email address
    echo "Enter git email"
    # Get user input for git email.  
    # Add input validation
    read gitEmail
    # Set git email
    git config --global user.email "$gitEmail"
    # Prompt user to enter git username
    echo "Enter git username"
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
    # export COMPOSER_PROCESS_TIMEOUT=2000
    # unlink composer setup
    php -r "unlink('composer-setup.php');"

    echo "Done.  To finsh setup, run the following command from powershell as administrator, then relaunch WSL."
    echo "Get-Service LxssManager | Restart-Service"
else
    echo "Do not run script as root (sudo)."
fi
