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

# Function to write a colored line
function WriteColoredLine {
    param (
        [string]$Text = "No Text",
        [string]$ColorHex = "#ffffff"
    )

    $Local:R = [Convert]::ToInt32($ColorHex.Substring(1, 2), 16)
    $Local:G = [Convert]::ToInt32($ColorHex.Substring(3, 2), 16)
    $Local:B = [Convert]::ToInt32($ColorHex.Substring(5, 2), 16)

    [string]$Local:AnsiSequence = [char]27 + "[38;2;" + $R + ";" + $G + ";" + $B + "m"
    [string]$Local:ResetSequence = [char]27 + "[0m"
    Write-Host "${AnsiSequence}${Text}${ResetSequence}"
}

# Function to exit the script
function ExitScript {
    param (
        [string]$Message="No Message", 
        [int]$Code=0, 
        [bool]$NoColor=$False
    )
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