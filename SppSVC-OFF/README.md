# PowerShell Script to Download, Extract, and Schedule pssuspend for sppsvc

## Description
This PowerShell script automates the process of downloading the PSTools utility, specifically `pssuspend64.exe`, and schedules it to suspend the Software Protection service (`sppsvc`). It performs the following tasks:

1. **Administrative Check**: Verifies if the script is running with administrative privileges. If not, it restarts itself as an administrator.
2. **Download PSTools**: Downloads `PSTools.zip` from Sysinternals if it doesn't already exist.
3. **Extract Files**: Extracts the downloaded ZIP file to a specified directory.
4. **Copy pssuspend64.exe**: Copies `pssuspend64.exe` to the `C:\Windows\System32` directory if it's not already present.
5. **Create Scheduled Task**: Sets up a scheduled task to run `pssuspend64.exe` at user logon, which will suspend the `sppsvc` service.
6. **Clean Up**: Deletes temporary files created during the process.
7. **Check Status**: Displays the thread state and wait reason of the `sppsvc` service.

## Prerequisites
- The script requires administrative privileges to download and execute tasks that modify system settings.
- Internet access is required to download the PSTools ZIP file.

## How to Use the Script

1. **Run the Script**: Open PowerShell as an administrator.
2. **Execution**: Execute the script directly by navigating to its location and typing:
   ```powershell
   .\auto_suspend_sppsvc.ps1

## How to revert it (in case you want to validate  windows or update or stuff like that):
- Go to Task Scheduler, find "SPPSVC Suspend", right click and disable. Reboot.

## To re-enable
- Go to Task Scheduler, find "SPPSVC Suspend", right click and enable. Reboot.