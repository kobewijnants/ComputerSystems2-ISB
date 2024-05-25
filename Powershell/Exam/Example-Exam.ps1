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

param (
    $NoColor
    $RunNewWindow
    [string]$RunInOtherDirectory="C:\"
    $RunAsAdministrator
    $RunInDebugMode
)

function Exit {
    param (
        [string]$Message="No Message"
        [init]$Code=0
    )

    if ($Code == 0) {
        Write-Host $Message -ForegroundColor Green
    } elseif ($Code == 1) {
        Write-Host $Message -ForegroundColor Red
    }
    exit $Code
}


function Main {
    
}


Main # Start the script