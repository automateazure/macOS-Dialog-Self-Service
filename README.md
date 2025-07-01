Jamf Pro App Deployment with swiftDialog and Installomator
This script enhances the user experience during application installations managed through Jamf Pro. It uses swiftDialog to display a visual progress window and Installomator to handle the actual installation of applications.


📌 Purpose
The goal of this script is to:
Provide users with a clear, friendly progress window during app installations.
Simplify the deployment process using Installomator labels.
Improve transparency and reduce confusion during software installations.


🛠 How It Works
App Label Input: The script expects the app label as the 4th parameter from Jamf Pro. This label must match one of the supported Installomator labels.
Progress Window: A swiftDialog window is launched showing the installation progress in four stages:

Downloading Installer
Verifying Package
Installing
Finished

Installomator Execution: After the progress window completes, Installomator installs the specified application.


🚀 Usage with Jamf Pro
Upload the Script: Add this script to your Jamf Pro Scripts library.

Create a Policy:
Add the script to the policy.
Set Parameter 4 to the Installomator label of the app you want to install (e.g., googlechrome, zoom, slack).
Scope the Policy: Assign it to the appropriate devices or users.
Deploy via Self Service or Automatically.


⚙️ Customization Options
Progress Timing: Adjust the sleep durations in the script to better match the actual install time of your apps.
Dialog Appearance: Modify the --title, --message, --icon, and other swiftDialog options to match your branding.
Installomator Flags: Customize behavior using flags like:

BLOCKING_PROCESS_ACTION
NOTIFY
DEBUG
PROMPT_TIMEOUT
LOGO


📂 Requirements
Jamf Pro with scripting support
swiftDialog installed on target machines
Installomator installed at /usr/local/Installomator/Installomator.sh


✅ Example
If you want to install Google Chrome, set Parameter 4 in your Jamf policy to:

googlechrome

Then deploy the policy via Self Service or automatically to your target devices.