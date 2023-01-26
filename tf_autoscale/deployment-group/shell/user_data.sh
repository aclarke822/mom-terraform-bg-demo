#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sudo sed -i "s/varBannerColorText/${blue_or_green}/g" /var/www/html/index.html
sudo sed -i "s/varBannerVersionText/${version}/g" /var/www/html/index.html
sudo sed -i "s/varBannerColor/${rgb}/g" /var/www/html/index.html
sudo sed -i "s/varInstanceId/$(curl http://169.254.169.254/latest/meta-data/instance-id)(${ami})/g" /var/www/html/index.html

sudo service httpd start