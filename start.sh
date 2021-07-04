#!/bin/bash

cd $(dirname $0)

#OS search
if [[ -e /etc/os-release ]];then
	OSname=$(cat /etc/os-release |grep ^NAME |sed -e 's/.*="//g' -e 's/"//g')
fi

OSname=${OSname:="NULL"}

if [[ $OSname = "NULL" ]];then
	echo -e "\nOS can't search \nprease try again \n"
elif [[ $OSname = "Raspbian GNU/Linux"  ]];then
	echo -e "\nOS is Raspbian GNU/Linux \n"
		sudo ./start_raspberry.sh $(whoami)
		./start_rust.sh
elif [[ $OSname = "Ubuntu" ]];then
	if [[ $(sudo dmesg | grep Hyper-V -c) -eq 0 ]];then
		echo -e "\nOS is Ubuntu \n"
		sudo ./start_ubuntu.sh $(whoami)
		./start_rust.sh
	else
		echo -e "\nOS is Ubuntu (in HyperV)\n"
		sudo ./start_ubuntu_v.sh $(whoami)
		./start_rust.sh
	fi
else
	OSname=$(echo $OSname| sed -e "s/^a//g")
	echo -e "\n $OSname isn't supported \n"
fi
