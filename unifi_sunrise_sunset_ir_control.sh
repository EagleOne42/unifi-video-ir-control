#!/bin/bash

# Jonathan Hornung
# 2019-07-18
# Unifi Sunrise Sunset IR Control
# Version 1.0

# Check for mode input
if [ ! "$1" ]
then
	echo "Please specify a mode: \"sunrise\" or \"sunset\""
    echo "Ex) ./sunrise_sunset_ir_cron.sh sunrise"
    exit 1
else
	mode="$1"
fi

# Source the users .env_unifi file - user needs to add the API location, and API key and lat/lon location info
source ~/.env_unifi

# Check to see if they are set now
if [ -z "$PYTHONPATH" ]
then
    echo "The python path (PYTHONPATH) was not found in .bashrc"
    echo "Without this set the script might fail"
fi

# shellcheck disable=SC2154
if [ -z "$unifi_api" ]
then
    echo "Unifi API Key (unifi_api) was not found in .bashrc"
    echo "Without this set the script might fail"
fi

# shellcheck disable=SC2154
if [ -z "$unifi_location_lat" ] && [ -z "$unifi_location_lon" ]
then
    echo "Unifi Location (unifi_location_lat or unifi_locations_lon) was not found in .bashrc"
    echo "Without this set the script will default to Bingham, England (or else where if only one is supplied)"
fi

# echo "DEBUG INFO START"
# echo "PYTHONPATH: $PYTHONPATH"
# echo "unifi_api: $unifi_api"
# echo "unifi_location: $unifi_location_lat - $unifi_location_lon"
# echo "DEBUG INFO END"

# Function to get current time for timestamps
timestamp () {
    date +%Y-%m-%d\ %k:%M:%S\ %Z
}

# Print current timestamp
timestamp
echo "Running - waiting for $mode time"

# Check for the mode set "sunrise" vs "sunset"
# This can be condenced some more with substitution, but will leave for now
if [ "$mode" == "sunrise" ]
then
    # Print mode and time that the control script should be ran
    echo "Sunrise expected at: $(/usr/local/bin/sunwait list rise daylight -offset 00:25 "$unifi_location_lat" "$unifi_location_lon")"

    # Run the wait command
    /usr/local/bin/sunwait wait rise daylight -offset 00:25 "$unifi_location_lat" "$unifi_location_lon"

    # Wait command finished - print timestamp
    timestamp
    echo "Wait completed - Turning IR to auto"
    python3 /home/jono/git_repos/unifi_uvc_ir_control/unifi_ir_control.py auto
    echo

elif [ "$mode" == "sunset" ]
then
    # Print mode and time that the control script should be ran
    echo "Sunset expected at: $(/usr/local/bin/sunwait list set daylight -offset -00:25 "$unifi_location_lat" "$unifi_location_lon")"

    # Run the wait command
    /usr/local/bin/sunwait wait set daylight -offset -00:25 "$unifi_location_lat" "$unifi_location_lon"

    # Wait command finished - print timestamp
    timestamp
    echo "Wait completed - Turning on IR"
    python3 /home/jono/git_repos/unifi_uvc_ir_control/unifi_ir_control.py on
    echo

else
    echo "ERROR - $mode unknown"
fi
