#!/bin/bash

# Created by Brian Brito with examples from Dialog and Renew Github Repos
# 6-30-25
# v1.0

# Modified version of Installomator script
# For Self Service application installs
# Presents a Dialog window showing the progress of the install

# App label passed from Jamf parameter 4
appLabel="$4"

# Function to show dialog
show_install_progress() {
    local dialogCommandFile="/var/tmp/dialog.log"
    : > "$dialogCommandFile"

    /usr/local/bin/dialog \
        --title "Installing $appLabel" \
        --message "Please wait while we install $appLabel..." \
        --icon "/Library/Application Support/Dialog/Dialog.png" \
        --button1disabled \
        --progress 4 \
        --commandfile "$dialogCommandFile" \
        --moveable --ontop --mini &

    sleep 1

    dialog_command() {
        echo "$1" >> "$dialogCommandFile"
        sleep 2
    }

	#Update dialog with progress messages
    dialog_command "progresstext: Downloading installer..."
    sleep 5
    dialog_command "progress: increment"
   
    dialog_command "progresstext: Verifying package..."
    sleep 5
    dialog_command "progress: increment"

    dialog_command "progresstext: Installing..."
    sleep 10
    dialog_command "progress: increment"

    dialog_command "progresstext: Finished. Please wait for a confirmation notification..."
    sleep 5
    dialog_command "progress: increment"

    dialog_command "quit:"
}

# Run dialog
show_install_progress "$appLabel"

# Run Installomator
/usr/local/Installomator/Installomator.sh "$appLabel" \
    BLOCKING_PROCESS_ACTION=tell_user \
    NOTIFY=success \
    DEBUG=0 \
    PROMPT_TIMEOUT=300 \
    LOGO=jamf