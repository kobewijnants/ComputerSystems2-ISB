############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################

<#
.SYNOPSIS
    This script gets soccer data from a CSV file.
.DESCRIPTION
    This script gets soccer data from a CSV file.
    It can get matches on a specific date, matches from a specific team, count the number of matches, count the number of wins, count the number of draws, calculate the score of a team, get a list of teams, and get the standings of a league.
.EXAMPLE
    Get-Soccer.ps1
.NOTES
File: Get-Soccer.ps1
Author: Elias De Hondt
Version: 1.0
#>

Param(
  [String]$file = ".\voetbal.csv"
)

try {
    $matchen = Import-Csv $file
} catch {
    Write-Host "Error: No CSV file" -ForegroundColor Red
    exit
}

function Get-DateMatchen ($matchen, $date, $land) {
  [Array]$MatchesOnDay = $null
  foreach ($match in $matchen) {
    if ($match.date -eq $date) {
      if ($match.country -like $land) {
        $MatchesOnDay += $match
      }
    }
  }
  return $MatchesOnDay | Select-Object -Property "season", "date", "hometeam", "awayteam", "pointhome", "pointaway"
}

function Get-TeamMatchen ($matchen, $seizoen, $land, $ploeg, $type) {
  [Array]$matchesFromTeam = $null
  if($type -like "home*") {
    foreach ($match in $matchen) {
      if ($match.hometeam -like $ploeg -and $match.season -eq $seizoen -and $match.country -like $land) {
        $matchesFromTeam += $match
      }
    }
  }
  if($type -like "*away") {
    foreach ($match in $matchen) {
      if ($match.awayteam -like $ploeg -and $match.season -eq $seizoen -and $match.country -like $land) {
        $matchesFromTeam += $match
      }
    }
  }
  
  return $matchesFromTeam | Select-Object -Property "season", "date", "hometeam", "awayteam", "pointhome", "pointaway"
}

function Count-Matchen ($matchen, $seizoen, $land, $ploeg) {
  $teamMatchen = Get-TeamMatchen $matchen $seizoen $land $team "homeaway"
  $counter=0
  $teamMatchen | ForEach-Object {
    $counter++
  }
  # $counter = ($teamMatchen | Measure-Object).Count
  # OR
  # return Get-TeamMatchen $matchen $seizoen $land $team "homeaway" | Measure-Object | Select-Object -ExpandProperty Count
  return $counter
}

function Count-Gelijk ($matchen, $seizoen, $land, $ploeg) {
  $teamMatchen = Get-TeamMatchen $matchen $seizoen $land $team "homeaway"
  $counter=0
  $teamMatchen | ForEach-Object {
    if($_.pointaway -eq $_.pointhome) {
      $counter++
    }
  }
  # return Get-TeamMatchen $matchen $seizoen $land $team "homeaway" | ? {$_.pointaway -eq $_.pointhome} | Measure-Object | Select-Object -ExpandProperty Count
  return $counter
  }

function Count-Win ($matchen, $seizoen, $land, $ploeg) {
  $teamMatchen = Get-TeamMatchen $matchen $seizoen $land $team "homeaway"
  $counter=0
  $teamMatchen | ForEach-Object {
    if($_.awayteam -like $ploeg){
      if($_.pointaway -gt $_.pointhome) {
        $counter++
      }
    } elseif($_.hometeam -like $ploeg) {
      if($_.pointaway -lt $_.pointhome) {
        $counter++
      }
    }
  }
  # return Get-TeamMatchen $matchen $seizoen $land $team "homeaway" | ? {($_.awayteam -like $ploeg -and $_.pointaway -gt $_.pointhome) -or ($_.hometeam -like $ploeg -and $_.pointaway -lt $_.pointhome)} | Measure-Object | Select-Object -ExpandProperty Count
  return $counter
  }

function Score-Team ($matchen, $seizoen, $land, $ploeg) {
  return (((Count-Win $matchen $seizoen $land $ploeg) * 3) + (Count-Gelijk $matchen $seizoen $land $ploeg))
}

function Get-Teams ($matchen, $seizoen, $land) {
  return $matchen | ? {$_.season -eq $seizoen -and $_.country -like $land} | Select-Object -Property hometeam -Unique | % {$_.hometeam}
}

function Get-Classement ($matchen, $seizoen, $land) {
  $teams = Get-teams $matchen $seizoen $land

  [Array]$teamscores = $null
  foreach($team in $teams){
    $score = Score-Team $matchen $seizoen $land $team
    $teamscores += [pscustomobject] @{
      team = $team
      score = $score
    }
  }
  $teamscores | Sort-Object -Property score -Descending | % {Write-Host $_.team $_.score}
}

$seizoen = 2016
$land = "spain"
$team = "Barcelona"
$date = "2015-09-20"

Get-DateMatchen $matchen $date $land | Out-GridView
Get-TeamMatchen $matchen $seizoen $land $team "away" | Out-GridView
Count-Matchen $matchen $seizoen $land $team
Count-Gelijk $matchen $seizoen $land $team
Count-Win $matchen $seizoen $land $team
Score-Team $matchen $seizoen $land $team
Get-Teams $matchen $seizoen $land | Out-GridView
Get-Classement $matchen $seizoen $land