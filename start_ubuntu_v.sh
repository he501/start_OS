#!/bin/bash

#common script

name=$1
config_dir=/home/$name/.config

echo "USER NAME IS $name"
cd  $(dirname $0)

wget -q -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/vscode.gpg
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-chrome.gpg

echo "deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

#install

apt update
apt upgrade -y
apt install -y git vim curl gcc fcitx-mozc $(check-language-support) openssh-server guake python3-pip google-chrome-stable code expect

#locale setting

localectl set-locale LANG=ja_JP.UTF-8
im-config -n fcitx

#guake setting

mkdir -p $config_dir/autostart
cp -frp autostart/guake.desktop $config_dir/autostart
chown -R "$name":"$name" $config_dir/autostart
chmod -R 664 $config_dir/autostart
chmod 700 $config_dir/autostart

#chrome setting

cp mimeapps.list $config_dir
chown "$name":"$name" $config_dir/mimeapps.list
chmod 664 $config_dir/mimeapps.list

#creso setting

cp ChangeResolution.sh /usr/bin/
chown root:root /usr/bin/ChangeResolution.sh
chmod 755 /usr/bin/ChangeResolution.sh
echo "alias sudo='sudo '" >>/home/$name/.bashrc
echo "alias creso=/usr/bin/ChangeResolution.sh" >>/home/$name/.bashrc

#oneko setting

echo 'PATH=$PATH:/usr/games' >> /etc/profile

#VScode setting

sudo -u $name code --install-extension vscodevim.vim
sudo -u $name code --install-extension rust-lang.rust
sudo -u $name code --install-extension eamodio.gitlens
sudo -u $name code --install-extension ms-vscode.cpptools
sudo -u $name code --install-extension vadimcn.vscode-lldb
sudo -u $name code --install-extension donjayamanne.githistory
sudo -u $name code --install-extension ms-ceintl.vscode-language-pack-ja

#comment

echo -e "\n\n<<< if you use VirtualBox , prease install Guest Additions CD >>>\n\n"
echo -e "\nA reboot is required to applay this script\n"
