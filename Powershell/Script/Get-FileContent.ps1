############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Get-FileContent.ps1

$filename = "C:\Users\elias\OneDrive\Data Core\Documents\School Documents\(5) KdG\Toegepaste Informatica\Toegepaste Informatica 2 Jaar\(2) Computersystemen - ISB\ComputerSystems2-ISB\Powershell\data\filelist.txt"

foreach ($file in Get-Content $filename) {
    Get-Content $filename
}

#if (Test-Path $filename) {
#    Get-Content $filename | ForEach-Object {
#        Get-Content $_
#    }
#}