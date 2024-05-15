############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Overtredingen.ps1

<#
.SYNOPSIS
    This script processes traffic violations data from a CSV file.
.DESCRIPTION
    The script imports traffic violations data, processes it, and provides various functions to analyze the data.
.EXAMPLE
    Overtredingen.ps1
#>

# Import the csv file 
$csvfile = 'C:\Users\elias\OneDrive\Data Core\Documents\School Documents\(5) KdG\Toegepaste Informatica\Toegepaste Informatica Jaar 2\(2) Computersystemen - ISB\ComputerSystems2-ISB\Powershell\data\a_overtredingen.csv'

# Check if the csv file exists/Import the csv file
if (Test-Path $csvfile) {
    $overtredingenTemp = Import-Csv $csvfile -Delimiter ","
    $overtredingen = @()  # Initialize the array

    foreach ($item in $overtredingenTemp) {
        $overtredingen += [pscustomobject]@{
            id = [int]$item.id;
            datum_vaststelling_jaar = [int]$item.datum_vaststelling_jaar;
            datum_vaststelling_maand = [int]$item.datum_vaststelling_maand;
            datum_vaststelling_dag = [string]$item.datum_vaststelling_dag;
            opnameplaats_straat = [string]$item.opnameplaats_straat;
            aantal_passanten = [int]$item.aantal_passanten;
            aantal_overtredingen_roodlicht = [int]$item.aantal_overtredingen_roodlicht;
        }
    }
}
else {
    Write-Host "The file $csvfile does not exist."
    Start-Sleep -Seconds 10
    exit 1
}

function More-Overtredingen($overtredingen, $aantal) {
    $overtredingen | Where-Object { $_.aantal_overtredingen_roodlicht -ge $aantal } | ForEach-Object {
        [pscustomobject]@{
            datum_vaststelling = $_.datum_vaststelling;
            opnameplaats_straat = $_.opnameplaats_straat;
            aantal_passanten = $_.aantal_passanten;
            aantal_overtredingen_roodlicht = $_.aantal_overtredingen_roodlicht;
        }
    }
}

function Get-Streets($overtredingen) {
    $overtredingen | Select-Object -Property opnameplaats_straat -Unique | Sort-Object -Property opnameplaats_straat
}

function Sum-Overtredingen ($overtredingen, $street) {
    $result = $overtredingen | Where-Object { 
        $_.opnameplaats_straat -eq $street 
    } | Measure-Object -Property aantal_overtredingen_roodlicht -Sum

    return [int]$result.Sum
}

function All-Overtredingen($overtredingen) {
    $streets = Get-Streets $overtredingen
    $result = @()

    foreach ($streetObj in $streets) {
        $street = $streetObj.opnameplaats_straat
        $sum = Sum-Overtredingen $overtredingen $street
        $result += [pscustomobject]@{
            opnameplaats_straat = $street
            aantal_overtredingen = $sum
        }
    }

    $result | Sort-Object -Property aantal_overtredingen -Descending
}

# Example usage of the functions
$allOvertredingen = All-Overtredingen $overtredingen
$allOvertredingen | Format-Table -AutoSize

$significantOvertredingen = More-Overtredingen $overtredingen 5
$significantOvertredingen | Format-Table -AutoSize
