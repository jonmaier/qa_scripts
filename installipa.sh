#!/bin/bash
#set -x

######
# This script depends on the ideviceinstaller and associated command line tools. http://www.libimobiledevice.org/
#####

hash idevice_id 2>/dev/null || { echo >&2 "idevice_id is required. Please install via `brew install ideviceinstaller` and ensure its in your path."; exit 1; }
hash ideviceinstaller 2>/dev/null || { echo >&2 "ideviceinstaller is required. Please install via `brew install ideviceinstaller` and ensure its in your path."; exit 1; }
hash idevicename 2>/dev/null || { echo >&2 "idevicename is required. Please install via `brew install ideviceinstaller` and ensure its in your path."; exit 1; }

###############
#  FUNCTIONS  #
###############
installIPA(){
	local APP_TO_INSTALL=$1
	local DEVICE=$2
	local DEVICE_NAME=`idevicename -u ${DEVICE}`

	echo "------------------------------------------------------"
	echo "Working on:   ${DEVICE_NAME}"
	echo "Device UDID:  ${DEVICE}"
	echo ""

    ideviceinstaller -i ${APP_TO_INSTALL} -u ${DEVICE}
    echo ""
}

doLoopInstall() {
	# Variables:
	local APP_TO_INSTALL=$1

	# Make deviceIDs file if doesn't exist.
	touch ~/deviceIDs.txt

	# Output Devices we are installing to
	idevice_id -l > ~/deviceIDs.txt

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
