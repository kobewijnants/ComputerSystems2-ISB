############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 07/06/2024        #
############################

<#
.SYNOPSIS
    This script contains the code of the powershell exam period 4.
.DESCRIPTION
    This script contains the code of the powershell exam period 4.
.PARAMETER csvfile
.EXAMPLE
    ExamP4.ps1
.NOTES
File: ExamP4.ps1
Author: Elias De Hondt
Date: 07/06/2024
StudentID: 0160712-80
Class: ISB204B
Version: 1.0
#>

param ( # Parameters for the script
    [string]$csvfile="../Data/x.csv"
)

[string]$Global:PrimaryColor = "#4f94f0"
[EliasTools]$Global:EliasTools = New-Object EliasTools

try {
    $Global:x = Import-Csv -Path $csvfile -Delimiter ","
} catch {
    $EliasTools.ExitScript("Error: No CSV file", 1, $False)
}

# Class that stores useful tools
class EliasTools {
    # Function to display a banner message
    [void]BannerMessage([string]$Message="Message...", [string]$Color="#ffffff") {
        Clear-Host
        $Length = $Message.Length
        $Line1 = "*****"
        $Line2 = "*   "
        $Text = "*  " + $Message + "  *"

        for ($i = 0; $i -le $Length; $i++) {
            $Line1 += "*"
            $Line2 += " "
            if ($i -eq $Length) {
                $Line2 += "*"
            }
        }

        $this.WriteColoredLine($Line1, $Color)
        $this.WriteColoredLine($Line2, $Color)
        $this.WriteColoredLine($Text, $Color)
        $this.WriteColoredLine($Line2, $Color)
        $this.WriteColoredLine($Line1, $Color)
    }

    # Function to write a colored line
    [void]WriteColoredLine([string]$Text, [string]$ColorHex) {
        $R = [Convert]::ToInt32($ColorHex.Substring(1, 2), 16)
        $G = [Convert]::ToInt32($ColorHex.Substring(3, 2), 16)
        $B = [Convert]::ToInt32($ColorHex.Substring(5, 2), 16)
        
        $AnsiSequence = [char]27 + "[38;2;" + $R + ";" + $G + ";" + $B + "m"
        $ResetSequence = [char]27 + "[0m"
        Write-Host "${AnsiSequence}${Text}${ResetSequence}"
    }

    # Function to read a colored line
    [void]ReadColoredLine([string]$Text, [string]$ColorHex) {
        $R = [Convert]::ToInt32($ColorHex.Substring(1, 2), 16)
        $G = [Convert]::ToInt32($ColorHex.Substring(3, 2), 16)
        $B = [Convert]::ToInt32($ColorHex.Substring(5, 2), 16)
        
        $AnsiSequence = [char]27 + "[38;2;" + $R + ";" + $G + ";" + $B + "m"
        $ResetSequence = [char]27 + "[0m"
        Read-Host "${AnsiSequence}${Text}${ResetSequence}"
    }

    # Function to exit the script
    [void]ExitScript([string]$Message="No Message", [int]$Code=0, [bool]$NoColor=$False) {
        Clear-Host
        if ($NoColor) {
            Write-Host $Message
        } else {
            if ($Code -eq 0) {
                $this.WriteColoredLine($Message, "#00ff00")
            } elseif ($Code -eq 1) {
                $this.WriteColoredLine($Message, "#ff0000")
            }
        }
        exit $Code
    }
}

