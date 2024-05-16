############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Violations.ps1

<#
.SYNOPSIS
    This script processes traffic violations data from a CSV file.
.DESCRIPTION
    The script imports traffic violations data, processes it, and provides various functions to analyze the data.
.EXAMPLE
    Violations.ps1
#>

# Import the csv file 
$csvfile = '..\data\Violations.csv'

# Check if the csv file exists/Import the csv file
if (Test-Path $csvfile) {
    $violationsTemp = Import-Csv $csvfile -Delimiter ","
    $violations = @()  # Initialize the array

    foreach ($item in $violationsTemp) {
        $violations += [pscustomobject]@{
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

function More-Violations($violations, $aantal) {
    $violations | Where-Object { $_.aantal_overtredingen_roodlicht -ge $aantal } | ForEach-Object {
        [pscustomobject]@{
            datum_vaststelling = $_.datum_vaststelling;
            opnameplaats_straat = $_.opnameplaats_straat;
            aantal_passanten = $_.aantal_passanten;
            aantal_overtredingen_roodlicht = $_.aantal_overtredingen_roodlicht;
        }
    }
}

function Get-Streets($violations) {
    $violations | Select-Object -Property opnameplaats_straat -Unique | Sort-Object -Property opnameplaats_straat
}

function Sum-Violations($violations, $street) {
    $result = $violations | Where-Object { 
        $_.opnameplaats_straat -eq $street 
    } | Measure-Object -Property aantal_overtredingen_roodlicht -Sum

    return [int]$result.Sum
}

function All-Violations($violations) {
    $streets = Get-Streets $violations
    $result = @()

    foreach ($streetObj in $streets) {
        $street = $streetObj.opnameplaats_straat
        $sum = Sum-Violations $violations $street
        $result += [pscustomobject]@{
            opnameplaats_straat = $street
            aantal_overtredingen = $sum
        }
    }

    $result | Sort-Object -Property aantal_overtredingen -Descending
}

# Example usage of the functions
$allViolations = All-Violations $Violations
$allViolations | Format-Table -AutoSize

$significantViolations = More-Violations $Violations 5
$significantViolations | Format-Table -AutoSize
