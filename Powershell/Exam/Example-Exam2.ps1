############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################

<#
.SYNOPSIS
    This script contains a series of tasks related to basketball player statistics.
.DESCRIPTION
    This script contains a series of tasks related to basketball player statistics.
    The tasks include finding the top scorer, the best all-rounder, the top scorer per team, and more.
    The script is intended to demonstrate how to work with player statistics and perform various calculations.
.EXAMPLE
    Example-Exam2.ps1
.NOTES
File: Example-Exam2.ps1
Author: Elias De Hondt
Version: 1.0
#>

# 1) Top Scorer with More than 40 Games:
    # Write a script to find the player with the highest average points per game who has played more than 40 games.

# 2) Best All-Rounder:
    # Write a script to calculate and find the player with the highest combined average of points, rebounds, and assists.

# 3) Top Scorer Per Team:
    # Write a script to find the top scorer for each team.

# 4) Players with More Assists than Points:
    # Write a script to find all players who have a higher average of assists than points.

# 5) Players with Most Improved Stats:
    # Write a script to find the player who has the highest increase in points, rebounds, 
    # or assists per game compared to a previous period (you can simulate this with additional data).

# 6) Average Stats Per Team Sorted by Points:
    # Write a script to calculate the average points, rebounds, and assists for each team and sort the teams by average points.

# 7) Player Efficiency Rating (PER) Calculation:
    # Write a script to calculate a simplified version of the Player Efficiency Rating (PER) 
    # for each player and find the top player based on this metric.

# 8) Find the Player with the Highest Points to Games Ratio:
    # Write a script to calculate the points-to-games ratio for each player and find the player with the highest ratio.

# 9) Determine Players Who Have Improved Over Time:
    # Write a script to find players whose average points have increased over two halves of the season (first 20 games vs. last 20 games).

# 10) Analyze Team Performance Over Time:
    # Write a script to analyze and plot the performance of each team over time, e.g., points per game over the season.

param ( # Parameters for the script
    [string]$csvfile="../Data/NBA_Player_Stats.csv"
)

[string]$global:PrimaryColor = "#4f94f0"

try {
    $Violations = Import-Csv -Path $csvfile -Delimiter ","
} catch {
    ExitScript "Error: No CSV file" 1 $False
}

# Function to write a colored line
function WriteColoredLine {
    param (
        [string]$Text,
        [string]$ColorHex = "#ffffff"
    )

    $R = [Convert]::ToInt32($ColorHex.Substring(1, 2), 16)
    $G = [Convert]::ToInt32($ColorHex.Substring(3, 2), 16)
    $B = [Convert]::ToInt32($ColorHex.Substring(5, 2), 16)

    [string]$Local:AnsiSequence = [char]27 + "[38;2;" + $R + ";" + $G + ";" + $B + "m"
    [string]$Local:ResetSequence = [char]27 + "[0m"
    Write-Host "${AnsiSequence}${Text}${ResetSequence}"
}

# Function to read a colored line
function ReadColoredLine {
    param (
        [string]$Text,
        [string]$ColorHex
    )

    $R = [Convert]::ToInt32($ColorHex.Substring(1, 2), 16)
    $G = [Convert]::ToInt32($ColorHex.Substring(3, 2), 16)
    $B = [Convert]::ToInt32($ColorHex.Substring(5, 2), 16)

    [string]$Local:AnsiSequence = [char]27 + "[38;2;" + $R + ";" + $G + ";" + $B + "m"
    [string]$Local:ResetSequence = [char]27 + "[0m"
    Read-Host "${AnsiSequence}${Text}${ResetSequence}"
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

# Function to display a banner message
function BannerMessage {
    param (
        [string]$Message="Message...", 
        [string]$Color="#ffffff"
    )
    Clear-Host
    [int]$Local:Length = $Message.Length
    [string]$Local:Line1 = "*****"
    [string]$Local:Line2 = "*   "
    [string]$Local:Text = "*  " + $Message + "  *"

    for ($i = 0; $i -le $Length; $i++) {
        $Line1 += "*"
        $Line2 += " "

        if ($i -eq $Length) {
            $Line2 += "*"
        }
    }
    
    WriteColoredLine -text $Line1 -colorHex $Color
    WriteColoredLine -text $Line2 -colorHex $Color
    WriteColoredLine -text $Text -colorHex $Color
    WriteColoredLine -text $Line2 -colorHex $Color
    WriteColoredLine -text $Line1 -colorHex $Color
}

# Function to start the script
function Main {
    BannerMessage "Example Exam 2" $PrimaryColor

    WriteColoredLine -text "*`n* Which flow would you like to do:`n* 1)  Top Scorer with More than 40 Games`n* 2)  Best All-Rounder`n* 3)  Top Scorer Per Team`n* 4)  Players with More Assists than Points`n* 5)  Players with Most Improved Stats`n* 6)  Average Stats Per Team Sorted by Points`n* 7)  Player Efficiency Rating (PER) Calculation`n* 8)  Find the Player with the Highest Points to Games Ratio`n* 9)  Determine Players Who Have Improved Over Time`n* 10) Analyze Team Performance Over Time`n* 11) Exit" -colorHex $PrimaryColor
    [int]$Local:Number = ReadColoredLine -text "* Enter the number" -colorHex $PrimaryColor

    switch ($Number) {
        1 {

        }
        2 {

        }
        3 {

        }
        4 {

        }
        5 {

        }
        6 {

        }
        7 {

        }
        8 {

        }
        9 {

        }
        10 {

        }
        11 { # Exit
            ExitScript "* Exiting the script" 0
        }
        Default {
            ExitScript "* Not a valid input" 1
        }
    }
}

Main # Start the script