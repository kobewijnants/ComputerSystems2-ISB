############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 25/04/2024        #
############################

<#
.SYNOPSIS
    Test Apache server.
.DESCRIPTION
    This script tests the Apache server by checking the status of multiple URLs.
    It uses the Invoke-WebRequest cmdlet to check the status of the URLs.
    If the connection fails, it will display the error message.
.EXAMPLE
    Test-Apache.ps1
.NOTES
File: Test-Apache.ps1
Author: Elias De Hondt
Version: 1.0
#>

$urls = @(
    "http://localhost",                     # Main website
    "http://localhost:8080",                # Second website (Authentication)
    "http://localhost/google",              # Redirect to Google
    "http://localhost/test",                # Directory Auto Index
    "http://localhost/test2",               # .htaccess
    "http://localhost/test2/index.html",    # .htaccess
    "http://localhost/server-info"          # Server Info
)

foreach ($url in $urls) {
    Write-Host "Checking $url"
    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing
        Write-Host "Failed with status code: $($response.StatusCode)"
    } catch {
        Write-Host "Failed to connect: $($_.Exception.Message)"
    }
    Write-Host ""
}