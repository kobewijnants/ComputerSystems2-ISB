############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Get-FileContent.ps1

<#
.SYNOPSIS
    This script reads the content of a text file and displays the content of each file listed in the text file.
.DESCRIPTION
    This script reads the content of a text file and displays the content of each file listed in the text file.
.EXAMPLE
    Get-FileContent.ps1
#>

# Import the text file
$txtfile = '..\Data\FileList.txt'

# Read the file and display the content
foreach ($file in Get-Content $txtfile) {
    Get-Content $file
}
# OR
# for ($i = 0; $i -lt (Get-Content $txtfile).Length; $i++) { Get-Content (Get-Content $txtfile)[$i] }