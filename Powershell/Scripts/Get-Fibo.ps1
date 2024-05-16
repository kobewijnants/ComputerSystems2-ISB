############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Get-Fibo.ps1

<#
.SYNOPSIS
    This script calculates the n-th Fibonacci number.
.DESCRIPTION
    This script calculates the n-th Fibonacci number.
.EXAMPLE
    Get-Fibo.ps1
.NOTES
File: Get-Fibo.ps1
Author: Elias De Hondt
Version: 1.0
#>

function Get-Fibo {
    param (
        [int]$n
    )

    $fibonacci = @() # Create an empty array
    for ($i = 0; $i -le $n; $i++) { # Loop from 0 to n
        if ($i -eq 0) {
            $fibonacci += 0 # Add 0 to the array if i is 0
        }
        elseif ($i -eq 1) {
            $fibonacci += 1 # Add 1 to the array if i is 1
        }
        else {
            $fibonacci += ($fibonacci[$i - 1] + $fibonacci[$i - 2]) # Add the sum of the two previous numbers to the array
        }
    }

    return $fibonacci
}

$n = Read-Host "Please select a number"
if (-not ($n -match '^\d+$')) { # Check if n is a number
    Write-Host "Please enter a valid number"
    Start-Sleep -Seconds 10
    exit 1
}

$fibonacci = Get-Fibo -n $n # Get the Fibonacci numbers up to n
Write-Host "The Fibonacci numbers up to $n are:"
$fibonacci | ForEach-Object { Write-Host $_ } # Show the Fibonacci numbers from 0 to n from the array $fibonacci
Start-Sleep -Seconds 10