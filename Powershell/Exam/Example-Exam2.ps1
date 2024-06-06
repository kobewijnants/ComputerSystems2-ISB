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

# Player: The name of the NBA player.
# Pos (Position): The player's position on the court (e.g., PG for Point Guard, SG for Shooting Guard, SF for Small Forward, PF for Power Forward, C for Center).
# Age: The player's age.
# Tm (Team): The abbreviation of the team the player belongs to.
# G (Games): The total number of games played by the player.
# GS (Games Started): The total number of games the player started.
# MP (Minutes Played): The average number of minutes played per game.
# FG (Field Goals Made): The average number of field goals made per game.
# FGA (Field Goals Attempted): The average number of field goals attempted per game.
# FG% (Field Goal Percentage): The field goal shooting percentage.
# 3P (Three-Point Field Goals Made): The average number of three-point field goals made per game.
# 3PA (Three-Point Field Goals Attempted): The average number of three-point field goals attempted per game.
# 3P% (Three-Point Field Goal Percentage): The three-point field goal shooting percentage.
# 2P (Two-Point Field Goals Made): The average number of two-point field goals made per game.
# 2PA (Two-Point Field Goals Attempted): The average number of two-point field goals attempted per game.
# 2P% (Two-Point Field Goal Percentage): The two-point field goal shooting percentage.
# eFG% (Effective Field Goal Percentage): The effective field goal percentage, which adjusts for the fact that three-point field goals are worth more than two-point field goals.
# FT (Free Throws Made): The average number of free throws made per game.
# FTA (Free Throws Attempted): The average number of free throws attempted per game.
# FT% (Free Throw Percentage): The free throw shooting percentage.
# ORB (Offensive Rebounds): The average number of offensive rebounds per game.
# DRB (Defensive Rebounds): The average number of defensive rebounds per game.
# TRB (Total Rebounds): The average number of total rebounds per game (offensive + defensive).
# AST (Assists): The average number of assists per game.
# STL (Steals): The average number of steals per game.
# BLK (Blocks): The average number of blocks per game.
# TOV (Turnovers): The average number of turnovers per game.
# PF (Personal Fouls): The average number of personal fouls per game.
# PTS (Points): The average number of points scored per game.
# Year: (Period) The year the statistics were recorded.

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
    # or assists per game compared to a previous period.

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

[string]$Global:PrimaryColor = "#4f94f0"

try {
    $Global:PlayerStatsNBA = Import-Csv -Path $csvfile -Delimiter "," | ForEach-Object {
        [PSCustomObject]@{
            Player = $_.Player
            Tm = $_.Tm
            Age = [float]$_.Age
            G = [int]$_.G
            GS = [int]$_.GS
            MP = [int]$_.MP
            FG = [float]$_.FG
            FGA = [float]$_.FGA
            FGPer = [float]$_."FG%"
            ThreePointerPerc = [float]$_."3P%"
            TwoPointers = [float]$_."2P"
            TwoPointerAttempts = [int]$_."2PA"
            TwoPointsPerc = [float]$_."2P%"
            eFGPerc = [float]$_."3FG%"
            FT = [float]$_.FT
            FTA = [float]$_.FTA
            FreeThrowPerc = [float]$_."FT%"
            ORB = [float]$_.ORB
            DRB = [float]$_.DRB
            TRB = [float]$_.TRB 
            STL = [float]$_.STL
            BLK = [float]$_.BLK 
            TOV = [float]$_.TOV 
            PF = [float]$_.PF 
            AST = [float]$_.AST
            PTS = [float]$_.PTS
            Year = [string]$_.Year
        }
    }

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

# Function to create a popup window object
function PopupWindowObject {
    param (
        [object]$Table,
        [string]$Title,
        [array]$ColumnNames
    )

    WriteColoredLine -text "*`n* Opening popup window:" -colorHex $PrimaryColor

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $Local:Form = New-Object System.Windows.Forms.Form
    $Local:Form.Text = $Title
    $Local:Form.Size = New-Object System.Drawing.Size(500, 550)
    $Local:Form.StartPosition = "CenterScreen"
    $Local:Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    $Local:Form.MaximizeBox = $False
    $Local:Form.MinimizeBox = $False
    $Local:Form.ControlBox = $True
    $Local:Form.BackColor = [System.Drawing.Color]::White

    $Local:ListView = New-Object System.Windows.Forms.ListView
    $Local:ListView.Location = New-Object System.Drawing.Point(10, 50)
    $Local:ListView.Size = New-Object System.Drawing.Size(460, 400)
    $Local:ListView.View = [System.Windows.Forms.View]::Details
    $Local:ListView.FullRowSelect = $True
    $Local:ListView.GridLines = $False
    $Local:ListView.BackColor = [System.Drawing.Color]::White
    $Local:ListView.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
    $Local:ListView.Font = New-Object System.Drawing.Font("Arial", 10)
    $Local:ListView.HeaderStyle = [System.Windows.Forms.ColumnHeaderStyle]::Clickable

    for ($i = 0; $i -lt $ColumnNames.Length; $i++) {
        $Local:ColumnHeader = New-Object System.Windows.Forms.ColumnHeader
        $Local:ColumnHeader.Text = $ColumnNames[$i]
        $Local:ColumnHeader.Width = -2
        $Local:ListView.Columns.Add($Local:ColumnHeader) | Out-Null
    }

    function Update-ListView {
        param (
            [string]$FilterText
        )

        $ListView.BeginUpdate()
        $ListView.Items.Clear()
        $FilteredTable = $Table | Where-Object {
            $matches = $false
            foreach ($column in $ColumnNames) {
                if ($_.($column) -like "*$FilterText*") {
                    $matches = $true
                    break
                }
            }
            $matches
        }

        $rowIndex = 0
        foreach ($row in $FilteredTable) {
            $ListViewItem = New-Object System.Windows.Forms.ListViewItem
            $ListViewItem.Text = $row.$($ColumnNames[0])
            for ($j = 1; $j -lt $ColumnNames.Length; $j++) {
                $ListViewItem.SubItems.Add($row.$($ColumnNames[$j])) | Out-Null
            }

            if ($rowIndex % 2 -eq 0) {
                $ListViewItem.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)
            } else {
                $ListViewItem.BackColor = [System.Drawing.Color]::White
            }

            $ListView.Items.Add($ListViewItem) | Out-Null
            $rowIndex++
        }
        $ListView.EndUpdate()
    }

    Update-ListView ""

    $Local:Footer = New-Object System.Windows.Forms.LinkLabel
    $Local:Footer.Location = New-Object System.Drawing.Point(10, 460)
    $Local:Footer.Size = New-Object System.Drawing.Size(460, 40)
    [string]$Local:CurrentDate = Get-Date -Format "yyyy"
    $Local:Footer.Text = "Designed by the EliasDH Team `n" + $CurrentDate + " EliasDH. All rights reserved."
    $Local:Footer.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $Local:Footer.LinkColor = [System.Drawing.ColorTranslator]::FromHtml($PrimaryColor)
    $Local:Footer.Links.Add(35, 7, "https://eliasdh.com") | Out-Null
    $Local:Footer.Font = New-Object System.Drawing.Font("Arial", 8)

    $Local:Footer.add_LinkClicked({
        param (
            $sender, 
            $element
        )
        [System.Diagnostics.Process]::Start($element.Link.LinkData.ToString()) | Out-Null
    })

    $Local:SearchBox = New-Object System.Windows.Forms.TextBox
    $Local:SearchBox.Location = New-Object System.Drawing.Point(10, 10)
    $Local:SearchBox.Size = New-Object System.Drawing.Size(360, 30)
    $Local:SearchBox.BackColor = [System.Drawing.Color]::White
    $Local:SearchBox.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
    $Local:SearchBox.Font = New-Object System.Drawing.Font("Arial", 10)
    $Local:SearchBox.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    $Local:SearchBox.add_TextChanged({
        Update-ListView $SearchBox.Text
    })

    $Local:ExportButton = New-Object System.Windows.Forms.Button
    $Local:ExportButton.Location = New-Object System.Drawing.Point(380, 10)
    $Local:ExportButton.Size = New-Object System.Drawing.Size(90, 30)
    $Local:ExportButton.Text = "Export All"
    $Local:ExportButton.BackColor = [System.Drawing.ColorTranslator]::FromHtml($PrimaryColor)
    $Local:ExportButton.ForeColor = [System.Drawing.Color]::White
    $Local:ExportButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $Local:ExportButton.Font = New-Object System.Drawing.Font("Arial", 10)
    $Local:ExportButton.add_Click({
        $CsvContent = $Table | Export-Csv -NoTypeInformation -Force -Path "$env:USERPROFILE\Desktop\export.csv"
        [System.Windows.Forms.MessageBox]::Show("Data exported to Desktop\export.csv", "Export Complete", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    })

    $Local:Form.Controls.Add($ListView)
    $Local:Form.Controls.Add($Footer)
    $Local:Form.Controls.Add($SearchBox)
    $Local:Form.Controls.Add($ExportButton)
    $Local:Form.ShowDialog()
}

# Function to create a popup window histogram
function PopupWindowHistogram {
    param (
        [string]$Title,
        [array]$CategoryArray,
        [array]$ValueArray
    )

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Windows.Forms.DataVisualization

    $Local:Form = New-Object Windows.Forms.Form
    $Local:Form.Text = $Title
    $Local:Form.Width = 600
    $Local:Form.Height = 550
    $Local:Form.StartPosition = "CenterScreen"
    $Local:Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    $Local:Form.MaximizeBox = $False
    $Local:Form.MinimizeBox = $False
    $Local:Form.ControlBox = $True
    $Local:Form.BackColor = [System.Drawing.Color]::White

    $Local:Chart = New-Object Windows.Forms.DataVisualization.Charting.Chart
    $Local:Chart.Width = 600
    $Local:Chart.Height = 400

    $Local:ChartArea = New-Object Windows.Forms.DataVisualization.Charting.ChartArea
    $Local:Chart.ChartAreas.Add($ChartArea)

    $Local:Series = New-Object Windows.Forms.DataVisualization.Charting.Series
    $Local:Series.Name = "Points"
    $Local:Series.ChartType = [System.Windows.Forms.DataVisualization.Charting.SeriesChartType]::Column
    $Local:Chart.Series.Add($Series)

    foreach ($Category in $CategoryArray) {
        $Local:Point = New-Object Windows.Forms.DataVisualization.Charting.DataPoint
        $Local:Point.AxisLabel = $Category
        $Local:Point.YValues = $ValueArray[$CategoryArray.IndexOf($Category)]
        $Local:Series.Points.Add($Point)
    }

    $Local:Footer = New-Object System.Windows.Forms.LinkLabel
    $Local:Footer.Location = New-Object System.Drawing.Point(80, 460)
    $Local:Footer.Size = New-Object System.Drawing.Size(460, 40)
    [string]$Local:CurrentDate = Get-Date -Format "yyyy"
    $Local:Footer.Text = "Designed by the EliasDH Team `n" + $CurrentDate + " EliasDH. All rights reserved."
    $Local:Footer.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $Local:Footer.LinkColor = [System.Drawing.ColorTranslator]::FromHtml($PrimaryColor)
    $Local:Footer.Links.Add(35, 7, "https://eliasdh.com") | Out-Null
    $Local:Footer.Font = New-Object System.Drawing.Font("Arial", 8)

    $Local:Footer.add_LinkClicked({
        param (
            $Sender, 
            $Element
        )
        [System.Diagnostics.Process]::Start($Sender.Link.LinkData.ToString()) | Out-Null
    })

    $Local:Form.Controls.Add($Chart)
    $Local:Form.Controls.Add($Footer)
    $Local:Form.ShowDialog()
}

# Function to find the top scorer with more than 40 games
function PopupWindowPieChart {
    param (
        [string]$Title,
        [array]$CategoryArray,
        [array]$ValueArray
    )

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Windows.Forms.DataVisualization

    $Local:Form = New-Object Windows.Forms.Form
    $Local:Form.Text = $Title
    $Local:Form.Width = 600
    $Local:Form.Height = 550
    $Local:Form.StartPosition = "CenterScreen"
    $Local:Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    $Local:Form.MaximizeBox = $False
    $Local:Form.MinimizeBox = $False
    $Local:Form.ControlBox = $True
    $Local:Form.BackColor = [System.Drawing.Color]::White

    $Local:Chart = New-Object Windows.Forms.DataVisualization.Charting.Chart
    $Local:Chart.Width = 600
    $Local:Chart.Height = 400

    $Local:ChartArea = New-Object Windows.Forms.DataVisualization.Charting.ChartArea
    $Local:Chart.ChartAreas.Add($ChartArea)

    $Local:Series = New-Object Windows.Forms.DataVisualization.Charting.Series
    $Local:Series.Name = "Points"
    $Local:Series.ChartType = [System.Windows.Forms.DataVisualization.Charting.SeriesChartType]::Pie
    $Local:Chart.Series.Add($Series)

    foreach ($Category in $CategoryArray) {
        $Local:Point = New-Object Windows.Forms.DataVisualization.Charting.DataPoint
        $Local:Point.AxisLabel = $Category
        $Local:Point.YValues = $ValueArray[$CategoryArray.IndexOf($Category)]
        $Local:Series.Points.Add($Point)
    }

    $Local:Footer = New-Object System.Windows.Forms.LinkLabel
    $Local:Footer.Location = New-Object System.Drawing.Point(80, 460)
    $Local:Footer.Size = New-Object System.Drawing.Size(460, 40)
    [string]$Local:CurrentDate = Get-Date -Format "yyyy"
    $Local:Footer.Text = "Designed by the EliasDH Team `n" + $CurrentDate + " EliasDH. All rights reserved."
    $Local:Footer.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $Local:Footer.LinkColor = [System.Drawing.ColorTranslator]::FromHtml($PrimaryColor)
    $Local:Footer.Links.Add(35, 7, "https://eliasdh.com") | Out-Null
    $Local:Footer.Font = New-Object System.Drawing.Font("Arial", 8)

    $Local:Footer.add_LinkClicked({
        param (
            $Sender, 
            $Element
        )
        [System.Diagnostics.Process]::Start($Sender.Link.LinkData.ToString()) | Out-Null
    })

    $Local:Form.Controls.Add($Chart)
    $Local:Form.Controls.Add($Footer)
    $Local:Form.ShowDialog()
}

# Function to find the top scorer with more than 40 games
function TopScorerWith40Games { # 1)
    param (
        [object]$Table
    )

    [array]$Local:TopPlayer = @()
    [int]$Local:AveragePoints = 0
    foreach ($Player in $Table) {
        if ($Player.G -gt 40) {
            if ($Player.PTS -gt $AveragePoints) {
                $TopPlayer = $Player
                $AveragePoints = $Player.PTS
            }
        }
    }

    PopupWindowObject -Table $TopPlayer -Title "Top Scorer with More than 40 Games" -ColumnNames @("Player", "G", "PTS")
}

# Function to find the best all-rounder
function HighestAveragePointsReboundsAssists { # 2)
    param (
        [object]$Table
    )

    [array]$Local:TopPlayer = @()
    [int]$Local:HighestTotal = 0
    foreach ($Player in $Table) {
        [int]$Local:Total = $Player.PTS + $Player.TRB + $Player.AST
        if ($Total -gt $HighestTotal) {
            $TopPlayer = $Player
            $HighestTotal = $Total
        }
    }

    PopupWindowObject -Table $TopPlayer -Title "Best All-Rounder" -ColumnNames @("Player", "PTS", "TRB", "AST")
}

# Function to find the top scorer per team
function TopScorerPerTeam { # 3)
    param (
        [object]$Table
    )

    [array]$Local:UniqueTeamNames = $Table | Select-Object -Property Tm -Unique
    [array]$Local:TopPlayers = @()
    [int]$Local:AveragePoints = 0
    foreach ($Team in $UniqueTeamNames) {
        $TopPlayers += $Table | Where-Object { $_.Tm -eq $Team.Tm } | Sort-Object -Property PTS -Descending | Select-Object -First 1
    }

    PopupWindowObject -Table $TopPlayers -Title "Top Scorer Per Team" -ColumnNames @("Player", "PTS", "Tm")
}

# Function to find players with more assists than points
function PlayersAssistsThanPoints { # 4)
    param (
        [object]$Table
    )

    [array]$Local:RelevantPlayers = @()
    foreach ($Player in $Table) {
        if ($Player.AST -gt $Player.PTS) {
            $RelevantPlayers += $Player
        }
    }

    PopupWindowObject -Table $RelevantPlayers -Title "Players with More Assists than Points" -ColumnNames @("Player", "PTS", "AST")
}

# Function to find players with most improved stats
function PlayersMostImprovedStats { # 5)
    param (
        [object]$Table
    )

    [array]$Local:ImprovedPlayers = @()
    [hashtable]$Local:PlayerImprovements = @{}

    # Loop through each player and calculate the improvement in PTS, TRB, and AST
    foreach ($Player in $Table) {
        # Split year range into start and end years
        $Years = $Player.Year -split "-"
        $StartYear = [int]$Years[0]
        $EndYear = [int]$Years[1]

        # Find the player stats for the start and end years
        $StartYearStats = $Table | Where-Object { $_.Player -eq $Player.Player -and $_.Year -eq "$StartYear-$StartYear" }
        $EndYearStats = $Table | Where-Object { $_.Player -eq $Player.Player -and $_.Year -eq "$EndYear-$EndYear" }

        if ($StartYearStats -and $EndYearStats) {
            $ImprovementPTS = [int]$EndYearStats.PTS - [int]$StartYearStats.PTS
            $ImprovementTRB = [int]$EndYearStats.TRB - [int]$StartYearStats.TRB
            $ImprovementAST = [int]$EndYearStats.AST - [int]$StartYearStats.AST

            if ($ImprovementPTS -gt 0 -or $ImprovementTRB -gt 0 -or $ImprovementAST -gt 0) {
                $PlayerImprovements[$Player.Player] = @{
                    PTS_Improvement = $ImprovementPTS
                    TRB_Improvement = $ImprovementTRB
                    AST_Improvement = $ImprovementAST
                    TotalImprovement = $ImprovementPTS + $ImprovementTRB + $ImprovementAST
                }
            }
        }
    }

    # Find the player with the highest total improvement
    $TopImprovedPlayer = $PlayerImprovements.GetEnumerator() | Sort-Object -Property Value.TotalImprovement -Descending | Select-Object -First 1

    if ($TopImprovedPlayer) {
        $ImprovedPlayers = $Table | Where-Object { $_.Player -eq $TopImprovedPlayer.Key }
        PopupWindowObject -Table $ImprovedPlayers -Title "Player with Most Improved Stats" -ColumnNames @("Player", "PTS_Improvement", "TRB_Improvement", "AST_Improvement", "TotalImprovement")
    } else {
        WriteColoredLine -text "* No player improvements found" -colorHex "#ff0000"
    }
}

# Function to calculate the average stats per team sorted by points
function AverageStatsPerTeamSortedPoints { # 6)
    param (
        [object]$Table
    )

    [array]$Local:UniqueTeamNames = $Table | Select-Object -Property Tm -Unique
    [array]$Local:AverageStatsPerTeam = @()
    
    foreach ($Team in $UniqueTeamNames) {
        [int]$Local:Points = 0
        [int]$Local:Rebounds = 0
        [int]$Local:Assists  = 0
        [int]$Local:TotalPlayersTeam = 0

        foreach ($Player in $Table) {
            if ($Player.Tm -eq $Team.Tm) {
                $Points += $Player.PTS
                $Rebounds += $Player.TRB
                $Assists += $Player.AST
                $TotalPlayersTeam++
            }
        }

        $AverageStatsPerTeam += [pscustomobject]@{
            TeamName = [string]$Team.Tm;
            AveragePoints = [int]($Points / $TotalPlayersTeam);
            AverageRebounds = [int]($Rebounds / $TotalPlayersTeam);
            AverageAssists = [int]($Assists / $TotalPlayersTeam);
        }
    }

    $AverageStatsPerTeam = $AverageStatsPerTeam | Sort-Object -Property AveragePoints -Descending

    PopupWindowObject -Table $AverageStatsPerTeam -Title "Average Stats Per Team Sorted by Points" -ColumnNames @("TeamName", "AveragePoints", "AverageRebounds", "AverageAssists")
}

# Function to calculate the Player Efficiency Rating (PER)
function CalculationPER { # 7)
    param (
        [object]$Table
    )

    [array]$Local:PERPlayers = @()
    foreach ($Player in $Table) {
        $MinutesPlayed = [decimal]::Parse($Player.MP)
        if ($MinutesPlayed -eq 0) {
            $PER = 0
        } else {
            $PTS = [decimal]::Parse($Player.PTS)
            $TRB = [decimal]::Parse($Player.TRB)
            $AST = [decimal]::Parse($Player.AST)
            $STL = [decimal]::Parse($Player.STL)
            $BLK = [decimal]::Parse($Player.BLK)
            $FGA = [decimal]::Parse($Player.FGA)
            $FGM = [decimal]::Parse($Player.FGM)
            $FTA = [decimal]::Parse($Player.FTA)
            $FTM = [decimal]::Parse($Player.FTM)
            $TOV = [decimal]::Parse($Player.TOV)
            
            $PER = ($PTS + $TRB + $AST + $STL + $BLK - ($FGA - $FGM) - ($FTA - $FTM) - $TOV) / $MinutesPlayed
        }
        $PERPlayers += $Player | Add-Member -MemberType NoteProperty -Name PER -Value $PER -PassThru
    }

    $PERPlayers = $PERPlayers | Sort-Object -Property PER -Descending

    PopupWindowObject -Table $PERPlayers -Title "Player Efficiency Rating (PER) Calculation" -ColumnNames @("Player", "PER")
}

# Function to find the player with the highest points to games ratio
function PointsToGamesRatio { # 8)
    param (
        [object]$Table
    )

    [array]$Local:TopPlayer = @()
    [decimal]$Local:HighestRatio = 0
    foreach ($Player in $Table) {
        if ($Player.G -gt 0) {
            $Ratio = $Player.PTS / [int]$Player.G
            if ($Ratio -gt $HighestRatio) {
                $TopPlayer = [pscustomobject]@{
                    Player = $Player.Player
                    PTS = $Player.PTS
                    G = $Player.G
                    Ratio = $Ratio
                }
            }
        }
    }

    PopupWindowObject -Table $TopPlayer -Title "Player with the Highest Points to Games Ratio" -ColumnNames @("Player", "PTS", "G", "Ratio")
}

# Function to determine players who have improved over time
function DeterminePlayersImprovedOverTime { # 9)
    param (
        [object]$Table
    )

    [array]$Local:ImprovedPlayers = @()
    foreach ($Player in $Table) {
        $FirstHalf = $Table | Where-Object { $_.Player -eq $Player.Player -and $_.G -le 20 }
        $SecondHalf = $Table | Where-Object { $_.Player -eq $Player.Player -and $_.G -gt 20 }
    
        if ($FirstHalf -and $SecondHalf) {
            $FirstHalfPoints = ($FirstHalf | Measure-Object -Property PTS -Average).Average
            $SecondHalfPoints = ($SecondHalf | Measure-Object -Property PTS -Average).Average
    
            if ($SecondHalfPoints -gt $FirstHalfPoints) {
                $Improvement = $SecondHalfPoints - $FirstHalfPoints
                $ImprovedPlayers += $Player | Add-Member -MemberType NoteProperty -Name Improvement -Value $Improvement -PassThru
            }
        }
    }

    PopupWindowObject -Table $ImprovedPlayers -Title "Players Who Have Improved Over Time" -ColumnNames @("Player", "Improvement")
}

# Function to analyze team performance over time
function AnalyzeTeamPerformanceOverTime { # 10)
    param (
        [object]$Table
    )

    [string]$Local:Selected = ReadColoredLine -text "* Histogram or PieChart (H/P)" -colorHex $PrimaryColor

    [array]$Local:Teams = $Table | Select-Object -Property Tm -Unique
    foreach ($Team in $Teams) {
        [array]$Local:TeamData = $Table | Where-Object { $_.Tm -eq $Team.Tm }
        [array]$Local:GameNumbers = $TeamData | Select-Object -Property G -Unique | Sort-Object -Property G
        [array]$Local:Performance = @()
        
        foreach ($Game in $GameNumbers) {
            $GameData = $TeamData | Where-Object { $_.G -eq $Game.G }
            $AveragePoints = ($GameData | Measure-Object -Property PTS -Average).Average
            $Performance += [pscustomobject]@{
                Game = $Game.G
                AveragePoints = $AveragePoints
            }
        }

        [string]$Local:NameTeam = $Team.Tm
        WriteColoredLine -text "*`n* Analyzing team performance over time for $NameTeam" -colorHex $Global:PrimaryColor

        if ($Selected -eq "H") {
            PopupWindowHistogram -Title "Team ($NameTeam) Performance Over Time" -CategoryArray @($Performance.Game) -ValueArray @($Performance.AveragePoints)
        } elseif ($Selected -eq "P") {
            PopupWindowPieChart -Title "Team ($NameTeam) Performance Over Time" -CategoryArray @($Performance.Game) -ValueArray @($Performance.AveragePoints)
        } else {
            ExitScript "* Not a valid input" 1
        }
    }
}

# Function to start the script
function Main {
    BannerMessage "Example Exam 2" $PrimaryColor

    WriteColoredLine -text "*`n* Which flow would you like to do:`n* 1)  Top Scorer with More than 40 Games`n* 2)  Best All-Rounder`n* 3)  Top Scorer Per Team`n* 4)  Players with More Assists than Points`n* 5)  Players with Most Improved Stats`n* 6)  Average Stats Per Team Sorted by Points`n* 7)  Player Efficiency Rating (PER) Calculation`n* 8)  Find the Player with the Highest Points to Games Ratio`n* 9)  Determine Players Who Have Improved Over Time`n* 10) Analyze Team Performance Over Time`n* 11) Exit" -colorHex $PrimaryColor
    [int]$Local:Number = ReadColoredLine -text "* Enter the number" -colorHex $PrimaryColor

    switch ($Number) {
        1 {
            BannerMessage "Top Scorer with More than 40 Games" $PrimaryColor
            TopScorerWith40Games $PlayerStatsNBA
        }
        2 {
            BannerMessage "Best All-Rounder" $PrimaryColor
            HighestAveragePointsReboundsAssists $PlayerStatsNBA
        }
        3 {
            BannerMessage "Top Scorer Per Team" $PrimaryColor
            TopScorerPerTeam $PlayerStatsNBA
        }
        4 {
            BannerMessage "Players with More Assists than Points" $PrimaryColor
            PlayersAssistsThanPoints $PlayerStatsNBA
        }
        5 {
            BannerMessage "Players with Most Improved Stats" $PrimaryColor
            PlayersMostImprovedStats $PlayerStatsNBA
        }
        6 {
            BannerMessage "Average Stats Per Team Sorted by Points" $PrimaryColor
            AverageStatsPerTeamSortedPoints $PlayerStatsNBA
        }
        7 {
            BannerMessage "Player Efficiency Rating (PER) Calculation" $PrimaryColor
            CalculationPER $PlayerStatsNBA
        }
        8 {
            BannerMessage "Find the Player with the Highest Points to Games Ratio" $PrimaryColor
            PointsToGamesRatio $PlayerStatsNBA
        }
        9 {
            BannerMessage "Determine Players Who Have Improved Over Time" $PrimaryColor
            DeterminePlayersImprovedOverTime $PlayerStatsNBA
        }
        10 {
            BannerMessage "Analyze Team Performance Over Time" $PrimaryColor
            AnalyzeTeamPerformanceOverTime $PlayerStatsNBA
        }
        11 { # Exit
            ExitScript "* Exiting the script" 0
        }
        Default {
            ExitScript "* Not a valid input" 1
        }
    }
}

while ($True) {
    Main # Start the script
}