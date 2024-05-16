############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Check-Site.ps1

<#
.SYNOPSIS
    Check if a server and a website are up and running.
.DESCRIPTION
    This script checks if a server and a website are up and running.
    It logs the results in a log file.
.EXAMPLE
    Check-Site.ps1
.NOTES
File: Check-Site.ps1
Author: Elias De Hondt
Version: 1.0
#>

$logFile = "../Data/Check-Site.log"
$ip = "192.168.70.136"
$protocol = "http"
$port = "3000"
$site = $protocol + "://" + $ip + ":" + $port

while ($True) {
    $currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    try {
        $result = Test-Connection $ip -Count 1 -ErrorAction Stop
        if ($result.StatusCode -eq 0) {
            $logItem1 = "Server Up"
        } else {
            $logItem1 = "Server Down"
        }
    } catch {
        $logItem1 = "Server Down"
    }

    try {
        $response = Invoke-WebRequest -Uri $site -Method Get -TimeoutSec 1
        if ($response.Content.Contains("DEHONDT")) {
            $logItem2 = "Web Up"
        } else {
            $logItem2 = "Web Down"
        }
    } catch {
        $logItem2 = "Web Down"
    }

    $logline = "(" + $logItem1 + ") - (" + $logItem2 + ") on: " + $currentTime

    Write-Host $logline
    $logline | Out-File -FilePath $logFile -Append
    Start-Sleep -Seconds 2
}