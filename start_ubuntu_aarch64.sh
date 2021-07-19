#!/bin/bash

#common script

name=$1
config_dir=/home/$name/.config

echo "USER NAME IS $name"
cd  $(dirname $0)

#install

apt update
apt upgrade -y
apt install -y git vim curl gcc fcitx-mozc $(check-language-support) openssh-server guake python3-pip expect

#locale setting

localectl set-locale LANG=ja_JP.UTF-8
im-config -n fcitx
