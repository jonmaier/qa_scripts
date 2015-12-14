#!/bin/bash
#set -x
###############
#  VARIABLES  #
###############
# Location of ideviceinstall/idevice_id cml tools
IDEVICE_TOOLS_DIR="/usr/local/bin/"
${IDEVICE_TOOLS_DIR}/idevice_id -l > ~/deviceIDs.txt

echo
echo "               Device UDID                 --      Device Name     "

while read DEVICE; do
	[[ ${DEVICE} = "317b86735a60bdfbddd32c0927fac953b42b74e7" ]] && continue;
	[[ ${DEVICE} = "ee6774362639ae49a5afd101d76e6fd35b89d218" ]] && continue;
	
	DEVICE_NAME=`${IDEVICE_TOOLS_DIR}/idevicename -u ${DEVICE}`

	echo " ${DEVICE}  --  ${DEVICE_NAME}"
done < ~/deviceIDs.txt
echo