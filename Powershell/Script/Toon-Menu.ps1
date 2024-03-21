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
$csvfile = 'C:\Users\elias\OneDrive\Data Core\Documents\School Documents\(5) KdG\Toegepaste Informatica\Toegepaste Informatica Jaar 2\(2) Computersystemen - ISB\ComputerSystems2-ISB\Powershell\data\menu.csv'

$menu = Import-Csv -header "Nbr","Name" -Path $csvfile

do {
    Clear-Host
    $menu | Format-Table
    $choice = Read-Host "Please select a number"

    switch ($choice) {
        1 { Invoke-Expression $menu[0].Name }
        2 { Invoke-Expression $menu[1].Name }
        3 { Invoke-Expression $menu[2].Name }
    }
} until ($choice -eq 4)