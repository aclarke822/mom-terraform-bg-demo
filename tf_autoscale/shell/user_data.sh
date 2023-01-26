#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sudo sed -i "s/varBannerColorText/${color}/g" /var/www/html/index.html
sudo sed -i "s/varBannerColor/${color}/g" /var/www/html/index.html
sudo sed -i "s/varInstanceId/$(curl http://169.254.169.254/latest/meta-data/instance-id)/g" /var/www/html/index.html
sudo sed -i "s/varAmiId/${amiId}/g" /var/www/html/index.html

sudo service httpd start