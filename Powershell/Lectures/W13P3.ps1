############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Powershell Introduction

# Get the current date
$CurrentDate = Get-Date -Format "dd/MM/yyyy"

# This will display the version (PSVersion)
$PSVersionTable

# This will display the processes running on the system
Get-Process

# This will display the services running on the system
Get-Service

# This will display the current location
Get-Location

# This will change the current location to C:\Program Files
Set-Location "c:\Program Files"

# This will display the items in the current location
Get-ChildItem

# This will display the items in the C:\Windows directory that have the .exe extension
Get-ChildItem "c:\Windows" *.exe

# This is the same as the previous command, but with name parameter
Get-ChildItem -Path "c:\Windows" -Filter *.exe

# -Recurse = -r = Recursively
Get-ChildItem -Path "c:\Windows" -Filter *.exe -Recurse

# This will display information about the Get-ChildItem cmdlet
Get-Help Get-ChildItem

# This will display detailed information about the Get-ChildItem cmdlet
Get-Help Get-ChildItem -Detailed

# This will display list of all Get cmdlets
Get-Command Get-*

# This will display list of all cmdlets that have the word "time" in their name
Get-Help time

############################

# Toon alle cmdlets die eindigen op "-object"
Get-Command *-object

# Geef gedetailleerde help voor "Get-Service"
Get-Help Get-Service -Detailed

# Zoek Cmdlets die iets te maken hebben met "output"
Get-Help output
# Or
Get-Command *output*

# Zoek hoe je alle "variabelen" kan tonen
Get-Help *variable*
Get-Variable -Name

# Zijn "sleep", "mkdir", "more" Cmdlets? Wat zijn het dan wel?
Get-Command sleep
Get-Command mkdir
Get-Command more

############################

# This will multiply 2 by 45
2 * 45

# This concatenates the strings "Hello" and "world"
"Hello" + " " + "world"

# This will display the result of 5 + 9
Write-Output (5+9)

# This will display the result of 5 + 9 using the $result variable
$result = (5+9)
Write-Output $result

# This will concatenate variable $home with the string "\Documents"
# Display the ChildItems in the resulting path
Get-ChildItem ($home + "\Documents")

# This will display the current date and time
$datum = Get-Date; Write-Output $datum

############################
# Rekenkundig: +, -, *, /, --, ++
# Assignment: =, +=, -=, *=, /=
# Vergelijken: -eq, -ne, -lt, -le, -gt, -ge
# String: +, -like, -replace
# Redirection: >, >>, 2>, 2>>
# Boolean: $true, $false, -not, !, -and, -or
# Arrays: @(), +=, []
# Environment: $Env:Path
# Aliases: Get-Alias, Set-Alias
############################

# Schrijf "Dag wereld" in file "output.txt"
"Dag wereld" > output.txt
Get-Content output.txt

# Voeg resultaat van 256*64 toe aan de file "output.txt"
256*64 >> output.txt
Get-Content output.txt

# Stel de variabele $varCalc gelijk aan de string "calc".
# Voer de inhoud van $varCalc uit als een commando.
$varCalc = "calc"
Invoke-Expression $varCalc
# Or
&$varCalc

# This will get a boolean value of $true
"Dag wereld" -like "*we*"

# This will replace the string "Dag" with "Daaag"
"Dag wereld" -replace "Dag", "Daaag"

############################

# Imlpiciet declaration
$a = 5
$b = "Hello"

# Explicit declaration
[int] $c = 5
[string] $d = "Hello"
[double] $pi=3.14159
[array] $s= @("Hello", "World", "!")

# This will convert the string "5" to an integer
$e = [int] "5"

# This will convert the integer 5 to a string
$f = [string] $a

# Array declaration
$arr1 = @("Hello", "World", "!")
$arr2 = 1, 2, 3

# Display the first element of the array
$arr1[0]
$arr2[0]

# Add an element to the array
$arr1 += "Goodbye"

############################

# This will display the value of the $Env:Path variable
# $Env:Path is a system environment variable
# We can use it to find the location of executables
$Env:Path

# Add a .exe file to the $Env:Path variable (Apache)
$Env:Path += ";c:\apache24\bin"

# Zoek de commanlets voor de volgende aliassen:
# cat, echo, man, ls, ps, cd, pwd, cp, rm, mv, kill, history
Get-Alias -Name "cat", "echo", "man", "ls", "ps", "cd", "pwd", "cp", "rm", "mv", "kill", "history"

# Set the alias "vi" to the "notepad" command
Set-Alias -Name "vi" -Value "notepad"
# Or
Set-Alias vi notepad

############################
# Exercise 1

# Stop alle processen waarvan de naam met een "m" begint in de variabele "$proc"
    # Toon de inhoud van $proc.
    # Welk soort variabele is $proc?
    # Toon het 4de element van $proc.

$proc = Get-Process m*
Write-Output $proc
Write-Output $proc.GetType()
Write-Output $proc[3]

# Exercise 2

# Toon alle sub-directories (geen files) van "C:\Program" Files 
# waarvan de naam met een "w" begint en schrijf de output in een 
# file "out.txt" (kies zelf de locatie). Geef de parameternamen mee aan het commando.
    # Toon de inhoud van de file gebruik makende van de Linux alias "cat".

Get-ChildItem -Path "C:\Program Files" -Directory -Filter w* > out.txt
Get-Content out.txt
# Or cat out.txt

# Exercise 3

# Maak een array genaamd $fibo aan met volgende elementen: 1,1,2,3,5,8. 
# gebruik een expliciete declaratie.
    # Tel het "4de" en het "5de" element van $fibo op, converteer het resultaat naar 
    # een string en stop deze in een variabele $som

    # Converteer de variabele $som naar een integer en voeg deze 
    # toe als "6de" element aan de array "$fibo"

[array] $fibo = 1,1,2,3,5,8

$som = [string] ($fibo[4] + $fibo[5])
$fibo += [int] $som

############################