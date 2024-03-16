############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Get-FileContent.ps1

# Import the text file
$txtfile = 'C:\Users\elias\OneDrive\Data Core\Documents\School Documents\(5) KdG\Toegepaste Informatica\Toegepaste Informatica Jaar 2\(2) Computersystemen - ISB\ComputerSystems2-ISB\Powershell\data\filelist.txt'

# Read the file and display the content
foreach ($file in Get-Content $txtfile) {
    Get-Content $file
}
# OR
# for ($i = 0; $i -lt (Get-Content $txtfile).Length; $i++) { Get-Content (Get-Content $txtfile)[$i] }