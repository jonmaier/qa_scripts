#!/bin/bash
#set -x
###############
#  VARIABLES  #
###############
# Location of ideviceinstall/idevice_id cml tools
IDEVICE_TOOLS_DIR="/usr/local/bin"


###############
#  FUNCTIONS  #
###############
installIPA(){
	local APP_TO_INSTALL=$1
	local DEVICE=$2
	local DEVICE_NAME=`${IDEVICE_TOOLS_DIR}/idevicename -u ${DEVICE}`

	echo "------------------------------------------------------"
	echo "Working on:   ${DEVICE_NAME}"
	echo "Device UDID:  ${DEVICE}"
	echo ""

    ${IDEVICE_TOOLS_DIR}/ideviceinstaller -i ${APP_TO_INSTALL} -u ${DEVICE}
    echo ""
}

doLoopInstall() {
	# Variables:
	local APP_TO_INSTALL=$1

	# Make deviceIDs file if doesn't exist.
	touch ~/deviceIDs.txt

	# Output Devices we are installing to
	${IDEVICE_TOOLS_DIR}/idevice_id -l > ~/deviceIDs.txt

	# Loop through all devices listed in deviceIDs.txt and execute Automation on them
	while read DEVICE; do
		[[ ${DEVICE} = "317b86735a60bdfbddd32c0927fac953b42b74e7" ]] && continue;
		[[ ${DEVICE} = "ee6774362639ae49a5afd101d76e6fd35b89d218" ]] && continue;
		installIPA ${APP_TO_INSTALL} ${DEVICE}

	done < ~/deviceIDs.txt
}


##############
#    MAIN    #
##############

if [ ! -z $2 ] 
then 
    # If provide UIDI of Device on commandline, install just to that device
	installIPA $1 $2
else
	# If don't provide UDID of device, do loop install
    doLoopInstall $1
fi
