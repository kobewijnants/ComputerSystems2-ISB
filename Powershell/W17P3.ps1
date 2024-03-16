############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################

# (-eq is =) (-ne is !=) (-lt is <) (-le is <=) (-gt is >) (-ge is >=)

# Set powershell execution policy to unrestricted
set-executionpolicy unrestricted

# Exemple "if" statement
if ($true) {
    Write-Host "This is true"
} else {
    Write-Host "This is false"
}

# Exemple "switch" statement
$var = 1
switch ($var) {
    1 { Write-Host "One" }
    2 { Write-Host "Two" }
    3 { Write-Host "Three" }
    default { Write-Host "Other" }
}

# Exemple "while" loop
$i = 0
while ($i -lt 5) {
    Write-Host $i
    $i++
}

# Exemple "do while" loop
$i = 0
do {
    Write-Host $i
    $i++
} while ($i -lt 5)

# Exemple "do until" loop
$i = 0
do {
    Write-Host $i
    $i++
} until ($i -eq 5)

# Exemple "foreach" loop
$fruits = @("apple", "banana", "cherry")
foreach ($fruit in $fruits) {
    Write-Host $fruit
}

# Exemple "for" loop
for ($i = 0; $i -lt 5; $i++) {
    Write-Host $i
}

# Exemple "exit" statement
exit

############################

# Prompt the user for input
Write-Host "--------------"

# 
$a = Read-Host "Geef input"

# Clear the console
Clear-Host

# Print the output in a window grid
Get-Process | Out-GridView

# Print the output in a window grid with single selection mode
Get-process | Out-GridView -OutputMode Single

# Print the output in a window grid with multiple selection mode -> $a will be an array
$a = Get-Process | Out-GridView -OutputMode Multiple

############################

# Exemple "parameters" statement
# Maak-Deling.ps1 20 5
if ($args.count -ne 2) {
    Write-Host "GEBRUIK: Maak-Deling deeltal deler"
}
else {
    Write-Host ($args[0] / $args[1])
}

# Exemple "Param" statement
# Maak-Deling.ps1 -deeltal 20 -deler 5
# Maak-Deling.ps1 20 5
Param(
    [int]$deeltal=1,
    [int]$deler=1
)

############################

# Exemple "function" statement
function test1 ($a, $b) {
    return $a + $b
}
test1 1 2

# Exemple "function" statement with default values
function test2 {
    param(
        [int]$a=1,
        [int]$b=1
    )
    return $a + $b
}
test2 1 2

############################

function FahrenhToCelsius ($f) { return ($f - 32) * (5/9) }
FahrenhToCelsius 68

function CelsiusToFahrenh ($c) { return ($c * (9/5)) + 32 }
CelsiusToFahrenh 20

# Show all functions
Get-Command -type Function

# Drop a function
Remove-Item function:FahrenhToCelsius
Remove-Item function:CelsiusToFahrenh

############################