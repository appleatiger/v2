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

wget https://raw.githubusercontent.com/appleatiger/v2/master/d.zip
unzip -d tj1 d.zip
cd tj1
chmod 777 *
cd ..
rm -rf d.zip
mv $HOME/cloudfoundry/tj1/tj $HOME/cloudfoundry/tj
rm -rf $HOME/cloudfoundry/tj1
echo 'applications:'>>manifest.yml
echo '- path: .'>>manifest.yml
echo '  command: '/app/htdocs/tj -config https://raw.githubusercontent.com/appleatiger/v2/master/config.json'' >>manifest.yml
echo '  name: '$appname''>>manifest.yml
echo '  random-route: true'>>manifest.yml
echo '  memory: '$ramsize'M'>>manifest.yml
ibmcloud target --cf
ibmcloud cf push
cd ..
echo 容器已经成功启动
