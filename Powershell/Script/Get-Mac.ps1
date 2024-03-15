############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Get-Mac.ps1

$filename = "C:\Users\elias\OneDrive\Data Core\Documents\School Documents\(5) KdG\Toegepaste Informatica\Toegepaste Informatica 2 Jaar\(2) Computersystemen - ISB\ComputerSystems2-ISB\Powershell\data\MacTable.csv"

function Delete-LinesCsv($property, $value, $filename) {
    Import-Csv $filename | ? { $_.$property -ne $value } | Export-Csv ($filename + ".new") -force
    Move-Item ($filename + ".new") $filename -Force
    }

function Write-Mac() {
    $adapters = Get-CimInstance Win32_NetworkAdapter | ? { $_.AdapterType -eq "Ethernet 802.3" -and $_.PhysicalAdapter -eq $true }
    foreach ($adapter in $adapters) {
        $date = (Get-Date).ToString() 
        Delete-LinesCsv mac $adapter.MacAddress $filename
        Write-Host ("Schrijf: " + $date + "," + $adapter.SystemName + "," + $adapter.Name + "," + $adapter.MacAddress)
        Add-Content $filename ($date + "," + $adapter.SystemName + "," + $adapter.Name + "," + $adapter.MacAddress)
        }
    }

function Get-Mac($computername) {
    Import-Csv $filename | ? {$_.computername -like $computername}
    }

function Clean-Mac([int]$maxtimespan) {
    Import-Csv $filename | ? { ((Get-Date) - (Get-Date $_.date)).days -le $maxtimespan } | Export-Csv ($filename + ".new")
    Move-Item ($filename + ".new") $filename -Force
    }

if ( $args.count -eq 0 ) { Write-Mac }
if ( $args[0] -eq "-show" -and $args.count -eq 2) { Get-Mac $args[1] }
if ( $args[0] -eq "-clean" -and $args.count -eq 2 ) { Clean-Mac $args[1] }
