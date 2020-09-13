#!/bin/sh 
read -p "请输入应用程序名称:" appname
read -p "请设置你的容器内存大小(默认64):" ramsize
if [ -z "$ramsize" ];then
	ramsize=64
fi
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

wget https://raw.githubusercontent.com/appleatiger/v2/main/d.zip
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
domain=`ibmcloud cf app $appname | grep routes | cut -f2 -d':' | sed 's/ //g'`
vmess=`echo '{"add":"'$domain'","aid":"64","host":"","id":"'$uuid'","net":"ws","path":"/'$path'","port":"443","ps":"IBM_Cloud","tls":"tls","type":"none","v":"2"}' | base64 -w 0`
cd ..
echo 容器已经成功启动
echo 地址: $domain
echo UUID: $uuid
echo path: /$path
echo vmess://$vmess