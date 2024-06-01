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
    [string]$csvfile="../Data/Violations.csv",
    [bool]$RunNewWindow=$False,
    [bool]$RunAsAdministrator=$False,
    [bool]$RunInDebugMode=$False
)

try {
    $Violations = Import-Csv -Path $csvfile -Delimiter ","
}
catch {
    Exit-Script "Error: No CSV file" 1 $False
}

# Function to exit the script
function Exit-Script([string]$Message="No Message", [int]$Code=0, [bool]$NoColor=$False) {
    # 1 = Error
    # 0 = Success
    Clear-Host
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


function Get-ListOfUniqueStreetNames($table) {
    $UniqueStreetNames = $violations | Select-Object -Property opnameplaats_straat -Unique | Sort-Object -Property opnameplaats_straat


    [array]$UniqueStreetNamesTable = @()
    $i = 0
    
    foreach ($item in $UniqueStreetNames) { # Loop through the unique street names
        $UniqueStreetNamesTable += [pscustomobject]@{ # Create a custom object
            Id = [int]$i;
            StreetName = [string]$item.opnameplaats_straat;
        }
        if ($i -eq 0) {
            [array]$UniqueStreetNamesTable = @()
        }
        $i++
    }
    $UniqueStreetNamesTable | Format-Table
}



# Function to start the script
function Main {
    Get-ListOfUniqueStreetNames $csvfile
    #Get-TotalAmountOfViolationsPerStreet
}

############################
# ../Data/Violations.csv
############################


Main # Start the script