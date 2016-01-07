#!/bin/bash
#set -x
###############
#  VARIABLES  #
###############

hash idevice_id 2>/dev/null || { echo >&2 "idevice_id is required. Please install via `brew install ideviceinstaller` and ensure its in your path."; exit 1; }
idevice_id -l > ~/deviceIDs.txt

echo
echo "               Device UDID                 --      Device Name     "

while read DEVICE; do
	[[ ${DEVICE} = "317b86735a60bdfbddd32c0927fac953b42b74e7" ]] && continue;
	[[ ${DEVICE} = "ee6774362639ae49a5afd101d76e6fd35b89d218" ]] && continue;
	
	DEVICE_NAME=`idevicename -u ${DEVICE}`

	echo " ${DEVICE}  --  ${DEVICE_NAME}"
done < ~/deviceIDs.txt
echo