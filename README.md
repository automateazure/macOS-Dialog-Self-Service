# ------------------------------------------------------------------------------
# Script Purpose: Display a user-friendly installation progress window using
# swiftDialog while Installomator installs an application.
# This script is designed for use with Jamf Pro, where the app label is passed
# as a parameter.
# ------------------------------------------------------------------------------

# Jamf Pro automatically reserves the first three script parameters ($1, $2, $3).
# We use the fourth parameter ($4) to receive the name of the application we want to install.
# This name must match a label recognized by Installomator.
appLabel="$4"

# ------------------------------------------------------------------------------
# Function: show_install_progress
# Purpose:  Launch a swiftDialog window to visually show the user that an app
#           is being installed. It includes a title, message, icon, and a
#           progress bar that updates in stages.
# ------------------------------------------------------------------------------

function show_install_progress() {
    # Define the path to a temporary file that will be used to send commands to swiftDialog.
    # This file acts like a communication channel between our script and the dialog window.
    local dialogCommandFile="/var/tmp/dialog.log"

    # Create or clear the contents of the command file to ensure it's ready for use.
    : > "$dialogCommandFile"

    # Launch swiftDialog with various options:
    # --title:       Sets the window title to "Installing [App Name]"
    # --message:     Displays a message below the title
    # --icon:        Shows an image (Dialog logo in this case)
    # --button1disabled: Disables the default button so the user can't close it
    # --progress 4:  Enables a progress bar with 4 steps
    # --commandfile: Points to the file we’ll use to update the dialog
    # --moveable, --ontop, --mini: Controls the window's appearance and behavior
    /usr/local/bin/dialog \
        --title "Installing $appLabel" \
        --message "Please wait while we install $appLabel..." \
        --icon "/Library/Application Support/Dialog/Dialog.png" \
        --button1disabled \
        --progress 4 \
        --commandfile "$dialogCommandFile" \
        --moveable --ontop --mini &

    # Wait briefly to ensure the dialog window has time to open before we start sending updates.
    sleep 1

    # --------------------------------------------------------------------------
    # Nested Function: dialog_command
    # Purpose: Send a command (like updating text or progress) to the dialog window.
    # Usage: dialog_command "some command"
    # --------------------------------------------------------------------------
    function dialog_command () {
        # $1 is the command we want to send (e.g., "progress: percentage 50")
        # We append it to the dialogCommandFile so swiftDialog can read and apply it.
        echo "$1" >> "$dialogCommandFile"
        sleep .1  # Small delay to ensure the dialog processes the command smoothly
    }

    # -------------------------------
    # Simulated Progress Updates
    # -------------------------------
    # These steps simulate the stages of an installation process.
    # Each step updates the dialog with new text and a progress percentage.

    # Step 1: Show that the installer is being downloaded
    dialog_command "progresstext: Downloading Installer..."
    sleep 2
    dialog_command "progress: percentage 20"

    # Step 2: Show that the downloaded package is being verified
    dialog_command "progresstext: Verifying package..."
    sleep 5
    dialog_command "progress: percentage 50"

    # Step 3: Show that the app is being installed
    dialog_command "progresstext: Installing..."
    sleep 15
    dialog_command "progress: percentage 75"

    # Step 4: Show that the installation is complete
    dialog_command "progresstext: Finished. Please wait for a confirmation notification..."
    sleep 5
    dialog_command "progress: percentage 100"

    # Close the dialog window
    dialog_command "quit:"
}

# ------------------------------------------------------------------------------
# Execute the show_install_progress function
# This will open the dialog window and simulate the installation progress.
# ------------------------------------------------------------------------------
show_install_progress "$appLabel"

# ------------------------------------------------------------------------------
# Run Installomator to install the application
# The app label passed earlier is used here.
# Additional options:
# - BLOCKING_PROCESS_ACTION=tell_user: Warns the user if the app is open
# - NOTIFY=success: Shows a notification when the install is successful
# - DEBUG=0: Disables debug mode
# - PROMPT_TIMEOUT=300: Waits 5 minutes before timing out
# - LOGO=jamf: Uses the Jamf logo in notifications
# ------------------------------------------------------------------------------
/usr/local/Installomator/Installomator.sh "$appLabel" \
    BLOCKING_PROCESS_ACTION=tell_user \
    NOTIFY=success \
    DEBUG=0 \
    PROMPT_TIMEOUT=300 \
    LOGO=jamf