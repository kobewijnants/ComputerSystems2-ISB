############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Powershell ErrorHandling

# Error handling $? variabele

ping localhost
if ($?) {
    Write-Host "Ping succeeded" -ForegroundColor Green
}
else {
    Write-Host "Ping failed" -ForegroundColor Red
}

ping nonexistinghost
if ($?) {
    Write-Host "Ping succeeded" -ForegroundColor Green
}
else {
    Write-Host "Ping failed" -ForegroundColor Red
}

Get-Process notepad -ErrorAction silentlycontinue
if ($?) {
    Write-Host "Process found" -ForegroundColor Green
}
else {
    Write-Host "Process not found" -ForegroundColor Red
}

# Get-Process notepad -ErrorAction silentlycontinue
# $?

$ErrorActionPreference = 'silentlycontinue' # For the entire script

# Error handling try and catch
try {
    $c = Get-Content -Path C:\nonexistingfile.txt -ErrorAction stop
    Write-Host "$c"
}
catch {
    # De $_ variabele bevast het laatste error record
    Write-Host "Exception:" -ForegroundColor Red
    $_.Exception.GetType().FullName
    $_.Exception.Message
    # exit 1 = false
}
# '-ErrorAction stop' This will stop the script when all error occurs


# Scrip Documenation

<#
.SYNOPSIS
    This script demonstrates error handling in PowerShell.
.DESCRIPTION
    This script demonstrates error handling in PowerShell.
.NOTES
    File Name      : W18P3.ps1
    Author         : Elias De Hondt
    Prerequisite   : PowerShell V2
.EXAMPLE
    PS > .\W18P3.ps1
#>

# Modules

# .psm1 files

# Defolt directory for modules
# My Documents\WindowsPowerShell\Modules\namemodule\namemodule.psm1

# Import-Module namemodule

# Place functions in a .psm1 file and import it with Import-Module