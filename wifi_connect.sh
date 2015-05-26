#!/bin/bash
############################
#Created By: Richard Jackson
#Date: 24 MAY 2015
############################

option=$1

#Include Settings
source settings.conf || flag=thrown

#Query for Process ID
wpa_pgrep=$(pgrep $PROGRAM)

if [ "$flag" = "thrown" ];
then
	echo "Error: Settings configuration incorrect!"
	exit 1
fi

kill_zombies(){
	if [ ! -z "$wpa_pgrep" ];
	then
		kill -9 $wpa_preg
	else
		echo "No zombies found..."
	fi
	}

reset_device(){
	echo "Device Reset"
	ifconfig $IFACE down && \
	sleep 1 && \
	ifconfig $IFACE up
	}

config_device(){
	ifconfig $IFACE $IPADDR netmask $NETMASK broadcast $BROADCAST up && \
	route add default gw $GW $IFACE
	echo -e "Setting the nameserver\n"
	printf "nameserver $DNS\n" | tee /etc/resolv.conf
	}

initialize(){
	kill_zombies
	ifconfig $IFACE up
	}

help_menu(){
	printf "eZWIFI CONNECT\n"
	printf "Config and Start\t[ start ]\n"
	printf "Initialize\t\t[ init ]\n"
	printf "Help Menu\t\t[ -h ]\n"
	}

case $option in
	start|-start)
	reset_device
	config_device
	;;
	init|-init)
	initialize
	;;
	-h)help_menu;;
	*)echo "Try '-h' to view options.";;
esac








##END OF SCRIPT##
