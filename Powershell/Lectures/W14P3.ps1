############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Files en directories

pwd # Print working directory
# Or
Get-Location # Get-Location

cd C:\Users\elias # Change directory
# Or
Set-Location C:\Users\elias # Set-Location

New-Item -ItemType Directory -Path C:\Users\elias\Documents\NewFolder # Create a new directory

rm C:\Users\elias\Documents\NewFolder # Remove a directory
# Or
Remove-Item -Path C:\Users\elias\Documents\NewFolder # Remove a directory

cp C:\Users\elias\Documents\NewFolder C:\Users\elias\Documents\NewFolderCopy # Copy a directory
# Or
Copy-Item -Path C:\Users\elias\Documents\NewFolder -Destination C:\Users\elias\Documents\NewFolderCopy # Copy a directory

mv C:\Users\elias\Documents\NewFolder C:\Users\elias\Documents\NewFolderCopy # Move a directory
# Or
Move-Item -Path C:\Users\elias\Documents\NewFolder -Destination C:\Users\elias\Documents\NewFolderCopy # Move a directory

Rename-Item -Path C:\Users\elias\Documents\NewFolder -NewName NewFolderRenamed # Rename a directory

Test-Path -Path C:\Users\elias\Documents\NewFolder # Test if a directory exists

Get-Content -Path C:\Users\elias\Documents\NewFolder\file.txt # Get the content of a file

Set-Content -Path C:\Users\elias\Documents\NewFolder\file.txt -Value "Hello, World!" # Set the content of a file

Add-Content -Path C:\Users\elias\Documents\NewFolder\file.txt -Value "Hello, World!" # Add content to a file
############################

New-Item $home\new_file.txt
New-Item $home\new_dir -type directory
New-Item $home\new_file.txt -type file -force -value "This is text added to the file!`r`n"
Add-Content $home\new_file.txt "This line too!!"
Get-Content $home\new_file.txt
Remove-Item $home\new_dir -Force -Recurse
Remove-Item $home\new_file.*

############################
# Providers

Get-PSDrive # Get the drives in the current session

Get-PSDrive -PSProvider FileSystem # Get the drives in the current session for the FileSystem provider

Get-ChildItem Variable: # Get the variables in the current session
cat .\MaximumDriveCount # Get the content of the MaximumDriveCount variable

Set-Location HKCU: # Set-Location to the HKEY_CURRENT_USER registry key


############################

Get-ChildItem Env:
cd HKCU:\
ls
Set-Location Software
New-Item -Path HKCU:\Software\gdp -Value "gdp key"
ls

############################
# Omgevingsvariabelen

$a = 1 # Set a variable

$env:b = 2 # Set an environment variable

ls env: # List the environment variables

New-Item -Path env:\TEST -Value "Hello, World!" # Create a new environment variable
# Or
$env:TEST = "Hello, World!" # Create a new environment variable

$env:TEST # Get the value of an environment variable

$env:TEST += "!" # Append to an environment variable

Remove-Item -Path env:\TEST # Remove an environment variable
############################

# 1. Test of de file C:\Windows\System32\drivers\etc\hosts bestaat
Test-Path -Path C:\Windows\System32\drivers\etc\hosts
# 2. Kopieer deze file naar jou home directory
Copy-Item -Path C:\Windows\System32\drivers\etc\hosts -Destination C:\Users\elias
# 3. Toon de inhoud van deze file
Get-Content -Path C:\Windows\System32\drivers\etc\hosts
# 4. Voeg volgende lijn toe aan de gekopieerde host file:
# Deze file is een alternatief voor de DNS
Add-Content -Path C:\Users\elias\hosts -Value "Deze file is een alternatief voor de DNS"
# 5. Verwijder deze file uit jou home directory
Remove-Item -Path C:\Users\elias\hosts
# 6. Toon alle functies op het scherm
Get-Command -CommandType Function
# 7. Toon de code van de functie more
Get-Content function:more
# 8. Toon alle registry keys in HKEY_LOCAL_MACHINE
Get-Content HKCU:
# 9. Maak de alias vi uit vorige les terug aan. Test deze uit. Verwijder nu terug deze alias.
New-Alias -Name vi -Value notepad
# 10. Verwijder de HKCU:\Software\gdp key
Remove-Item -Path HKCU:\Software\gdp
# 11. Log aan op een Windows Server met Active Directory en open Powershell:
Import-Module ActiveDirectory
Get-PSDrive
# 11.1. Maak via ADUC een user "UserTestPS" aan onder "OU Studenten"
# /
# 11.2. Navigeer naar de juiste AD map en verwijder de user "UserTestPS" via Powershell
cd AD:
ls
cd "DC=dehondt,DC=local"
ls
cd "OU=Studenten"
Remove-ADUser -Identity "UserTestPS"

############################