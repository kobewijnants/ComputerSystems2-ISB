############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Show-ADItems.ps1

<#
.SYNOPSIS
    
.DESCRIPTION

.EXAMPLE
    Show-ADItems.ps1

.NOTES
File: Show-ADItems.ps1
Author: Elias De Hondts
Version: 1.0
#>

function ShowInfo {
    param (
        [string]$ADCommand
    )
    $ADCommand = $ADCommand + " -Filter *"
    $result = Invoke-Expression $ADCommand
    $result | Out-GridView -Title "Result of $ADCommand"
}

$csvfile = '..\Data\ADmenu.csv'

if (-not (Test-Path $csvfile)) {
    Write-Host "Error: The specified CSV file does not exist: $csvfile" -ForegroundColor Red
    Exit
}

$ADMenu  = Import-Csv $csvfile
$choice = $true
while ($choice) {
    $selected = $ADMenu | Out-GridView -Title "Select an item" -OutputMode Single
    if ($selected.Item -eq "Stop") { 
        $choice = $False 
    } else {
        ShowInfo -ADCommand $selected.Item
    }
}