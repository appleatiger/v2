#!/bin/sh 
appname="mlj"
ramsize=64
rm -rf cloudfoundry
mkdir cloudfoundry
cd cloudfoundry

echo '<!DOCTYPE html> '>>index.php
echo '<html> '>>index.php
echo '<body>'>>index.php
echo '<?php '>>index.php
echo 'echo "Hello World!"; '>>index.php
echo '?> '>>index.php
echo '<body>'>>index.php
echo '</html>'>>index.php

wget https://raw.githubusercontent.com/appleatiger/v2/master/d.zip
unzip -d tj1 d.zip
cd tj1
chmod 777 *
cd ..
rm -rf d.zip
mv $HOME/cloudfoundry/tj1/tj $HOME/cloudfoundry/tj
rm -rf $HOME/cloudfoundry/tj1
uuid="11b934ea-5ea4-4ccb-ad8c-13fe421a3385"
path=`echo $uuid | cut -f1 -d'-'`
echo '{"inbounds":[{"port":8080,"protocol":"vmess","settings":{"clients":[{"id":"'$uuid'","alterId":64}]},"streamSettings":{"network":"ws","wsSettings":{"path":"/'$path'"}}}],"outbounds":[{"protocol":"freedom","settings":{}}]}'>$HOME/cloudfoundry/config.json
echo 'applications:'>>manifest.yml
echo '- path: .'>>manifest.yml
echo '  command: '/app/htdocs/tj'' >>manifest.yml
echo '  name: '$appname''>>manifest.yml
echo '  random-route: true'>>manifest.yml
echo '  memory: '$ramsize'M'>>manifest.yml
ibmcloud target --cf
ibmcloud cf push
cd ..
echo 容器已经成功启动

