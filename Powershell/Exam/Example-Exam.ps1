############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################

<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE

.NOTES
File: Example-Exam.ps1
Author: Elias De Hondt
Version: 1.0
#>

param ( # Parameters for the script
    [string]$csvfile="../Data/ViolationsElias.csv"
)

[string]$global:PrimaryColor = "#4f94f0"

try {
    $Violations = Import-Csv -Path $csvfile -Delimiter ","
} catch {
    Exit-Script "Error: No CSV file" 1 $False
}

# Function to write a colored line
function Write-ColoredLine {
    param (
        [string]$Text,
        [string]$ColorHex
    )
    
    $R = [Convert]::ToInt32($ColorHex.Substring(1, 2), 16)
    $G = [Convert]::ToInt32($ColorHex.Substring(3, 2), 16)
    $B = [Convert]::ToInt32($ColorHex.Substring(5, 2), 16)
    
    [string]$Local:AnsiSequence = [char]27 + "[38;2;" + $R + ";" + $G + ";" + $B + "m"
    [string]$Local:ResetSequence = [char]27 + "[0m"
    Write-Host "${AnsiSequence}${Text}${ResetSequence}"
}

# Function to read a colored line
function Read-ColoredLine {
    param (
        [string]$Text,
        [string]$ColorHex
    )
    
    $R = [Convert]::ToInt32($ColorHex.Substring(1, 2), 16)
    $G = [Convert]::ToInt32($ColorHex.Substring(3, 2), 16)
    $B = [Convert]::ToInt32($ColorHex.Substring(5, 2), 16)
    
    [string]$Local:AnsiSequence = [char]27 + "[38;2;" + $R + ";" + $G + ";" + $B + "m"
    [string]$Local:ResetSequence = [char]27 + "[0m"
    Read-Host "${AnsiSequence}${Text}${ResetSequence}"
}

# Function to exit the script
function Exit-Script([string]$Message="No Message", [int]$Code=0, [bool]$NoColor=$False) {
    # 1 = Error
    # 0 = Success
    Clear-Host
    if ($NoColor) {
        if ($Code -eq 0) {
            Write-Host $Message
        } elseif ($Code -eq 1) {
            Write-Host $Message
        }
    } else {
        if ($Code -eq 0) {
            Write-ColoredLine -text $Message -colorHex "#00ff00"
        } elseif ($Code -eq 1) {
            Write-ColoredLine -text $Message -colorHex "#ff0000"
        }
    }
    exit $Code
}

# Function to display a banner message
function Banner-Message([string]$Message="Message...", [string]$Color="#ffffff", [bool]$NoColor=$False) {
    Clear-Host
    [int]$Local:Length = $Message.Length
    [string]$Local:Line1 = "*****"
    [string]$Local:Line2 = "*   "
    [string]$Local:Text = "*  " + $Message + "  *"

    for ($i = 0; $i -le $Length; $i++) {
        $Line1 += "*"
        $Line2 += " "

        if ($i -eq $Length) {
            $Line2 += "*"
        }
    }
    
    Write-ColoredLine -text $Line1 -colorHex $PrimaryColor
    Write-ColoredLine -text $Line2 -colorHex $PrimaryColor
    Write-ColoredLine -text $Text -colorHex $PrimaryColor
    Write-ColoredLine -text $Line2 -colorHex $PrimaryColor
    Write-ColoredLine -text $Line1 -colorHex $PrimaryColor
}

# Function to create a popup window
function Popup-Window-Object {
    param (
        [object]$Table,
        [string]$Title,
        [array]$ColumnNames
    )
    
    Write-ColoredLine -text "*`n* Opening popup window:" -colorHex $PrimaryColor

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $Local:Form = New-Object System.Windows.Forms.Form
    $Local:Form.Text = $Title
    $Local:Form.Size = New-Object System.Drawing.Size(400, 450)
    $Local:Form.StartPosition = "CenterScreen"
    $Local:Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    $Local:Form.MaximizeBox = $False
    $Local:Form.MinimizeBox = $False
    $Local:Form.ControlBox = $True

    $Local:ListView = New-Object System.Windows.Forms.ListView
    $Local:ListView.Location = New-Object System.Drawing.Point(10, 10)
    $Local:ListView.Size = New-Object System.Drawing.Size(360, 340)
    $Local:ListView.View = [System.Windows.Forms.View]::Details
    $Local:ListView.FullRowSelect = $True
    $Local:ListView.GridLines = $True

    for ($i = 0; $i -lt $ColumnNames.Length; $i++) {
        $Local:ListView.Columns.Add($ColumnNames[$i], 100) | Out-Null
    }

    for ($i = 0; $i -lt $Table.Length; $i++) {
        $Local:ListViewItem = New-Object System.Windows.Forms.ListViewItem
        $Local:ListViewItem.Text = $Table[$i].($ColumnNames[0])

        for ($j = 1; $j -lt $ColumnNames.Length; $j++) {
            $Local:ListViewItem.SubItems.Add($Table[$i].($ColumnNames[$j])) | Out-Null
        }

        $Local:ListView.Items.Add($Local:ListViewItem) | Out-Null
    }

    $Local:Footer = New-Object System.Windows.Forms.LinkLabel
    $Local:Footer.Location = New-Object System.Drawing.Point(10, 360)
    $Local:Footer.Size = New-Object System.Drawing.Size(360, 40)
    [string]$Local:CurrentDate = Get-Date -Format "yyyy"
    $Local:Footer.Text = "Designed by the EliasDH Team `n" + $Local:CurrentDate + " EliasDH. All rights reserved."
    $Local:Footer.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $Local:Footer.LinkColor = [System.Drawing.ColorTranslator]::FromHtml($PrimaryColor)
    $Local:Footer.Links.Add(35, 7, "https://eliasdh.com") | Out-Null

    $Local:Footer.add_LinkClicked({
        param (
            $sender, 
            $element
        )
        [System.Diagnostics.Process]::Start($element.Link.LinkData.ToString()) | Out-Null
    })

    $Local:Form.Controls.Add($Local:ListView)
    $Local:Form.Controls.Add($Local:Footer)
    $Local:Form.ShowDialog()
}

# Function to get a list of unique street names
function Get-ListOfUniqueStreetNames([object]$Table) {
    $Local:UniqueStreetNames = $Table | Select-Object -Property office_location -Unique | Sort-Object -Property office_location

    [array]$Local:UniqueStreetNamesTable = @()
    [int]$Local:i = 0
    
    foreach ($Item in $UniqueStreetNames) { # Loop through the unique street names
        $UniqueStreetNamesTable += [pscustomobject]@{ # Create a custom object
            Id = [int]$i;
            StreetName = [string]$Item.office_location;
        }
        if ($i -eq 0) {
            [array]$UniqueStreetNamesTable = @()
        }
        $i++
    }
    return $UniqueStreetNamesTable
}

# Function to get the total amount of violations per street
function Get-TotalAmountOfViolationsPerStreet([object]$Table, [object]$UniqueStreetNamesTable) {
    [array]$Local:TotalAmountPerStreet = @()

    foreach ($Item in $UniqueStreetNamesTable) {
        $TotalAmount = 0

        foreach ($Row in $Table) {
            if ($Row.office_location -eq $item.StreetName) {
                $TotalAmount += $Row.violations
            }
        }

        $TotalAmountPerStreet += [pscustomobject]@{
            Id = [int]$item.Id;
            StreetName = [string]$item.StreetName;
            AmountOfViolations = [int]$TotalAmount;
        }
    }
    return $TotalAmountPerStreet
}

# Function to show data for a specific date
function Show-DataForASpecificDate {
    param (
        [object]$Table
    )
    
    [bool]$Local:Validated = $false
    do {
        Banner-Message "Get specific data from date"
        [string]$Local:SelectedDay = Read-ColoredLine -text "* Select a day (dd)" -colorHex $PrimaryColor
        [string]$Local:SelectedMonth = Read-ColoredLine -text "* Select a month (mm)" -colorHex $PrimaryColor
        [string]$Local:SelectedYear = Read-ColoredLine -text "* Select a year (yyyy)" -colorHex $PrimaryColor

        if ($SelectedDay -ne "" -and $SelectedMonth -ne "" -and $SelectedYear -ne "") {
            $Local:Validated = $True
        }
    } until($Validated)

    [array]$Local:SelectedRows = @()
    [int]$i = 1

    foreach ($Row in $Table) {
        # Making this extra complicated to utilize string functionality.

        [string]$Local:Day = $Row.date_determination.Substring(0,2)
        [string]$Local:Month = $Row.date_determination.Substring(3,2)
        [string]$Local:Year = $Row.date_determination.Substring(6,4)

        if ($SelectedDay -eq $Day -and $SelectedMonth -eq $Month -and $SelectedYear -eq $Year) {
            $SelectedRows += [pscustomobject]@{
                Id = [int]$i;
                DateDetermination = [string]$Row.date_determination;
                OfficeLocation = [string]$Row.office_location;
                Violations = [int]$Row.violations;
                PeopleInvolved = [int]$Row.people_involved;
            }
            $i++
        }
    }

    if ($Validated -and $SelectedRows.Length -gt 0) {
        [array]$Local:ColumnNames = @("Id", "DateDetermination", "OfficeLocation", "Violations", "PeopleInvolved")
        [string]$Local:Title = "Data for " + $SelectedDay + "/" + $SelectedMonth + "/" + $SelectedYear
        Popup-Window-Object $SelectedRows $Title $ColumnNames
    } else {
        Exit-Script "No records were found." 1
    }
}

# Function to start the script
function Main {
    Banner-Message "Example Exam"

    [array]$Local:UniqueStreetNamesTable = Get-ListOfUniqueStreetNames $violations
    [array]$Local:TotalAmountPerStreet = Get-TotalAmountOfViolationsPerStreet $violations $UniqueStreetNamesTable

    [array]$Local:ColumnNames = @("Id", "StreetName", "AmountOfViolations")
    [string]$Local:Title = "Total amount of violations per street"
    Popup-Window-Object $TotalAmountPerStreet $Title $ColumnNames

    Show-DataForASpecificDate $violations
}


Main # Start the script