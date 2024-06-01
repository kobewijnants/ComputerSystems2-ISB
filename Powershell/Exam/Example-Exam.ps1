############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################

<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE

.NOTES
File: Example-Exam.ps1
Author: Elias De Hondt
Version: 1.0
#>

param ( # Parameters for the script
    [bool]$RunNewWindow=$False,
    [string]$RunInOtherDirectory="C:\",
    [bool]$RunAsAdministrator=$False,
    [bool]$RunInDebugMode=$False
)

# Function to exit the script
function Exit-Script([string]$Message="No Message", [int]$Code=0, [bool]$NoColor=$False) {
    # 1 = Error
    # 0 = Success
    if ($NoColor) {
        if ($Code -eq 0) {
            Write-Host $Message
        } elseif ($Code -eq 1) {
            Write-Host $Message
        }
    } else {
        if ($Code -eq 0) {
            Write-Host $Message -ForegroundColor Green
        } elseif ($Code -eq 1) {
            Write-Host $Message -ForegroundColor Red
        }
    }
    exit $Code
}

# Function to start the script
function Main {
    Exit-Script "Hallo" 1 $False
}


Main # Start the script