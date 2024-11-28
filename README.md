# Local Admin Account Management Script

This PowerShell script creates or updates a local administrator account on Windows machines. It checks if the specified user exists and either updates their password or creates a new user. The script also adds the user to the local "Administrators" group and logs all actions to a specified log file.

## Features

- **Creates or Updates a Local Admin Account**: If the specified user exists, the script updates the password. If the user doesn’t exist, it creates the user.
- **Logs Actions**: Every action (user creation, password update, errors) is logged with a timestamp.
- **Error Handling**: Any issues during execution are logged with details.

## Prerequisites

- PowerShell 5.1 or higher.
- Administrative privileges to create or modify local users.
- Write access to the directory where logs will be stored.

## Inputs

The script requires the following parameters to be defined:

- **$logFile**: Path to the log file where all actions will be recorded. Default is `C:\temp\AccountCreated.txt`.
- **$password**: Password for the local admin account. Default is `"passwordcleartext"`.
- **$username**: Username for the local admin account. Default is `"test1"`.

## How to Use

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/local-admin-account-management.git
   cd local-admin-account-management
