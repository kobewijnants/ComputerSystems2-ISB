############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 25/04/2024        #
############################

<#
.SYNOPSIS
    Manage the Gitea service.
.DESCRIPTION
    This script allows you to start, stop, restart, or remove the Gitea service.
    It provides a menu with options to perform these actions.
.EXAMPLE
    GiteaServiceManager.ps1
.NOTES
File: GiteaServiceManager.ps1
Author: Elias De Hondt
Version: 1.0
#>

function Start-GiteaService {
    try {
        Start-Service -Name "gitea"
        Write-Host "Gitea service started successfully."
        Write-Host "Go to http://localhost:3000 to access Gitea."
        Invoke-Expression "start http://localhost:3000"
    } catch {
        Write-Host "Failed to start Gitea service: $($_.Exception.Message)"
    }
}

function Stop-GiteaService {
    try {
        Stop-Service -Name "gitea"
        Write-Host "Gitea service stopped successfully."
    } catch {
        Write-Host "Failed to stop Gitea service: $($_.Exception.Message)"
    }
}

function Restart-GiteaService {
    try {
        Restart-Service -Name "gitea"
        Write-Host "Gitea service restarted successfully."
    } catch {
        Write-Host "Failed to restart Gitea service: $($_.Exception.Message)"
    }
}

function Remove-GiteaService {
    try {
        Write-Host "Are you sure you want to remove the Gitea service? This action cannot be undone. (Y/N)"
        $confirmation = Read-Host
        if ($confirmation -eq 'Y' -or $confirmation -eq 'y') {
            sc.exe delete gitea
            Write-Host "Gitea service removed successfully."
        } else {
            Write-Host "Removal of Gitea service canceled."
        }
    } catch {
        Write-Host "Failed to remove Gitea service: $($_.Exception.Message)"
    }
}

function Show-Menu {
    Write-Host "Select an option:"
    Write-Host "1. Start Gitea service"
    Write-Host "2. Stop Gitea service"
    Write-Host "3. Restart Gitea service"
    Write-Host "4. Remove Gitea service"
    Write-Host "5. Exit"
}

do {
    Show-Menu
    $choice = Read-Host "Enter your choice (1-5)"

    switch ($choice) {
        1 {
            Start-GiteaService
        }
        2 {
            Stop-GiteaService
        }
        3 {
            Restart-GiteaService
        }
        4 {
            Remove-GiteaService
        }
        5 {
            Write-Host "Exiting..."
        }
        default {
            Write-Host "Invalid choice. Please select a valid option (1-5)."
        }
    }
} while ($choice -ne 5)