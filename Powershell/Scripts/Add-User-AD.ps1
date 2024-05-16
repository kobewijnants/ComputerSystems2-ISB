############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################

<#
.SYNOPSIS

.DESCRIPTION
    This script adds users to Active Directory.
    It uses a CSV file to define the users to add.
    The script then adds the users to Active Directory.
.EXAMPLE
    Add-User-AD.ps1
.NOTES
File: Add-User-AD.ps1
Author: Elias De Hondt
Version: 1.0
#>

function Create-UserAccount {
    param (
        [string]$Name,
        [string]$SamAccountName,
        [string]$DisplayName,
        [string]$Path
    )
    $Password = ConvertTo-SecureString "student" -AsPlainText -Force
    $UserParams = @{
        Name           = $Name
        SamAccountName = $SamAccountName
        DisplayName    = $DisplayName
        Path           = $Path
        AccountPassword = $Password
        Enabled        = $true
    }
    New-ADUser @UserParams
}

$csvfile = '..\Data\UserAD.csv'

if (-not (Test-Path $csvfile)) {
    Write-Host "Error: The specified CSV file does not exist: $csvfile" -ForegroundColor Red
    Exit
}

$Users = Import-Csv $csvfile -Delimiter ";"

foreach ($User in $Users) {
    Create-UserAccount -Name $User.Name -SamAccountName $User.SamAccountName -DisplayName $User.DisplayName -Path $User.Path
}