#/bin/bash
if [[ "$EUID" -ne 0 ]]
  then echo "Please run as root"
  exit
fi
sudo add-apt-repository ppa:ondrej/php 
sudo apt-get update
sudo apt-get install -y php7.2-cli php7.2-curl php7.2-xml php7.2-mbstring php7.2-bz2 php7.2-gd php7.2-mysql mysql-client unzip git
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
sudo mv composer.phar /usr/local/bin/composer
composer global require drush/drush
composer global require hirak/prestissimo:^0.3
composer global require zaporylie/composer-drupal-optimizations:^1.1
echo Enter git email
read gitEmail
git config --global user.email "$gitEmail"
echo Enter git username
read gitName
git config --global user.name "$gitName"
