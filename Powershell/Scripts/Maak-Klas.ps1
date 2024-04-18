############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Maak-Klas.ps1

<#
.SYNOPSIS
    This script creates class files and folders from a csv file.
.DESCRIPTION
    This script creates class files and folders from a csv file.
    The script can also remove the class files and folders.
.EXAMPLE
    Maak-Klas.ps1
    Maak-Klas.ps1 -Remove
#>

# Functie: Create Class files and folders from a csv file
function CreateClass($class) {
    $splitClass = $class.Split(",")
    $folder = [string]$splitClass[0]
    $filename = [string]$splitClass[1]
    $amount = [int]$splitClass[2]

    New-Item -ItemType Directory -Path $folder

    for ($i = 1; $i -le $amount; $i++) { # (-le is <=)
        New-Item -ItemType File -Path $folder\$filename$i.txt
    }
}

# Functie: Delete Class files and folders from a csv file
function DeleteClass($class) {
    $splitClass = $class.Split(",")
    $folder = [string]$splitClass[0]

    Remove-Item -Path $folder -Recurse
}

# Import the csv file
$csvfile = 'C:\Users\elias\OneDrive\Data Core\Documents\School Documents\(5) KdG\Toegepaste Informatica\Toegepaste Informatica Jaar 2\(2) Computersystemen - ISB\ComputerSystems2-ISB\Powershell\data\klassen.csv'

$classes = Get-Content $csvfile
foreach ($class in $classes) {
    if ($args.Contains("-Remove")) { DeleteClass $class }
    else { CreateClass $class }
}