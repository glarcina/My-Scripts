#!/bin/sh

# Path to your certificate file
vpncert=/etc/openvpn/vpnloc/virylsw.ovpn

# Function to (dis)connect to Viryl's ADAPT VPN
#
# TODO: This script uses a killall command to disconnect from our one and
# 	only VPN network.  If you need to connect to multiple VPN's you'll
#	want to change this to be able to specify which network to control.
#	Likely will have to incorporate iptables + bash script.
# https://askubuntu.com/questions/589477/is-there-a-vpn-monitor-kill-switch-application-for-ubuntu
adaptvpn () {

    NC='\033[0m' # No Color
    RED='\033[0;31m'
    ORANGE='\033[0;33m'
    GREEN='\033[0;32m'
    CONNECT=$1

    if  [ -z "$1" ]; # if argument is not provided
    then
        echo "${RED}Please specify an action. connect or disconnect${NC}"

    elif [ $CONNECT = "connect" ];
    then
        # Kill all current connections
        sudo killall openvpn

        # Connect to VPN
        echo "${ORANGE}Connecting to ADAPT VPN...${NC}"
        sudo openvpn --config $vpncert --daemon
        echo "${GREEN}CONNNECTED${NC}!"

    elif [ $CONNECT = "disconnect" ];
    then
        echo "${ORANGE}Disconnecting from ADAPT VPN...${NC}"
        sudo killall openvpn
        echo "${GREEN}DISCONNECTED!${NC}"

    else
        echo "${RED}UNRECOGNIZED ARGUMENT"
    fi

}

# Call function
adaptvpn $1

