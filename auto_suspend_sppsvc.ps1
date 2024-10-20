function Test-IsAdmin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-Not (Test-IsAdmin)) {
    Write-Host "This script requires administrative privileges. Attempting to restart as administrator...`n"
    
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    Start-Process powershell -ArgumentList $arguments -Verb RunAs
    exit
}

$tempDir = "$env:USERPROFILE\temp"
$zipUrl = "https://download.sysinternals.com/files/PSTools.zip"
$zipPath = "$tempDir\PSTools.zip"
$extractPath = "$tempDir\PSTools"
$psSuspendPath = "$extractPath\pssuspend64.exe"
$destinationPath = "C:\Windows\System32\pssuspend64.exe"

if (-Not (Test-Path $tempDir)) {
    New-Item -ItemType Directory -Path $tempDir
}

if (-Not (Test-Path $zipPath)) {
    Write-Host "Downloading PSTools.zip...`n"
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
} else {
    Write-Host "PSTools.zip already exists."
}

Add-Type -AssemblyName System.IO.Compression.FileSystem

if (-Not (Test-Path $extractPath)) {
    try {
        Write-Host "Extracting PSTools.zip...`n"
        [System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $extractPath)
    } catch {
        Write-Host "Error extracting PSTools.zip: $_ `n"
        exit
    }
} else {
    Write-Host "PSTools already extracted."
}


if (-Not (Test-Path $destinationPath)) {
    if (Test-Path $psSuspendPath) {
        Write-Host "Copying pssuspend64.exe to System32...`n"
        Copy-Item -Path $psSuspendPath -Destination $destinationPath -Force
    } else {
        Write-Host "Error: pssuspend64.exe not found at $psSuspendPath `n"
        exit
    }
} else {
    Write-Host "pssuspend64.exe already exists in System32. `n"
}

$taskName = "SPPSVC Suspend"

$action = New-ScheduledTaskAction -Execute "C:\Windows\System32\pssuspend64.exe" -Argument "sppsvc"
$trigger = New-ScheduledTaskTrigger -AtLogOn -RandomDelay 15

$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent().Name

$principal = New-ScheduledTaskPrincipal -UserId $currentUser -LogonType Interactive -RunLevel Highest

$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -ExecutionTimeLimit ([TimeSpan]::Zero)

$taskExists = Get-ScheduledTask | Where-Object {$_.TaskName -eq $taskName}

if (-Not $taskExists) {
    Write-Host "Creating scheduled task '$taskName'... `n"
    Register-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -Settings $settings -TaskName $taskName
    # wevtutil set-log Microsoft-Windows-TaskScheduler/Operational /enabled:true
} else {
    Write-Host "Scheduled task '$taskName' already exists. `n"
}

Write-Host "Running the task to suspend sppsvc service... `n"
Start-ScheduledTask -TaskName $taskName


if (Test-Path $tempDir) {
    Write-Host "Cleaning up temporary files... `n"
    Remove-Item -Path $tempDir -Recurse -Force
}

Write-Host "Checking the status of the Software Protection service (sppsvc)...`n"

$threads = (Get-Process -Name sppsvc).Threads | Select-Object ThreadState, WaitReason

if ($threads) {
    Write-Host "SPPSVC threads found. Displaying ThreadState and WaitReason:`n"
    $threads
} else {
    Write-Host "No threads found for the sppsvc process.`n"
}

Write-Host "Script execution completed. Press Enter to exit."
[void][System.Console]::ReadLine()