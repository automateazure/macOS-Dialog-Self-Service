# SwiftDialog Installation Progress Script

This script provides a user-friendly installation progress window using **swiftDialog** while **Installomator** installs an application. It is designed for use with **Jamf Pro**, where the app label is passed as a parameter.

---

## 📋 Script Overview

The script performs the following:

- Displays a progress window using swiftDialog.
- Simulates installation steps with progress updates.
- Executes Installomator to install the specified application.

---

## 🧾 Parameters

- `$4`: The name of the application to install. This must match a label recognized by Installomator.

---

## 🛟 Function: `show_install_progress`

This function launches a swiftDialog window with:

- A title and message
- An icon
- A 4-step progress bar
- A command file for dynamic updates

### Simulated Installation Steps:

1. **Downloading Installer**
2. **Verifying Package**
3. **Installing**
4. **Finished**

Each step updates the dialog window with new text and progress percentage.

---

## 🛠️ Installomator Execution

After showing the progress window, the script runs Installomator with the following options:

- `BLOCKING_PROCESS_ACTION=tell_user`: Warns the user if the app is open.
- `NOTIFY=success`: Shows a notification when the install is successful.
- `DEBUG=0`: Disables debug mode.
- `PROMPT_TIMEOUT=300`: Waits 5 minutes before timing out.
- `LOGO=jamf`: Uses the Jamf logo in notifications.

---

## 📦 Requirements

- **swiftDialog** installed at `/usr/local/bin/dialog`
- **Installomator** installed at `/usr/local/Installomator/Installomator.sh`
- The Dialog icon located at `/Library/Application Support/Dialog/Dialog.png`

---

## ✅ Usage

Deploy this script via Jamf Pro and pass the application label as the fourth parameter.
