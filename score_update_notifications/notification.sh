#!/bin/bash

# Check if the argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <message>"
    exit 1
fi

# Get the message from the command line argument
message="$1"

# Send the notification
notify-send "Notification" "$message"

