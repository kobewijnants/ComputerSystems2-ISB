############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Powershell Active Directory


# Active Directory Module
Get-Module # View all modules that are loaded

Get-Module -ListAvailable # View all modules that are available

Import-Module ActiveDirectory # Import the Active Directory module

Get-Command -Module ActiveDirectory # View all commands in the Active Directory module


# Get Info of domain
Get-ADDomain # Get info of the domain

Get-ADDomainController # Get info of the domain controller

Get-ADDefaultDomainPasswordPolicy # Get the default domain password policy


# Get Info of users/Computers
Get-ADUser -Filter * # Get all users

Get-ADUser student1 # Get info of a user

Get-ADComputer -Filter * # Get all computers

Get-ADComputer -Identity CLIENT1 # Get info of a computer

Get-ADUser -Filter * | Get-Member # Get all properties of a user

Get-ADUser -Filter {Enabled -eq $true} # Get all enabled users

Get-ADUser -Filter {Name -like "Doc*"} # Get all users with a name starting with "Doc"

Get-ADUser -Filter * | Select-Object Name, Enabled # Get all users with a name starting with "Doc" and only show the Name and SamAccountName

Get-ADUser -Filter * -SearchBase "OU=Studenten,DC=dehondt,DC=local" # Get all users in a specific OU


# Get Info of groups/OUs
Get-ADGroup -Filter * # Get all groups

Get-ADOrganizationalUnit -Filter * # Get all OUs

New-ADGroup -Name "TestGroup" -GroupScope Global -GroupCategory Security # Create a new group

New-ADOrganizationalUnit -Name "TestOU" # Create a new OU

Remove-ADGroup -Identity "TestGroup" # Remove a group

Remove-ADOrganizationalUnit -Identity "TestOU" # Remove an OU


# Enable/disable user, change password
Enable-ADAccount -Identity student1 # Enable a user

Disable-ADAccount -Identity student1 # Disable a user

Set-ADAccountPassword -Identity student1 -NewPassword (ConvertTo-SecureString -AsPlainText "123" -Force) # Change the password of a user
# Set-ADAccountPassword -Identity student1 -NewPassword (ConvertTo-SecureString -AsPlainText "student1" -Force)