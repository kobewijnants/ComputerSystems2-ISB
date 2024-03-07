############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################

# Get the first 10 services and convert the output to csv.
Get-Service | Select-Object -First 10 | Export-Csv service.csv

# Open the file.
Invoke-Item service.csv

# Import the file.
$service = import-CSV service.csv

# Show the fifth service.
$service[4]

# Delete the file.
Remove-Item service.csv

# Get the first 10 services and convert the output to json.
Get-Service | Select-Object -First 10 | ConvertTo-Json # Or xml or csv

# Convert the json to a powershell object.
'{"name":"Elias De Hondt","leeftijd":22}' | ConvertFrom-Json

# Get the first 5 services and convert the output to json and save it to a file.
Get-Service | Select-Object -first 5 -Property Name, Status | ConvertTo-Json | Out-File service.json

# Get the content of the file and convert it to a powershell object.
$service = Get-Content .\service.json | ConvertFrom-Json

# Delete the file.
Remove-Item service.json

# Gat all services and convert the output to html and save it to a file.
Get-Service | ConvertTo-Html | Out-File service.html

# Delete the file.
Remove-Item service.html

############################

New-Item -Path C:\Users\elias\Desktop -Name files.csv -ItemType File
Add-Content -Path C:\Users\elias\Desktop\files.csv -Value "Path;Type"
Add-Content -Path C:\Users\elias\Desktop\files.csv -Value "C:\Temp\Studenten;Directory"
Add-Content -Path C:\Users\elias\Desktop\files.csv -Value "C:\Temp\Docenten;Directory"
Add-Content -Path C:\Users\elias\Desktop\files.csv -Value "C:\Temp\Studenten\Student1;File"
Add-Content -Path C:\Users\elias\Desktop\files.csv -Value "C:\Temp\Docenten\Docent1;File"

$files = Import-Csv .\files.csv -Delimiter ";"
$files
$files.Path
$files | % { New-Item -Path $_.Path -Type $_.Type -Value ""}

############################

# 1. SPut the array below in the variable "$fruit" "meloen;2;stuk","appel;3;kg","banaan;4;kg","kokosnoot;5;stuk".
$fruit = "meloen;2;stuk","appel;3;kg","banaan;4;kg","kokosnoot;5;stuk"

# 1.1. Convert "$fruit" to a list of objects. These objects have the following property names
# "naam","prijs","eenheid". Put this list of objects in the same variable "$fruit".
$fruit = $fruit | ConvertFrom-Csv -Delimiter ";" -Header "naam","prijs","eenheid"

# 1.2. Show next on screen: "$fruit" "$fruit.naam" "$fruit[0]""  "$fruit[3].prijs".
$fruit
$fruit.naam
$fruit[0]
$fruit[3].prijs

# 1.3. Write "$fruit" to JSON file "fruit.json".
$fruit | ConvertTo-Json | Out-File fruit.json
# Test the file.
Get-Content .\fruit.json

# 2.1. #1.3. Write "$fruit" to JSON file "fruit.json".
# HKCU:\Software\gdepaepe
# HKLM:\Software\gdepaepe
New-Item -Path C:\Users\elias\Desktop -Name keys.csv -ItemType File
Add-Content -Path C:\Users\elias\Desktop\keys.csv -Value "Path"
Add-Content -Path C:\Users\elias\Desktop\keys.csv -Value "HKCU:\Software\gdepaepe"
Add-Content -Path C:\Users\elias\Desktop\keys.csv -Value "HKLM:\Software\gdepaepe"

# 2.2. Create the keys in this CSV file in the registry using "binding by property name". Give the following as value "oef42".
# To do this, first add a proper header line to "keys.csv".
Import-Csv -Path C:\Users\elias\Desktop\keys.csv | New-Item -Value "oef42"

# 2.3. View the contents of the registry.
Get-ItemProperty -Path HKCU:\Software\gdepaepe
Get-ItemProperty -Path HKLM:\Software\gdepaepe

# 2.4. Now delete these keys using the same method (be careful: don't delete anything incorrectly!)
Import-Csv -Path C:\Users\elias\Desktop\keys.csv | Remove-Item


# 3.1. The following exercises use "cereal.csv" which contains the data of various grains.
# Find the answer to the following questions by combining a number of Cmdlets via piping.
$cereal = Import-Csv -Path C:\Users\elias\Desktop\cereal.csv -Delimiter ";"

#3.2. Show all grains of type H.
$cereal | Where-Object {$_.type -eq "H"}

# 3.3. How many grains are there with calories equal to 50.
$cereal | Where-Object {$_.calories -eq 50} | Measure-Object

# 3.4. What is the type of the weight property after importing the CSV file.
$cereal.weight | Get-Member

# 3.5. Put the total weight of the grains with calories equal to 50 into a variable "$TotWeight".
$sum = 0
$cereal | Where-Object {$_.calories -eq 50} | ForEach-Object { $sum += [double] $_.weight } ; $sum