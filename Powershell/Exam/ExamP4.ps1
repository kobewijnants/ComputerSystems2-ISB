############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################

<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE
    ExamP4.ps1
.NOTES
File: ExamP4.ps1
Author: Elias De Hondt
Version: 1.0
#>

param ( # Parameters for the script
    [string]$csvfile="../Data/x.csv"
)

[string]$Global:PrimaryColor = "#4f94f0"

try {
    $Global:x = Import-Csv -Path $csvfile -Delimiter ","
} catch {
    ExitScript "Error: No CSV file" 1 $False
}

# Function to exit the script
function ExitScript {
    param (
        [string]$Message="No Message", 
        [int]$Code=0, 
        [bool]$NoColor=$False
    )
    # 1 = Error
    # 0 = Success
    Clear-Host
    if ($NoColor) {
        Write-Host $Message
    } else {
        if ($Code -eq 0) {
            WriteColoredLine -text $Message -colorHex "#00ff00"
        } elseif ($Code -eq 1) {
            WriteColoredLine -text $Message -colorHex "#ff0000"
        }
    }
    exit $Code
}