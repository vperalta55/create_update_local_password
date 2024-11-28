# Inputs
$logFile = "C:\temp\AccountCreated.txt"
$password = "passwordcleartext" # Ideally, this should be retrieved securely from a safe location
$username = "test1"
Function Write-Log {
    param(
        [Parameter(Mandatory = $true)][string] $message,
        [Parameter(Mandatory = $false)]
        [ValidateSet("INFO","WARN","ERROR")]
        [string] $level = "INFO"
    )
    # Create timestamp
    $timestamp = (Get-Date).ToString("yyyy/MM/dd HH:mm:ss")
 
    # Append content to log file
    Add-Content -Path $logFile -Value "$timestamp [$level] - $message"
}
 
Function Create-LocalAdmin {
    process {
        try {
            # Check if the user already exists
            $existingUser = Get-LocalUser -Name $username -ErrorAction SilentlyContinue
            if ($existingUser) {
                # User exists, update the password
                Set-LocalUser -Name $username -Password (ConvertTo-SecureString $password -AsPlainText -Force) -ErrorAction Stop
                Write-Log -message "$username local user password updated"
            } else {
                # User doesn't exist, create the user
                $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
                New-LocalUser -Name "$username" -Password $securePassword -FullName "$username" -Description "local admin" -ErrorAction Stop
                Write-Log -message "$username local user created"
 
                # Add new user to administrator group
                Add-LocalGroupMember -Group "Administrators" -Member "$username" -ErrorAction Stop
                Write-Log -message "$username added to the local administrator group"
            }
        }
        catch {
            Write-Log -message "Creating/updating local account failed" -level "ERROR"
        }
    }    
}


Write-Log -message "Create/update local admin account"
Create-LocalAdmin

