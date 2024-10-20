# win-nt

### Due to sppsvc bug (or KMS stuff !!) SPPSVC service works full time using 30%+ CPU. To mitigate this issue I tried to stop the service or not start it at all during startup. This was a solution but this service is needed to keep license validated and also be able to use Microsoft Products like Office etc. So I spend some weekend hours to create this script to suspend ;) the service, so for Windows it is running but for us the 30% CPU is back.

# How to use it:
- Execute with powershell.
- Your user need to be local administrator of the system.

## How to revert it (in case you want to validate  windows or update or stuff like that):
- Go to Task Scheduler, find "SPPSVC Suspend", right click and disable. Reboot.

## To re-enable
- Go to Task Scheduler, find "SPPSVC Suspend", right click and enable. Reboot.

> Because the script is scheduled to run within 15 min sppsvc will run to do his tasks then will be suspended.
> Tools used are downloaded from Microsoft PSTools.
