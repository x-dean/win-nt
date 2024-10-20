# PowerShell Automation Scripts

This repository contains various PowerShell scripts designed to automate different administrative tasks on Windows systems. Each script is accompanied by its own README file detailing its functionality, usage, and prerequisites.

## Scripts Overview

### 1. **Network Switch Setup Script**
- **Description**: This script creates a new internal virtual switch, configures its IP address, and sets up NAT for that switch. It prompts the user for input on the switch name, IP address, prefix length, and NAT name.
- **[Read more](./NetworkSwitchSetup/README.md)**

### 2. **Process Suspend SppSVC**
- **Description**: This script downloads the PSTools utility, specifically `pssuspend64.exe`, and schedules it to suspend the Software Protection service (`sppsvc`). It handles administrative checks, file downloads, extractions, and scheduled task creation.
- **[Read more](./SppSVC-OFF/README.md)**

## Usage
To use any of the scripts in this repository, navigate to the specific script's directory and follow the instructions in the respective README file.

## Contributing
Contributions to improve these scripts or add new functionality are welcome! Please create a pull request or open an issue for discussion.

## License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.