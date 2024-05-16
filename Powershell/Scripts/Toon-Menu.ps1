############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Toon-Menu.ps1

<#
.SYNOPSIS
    This script displays a menu with options.
.DESCRIPTION
    This script displays a menu with options.
.EXAMPLE
    Toon-Menu.ps1
#>

# Import the csv file
$csvfile = '..\data\menu.csv'

$menu = Import-Csv -header "Nbr","Name" -Path $csvfile
$end = $false

do {
    Clear-Host
    $menu | Format-Table
    $choice = Read-Host "Please select a number"

    foreach ($menuItem in $menu) {
        if ($menuItem.Nbr -eq $choice) {
            if ($menuItem.Name -eq "Stoppen") {
                $end = $true
            }
            else {
                Invoke-Expression $menuItem.Name # Invoke-Expression = &
                $end = $true
            }
        }
    }
} until ($end)