############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Watch-Dog.ps1

<#
.SYNOPSIS
    This script monitors a process and restarts it if it is not running.
.DESCRIPTION
    This script monitors a process and restarts it if it is not running.
.EXAMPLE
    Watch-Dog.ps1
    Watch-Dog.ps1 -h or Watch-Dog.ps1 -help
#>

Param (
    [string]$processname="notepad",
    [switch]$help=$false
)

if ($help) {
    Get-Help $MyInvocation.MyCommand.Definition
    exit 0
}

function ProcessRunning {
    param (
        [string]$process
    )

    Get-Process $process -ErrorAction SilentlyContinue | Out-null

    if ($? -eq $false) {
        Invoke-Expression $process
        return $false
    }
    return $true
}

while ($true) {
    ProcessRunning -process $processname
    Start-Sleep -Seconds 2
}