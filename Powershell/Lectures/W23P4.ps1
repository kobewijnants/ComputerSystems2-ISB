############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################

# Hash table
$person = @{Name="Bob"; Age=22}
$person["Name"]
$person["Age"]

# Custom object
[array] $personlist = $null
$person1 = [pscustomobject]@{Name="Bob"; Age=22}

$person1 | Get-Member
$person1.Name
$person1.Age

$personlist += $person1 # Add person to list of persons

$personlist[0].Name
$personlist[0].Age

# Loop through list of persons
foreach ($person in $personlist) {
    Write-Host $person.Name
    Write-Host $person.Age
}

############################
# Exercise 1

# Import CSV file & -Delimiter
$fruit = Import-Csv .\Powershell\data\fruit.csv -Delimiter ","

# Display the first row
$fruit | Get-Member

# Copy the fruit array
[array] $CopiedFruit = $null
$fruit | ForEach-Object { $CopiedFruit += [pscustomobject]@{Fruit=$_.Fruit; Aantal=[int]$_.Aantal} }

# Display the CopiedFruit row
$CopiedFruit | Get-Member

# Sort the fruit by 'aantal'
$CopiedFruit | Sort-Object -Property Aantal

############################