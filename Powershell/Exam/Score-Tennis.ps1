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
    It contains a class called EliasTools that stores useful tools.
    The class contains the following functions:
    - BannerMessage: Displays a banner message
    - WriteColoredLine: Writes a colored line
    - ReadColoredLine: Reads a colored line
    - ExitScript: Exits the script
    The script also contains a try-catch block that imports a CSV file.
    The script also contains a global variable called PrimaryColor that stores the primary color.
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
    [string]$file="../Data/Tennis.csv"
)

[string]$Global:PrimaryColor = "#4f94f0"
[EliasTools]$Global:EliasTools = New-Object EliasTools

try { # A
    $Global:matches = Import-Csv -Path $file -Delimiter ";" | ForEach-Object {
        [PSCustomObject]@{
            tourney = [string]$_.tourney
            round = [string]$_.round
            winner = [string]$_.winner
            loser = [string]$_.loser
            winnersets = [int]$_.winnersets
            losersets = [int]$_.losersets
        }
    }
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

function Get-Tourneys ($matches) { # B
    [array]$Local:UniqueTourneysNames = $matches | Select-Object -Property tourney -Unique | Sort-Object -Property tourney

    return $UniqueTourneysNames
}

function Get-Winners ($matches) { # C
    [array]$Local:Winners = @{}

    foreach ($matche in $matches) {
        if ($matche.round -eq "Finals") {
            $Winners += [pscustomobject]@{ # Create a custom object
                tourney = [string]$matche.tourney;
                winner = [string]$matche.winner;
            }
        }
    }

    return $Winners
}

function Get-Matches { # D
    param (
        [array]$matches,
        [string]$player = "*Nadal",
        [string]$tourney = "*"
    )
    [array]$Local:Items = @{}

    foreach ($matche in $matches) {
        if ($matche.winner -like $player -and $matche.tourney -like $tourney) {
            $Items += $matche
        }
    }

    return $Items
}

function Get-BigMatches ($matches, $player) { # E
    $matches = Get-Matches $matches $player

    [array]$Local:Items = @{}
    foreach ($matche in $matches) {
        if ($matche.winnersets -eq 3) {
            $Items += $matche
        }
    }

    return $Items
}

function Get-BigTourney ($matches) { # F
    [array]$Local:Items = @{}
    foreach ($matche in $matches) {
        if ($matche.winnersets -eq 3) {
            $Items += [pscustomobject]@{ # Create a custom object
                tourney = [string]$matche.tourney;
                winnersets = [string]$matche.winnersets;
            }
        }
    }

    [array]$Local:ItemsUniqueAndSort = $Items | Select-Object -Property tourney, winnersets -Unique | Sort-Object -Property tourney

    return $ItemsUniqueAndSort
}

function Get-Players ($matches) { # G
    [array]$Local:PlayersWinner = $matches | Select-Object -Property winner -Unique
    [array]$Local:PlayersLoser = $matches | Select-Object -Property loser -Unique
    [array]$Local:Players = @{}

    foreach ($PlayerWinner in $PlayersWinner) {
        $Players += [pscustomobject]@{ # Create a custom object
            NamePlayer = [string]$PlayerWinner.winner
        }
    }

    foreach ($PlayerLoser in $PlayersLoser) {
        $Players += [pscustomobject]@{ # Create a custom object
            NamePlayer = [string]$PlayerLoser.loser
        }
    }

    [array]$Local:Players = $Players | Select-Object -Property NamePlayer -Unique

    return $Players
}

function Get-PlayerScore ($matches, $player) { # H
    [int]$Local:WinnerScore = 0
    [int]$Local:LoserScore = 0

    foreach ($matche in $matches) {
        if ($matche.winner -like $player) {
            $WinnerScore += $matche.winnersets
        }
        if ($matche.loser -like $player) {
            $LoserScore += $matche.losersets
        }
    }
    [int]$Local:Score = ($WinnerScore - $LoserScore)

    return $Score
}

function Get-Score ($matches) { # I
    [array]$Local:Players = Get-Players $matches
    [array]$Local:PlayersAndScore = @()


    foreach ($Player in $Players) {
        $Score = Get-PlayerScore $matches $Player.NamePlayer

        $PlayersAndScore += [pscustomobject]@{ # Create a custom object
            NamePlayer = [string]$Player.NamePlayer;
            Score = [int]$Score
        }
    }

    return $PlayersAndScore
}

function Print-Score ($matches) { # J
    [array]$Local:PlayersAndScoreAndSort = Get-Score $matches | Sort-Object -Property Score -Descending

    $PlayersAndScoreAndSort | Out-GridView

    for ($i = 0; $i -lt 10; $i++) {
        [array]$Local:Player = $PlayersAndScoreAndSort[$i]
        
        $EliasTools.WriteColoredLine(("{0,10}: {1,25}: {2,5}" -f ($i + 1), $Player.NamePlayer, $Player.Score), $PrimaryColor)
    }
}

$EliasTools.BannerMessage("Exam Elias De Hondt!", $PrimaryColor)

# Hoofdprogramma: hier niks wijzigen
# Linux: vervang alle Out-GridView door Format-Table
# Haal de lijnen uit commentaar voor de functies die werken
# Voor functies die niet werken: laat deze in commentaar staan
# Zo lever je een werkend script af

$tourney = "miami"
$player = "*Nadal"


Get-Tourneys $matches | Out-GridView
Get-Winners $matches | Out-GridView 
Get-Matches $matches $player $tourney | Out-GridView
Get-BigMatches $matches $player | Out-GridView
Get-BigTourney $matches | Out-GridView
Get-Players $matches | Out-GridView 
Get-PlayerScore $matches $player
Get-Score $matches | Out-GridView
Print-Score $matches