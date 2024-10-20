# PowerShell Script for Configuring an Internal Virtual Switch and NAT

## Description
This script is designed to create an internal virtual network switch, assign an IP address to it, and configure a Network Address Translation (NAT) setup. It’s useful for setting up an internal network within a virtualized environment, typically for testing or isolated network scenarios.

The script performs the following tasks:
1. Prompts for a virtual switch name and creates an internal switch using `New-VMSwitch`.
2. Retrieves the interface index of the newly created virtual switch and assigns an IP address to it.
3. Configures a NAT network by associating the internal switch with a specified subnet.

## Prerequisites
- The script requires administrative privileges as it interacts with virtual network switches and IP address configurations.
- It assumes that the `Hyper-V` role is installed on the system for creating the virtual switch.

## How to Use the Script

1. **Run the Script**: Open PowerShell as an administrator.
2. **Enter the Required Inputs**:
    - **Switch Name**: You'll be prompted to enter the name of the new virtual switch.
    - **IP Address**: Input the IP address to assign to the virtual switch.
    - **Prefix Length**: Enter the prefix length (subnet mask) for the IP address, e.g., `24` for a `255.255.255.0` subnet.
    - **Subnet and Mask**: Provide the IP subnet and mask for the NAT configuration, e.g., `192.168.0.0/24`.
    - **NAT Name**: Input a name for the NAT network to be created.

### Example Execution
```powershell
PS C:\> .\network-script.ps1
Enter switch name: MyInternalSwitch
Enter IP address: 192.168.0.1
Enter the prefix length: 24
Enter the ip subnet with mask like x.x.x.0/24: 192.168.0.0/24
Enter the new Nat name: MyNAT
