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
    [string]$csvfile1="../Data/ViolationsElias.csv",
    [string]$csvfile2="../Data/StudyResult.csv"
)

[string]$global:PrimaryColor = "#4f94f0"

try {
    $Violations = Import-Csv -Path $csvfile1 -Delimiter ","
    $StudyResult = Import-Csv -Path $csvfile2 -Delimiter ";"
} catch {
    ExitScript "Error: No CSV file" 1 $False
}

# Function to write a colored line
function WriteColoredLine {
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
function ReadColoredLine {
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
function ExitScript([string]$Message="No Message", [int]$Code=0, [bool]$NoColor=$False) {
    # 1 = Error
    # 0 = Success
    Clear-Host
    if ($NoColor) {
        Write-Host $Message
    } else {
        if ($Code -eq 0) {
            WriteColoredLine -text $Message -colorHex "#00ff00"
        } elseif ($Code -eq 1) {
            WriteColoredLine -text $Message -colorHex "#ff0000"
        }
    }
    exit $Code
}

# Function to display a banner message
function BannerMessage([string]$Message="Message...", [string]$Color="#ffffff") {
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
    
    WriteColoredLine -text $Line1 -colorHex $Color
    WriteColoredLine -text $Line2 -colorHex $Color
    WriteColoredLine -text $Text -colorHex $Color
    WriteColoredLine -text $Line2 -colorHex $Color
    WriteColoredLine -text $Line1 -colorHex $Color
}

# Function to create a popup window object
function PopupWindowObject {
    param (
        [object]$Table,
        [string]$Title,
        [array]$ColumnNames
    )

    WriteColoredLine -text "*`n* Opening popup window:" -colorHex $PrimaryColor

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $Local:Form = New-Object System.Windows.Forms.Form
    $Local:Form.Text = $Title
    $Local:Form.Size = New-Object System.Drawing.Size(500, 550)
    $Local:Form.StartPosition = "CenterScreen"
    $Local:Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    $Local:Form.MaximizeBox = $False
    $Local:Form.MinimizeBox = $False
    $Local:Form.ControlBox = $True
    $Local:Form.BackColor = [System.Drawing.Color]::FromArgb(245, 245, 245)

    $Local:ListView = New-Object System.Windows.Forms.ListView
    $Local:ListView.Location = New-Object System.Drawing.Point(10, 50)
    $Local:ListView.Size = New-Object System.Drawing.Size(460, 400)
    $Local:ListView.View = [System.Windows.Forms.View]::Details
    $Local:ListView.FullRowSelect = $True
    $Local:ListView.GridLines = $False
    $Local:ListView.BackColor = [System.Drawing.Color]::White
    $Local:ListView.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
    $Local:ListView.Font = New-Object System.Drawing.Font("Arial", 10)
    $Local:ListView.HeaderStyle = [System.Windows.Forms.ColumnHeaderStyle]::Clickable

    for ($i = 0; $i -lt $ColumnNames.Length; $i++) {
        $Local:ColumnHeader = New-Object System.Windows.Forms.ColumnHeader
        $Local:ColumnHeader.Text = $ColumnNames[$i]
        $Local:ColumnHeader.Width = -2
        $Local:ListView.Columns.Add($Local:ColumnHeader) | Out-Null
    }

    function Update-ListView {
        param (
            [string]$FilterText
        )

        $ListView.BeginUpdate()
        $ListView.Items.Clear()
        $FilteredTable = $Table | Where-Object {
            $matches = $false
            foreach ($column in $ColumnNames) {
                if ($_.($column) -like "*$FilterText*") {
                    $matches = $true
                    break
                }
            }
            $matches
        }

        $rowIndex = 0
        foreach ($row in $FilteredTable) {
            $ListViewItem = New-Object System.Windows.Forms.ListViewItem
            $ListViewItem.Text = $row.$($ColumnNames[0])
            for ($j = 1; $j -lt $ColumnNames.Length; $j++) {
                $ListViewItem.SubItems.Add($row.$($ColumnNames[$j])) | Out-Null
            }

            # Alternate row color
            if ($rowIndex % 2 -eq 0) {
                $ListViewItem.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)
            } else {
                $ListViewItem.BackColor = [System.Drawing.Color]::White
            }

            $ListView.Items.Add($ListViewItem) | Out-Null
            $rowIndex++
        }
        $ListView.EndUpdate()
    }

    Update-ListView ""

    $Local:Footer = New-Object System.Windows.Forms.LinkLabel
    $Local:Footer.Location = New-Object System.Drawing.Point(10, 460)
    $Local:Footer.Size = New-Object System.Drawing.Size(460, 40)
    [string]$Local:CurrentDate = Get-Date -Format "yyyy"
    $Local:Footer.Text = "Designed by the EliasDH Team `n" + $CurrentDate + " EliasDH. All rights reserved."
    $Local:Footer.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $Local:Footer.LinkColor = [System.Drawing.ColorTranslator]::FromHtml($PrimaryColor)
    $Local:Footer.Links.Add(35, 7, "https://eliasdh.com") | Out-Null
    $Local:Footer.Font = New-Object System.Drawing.Font("Arial", 8)

    $Local:Footer.add_LinkClicked({
        param (
            $sender, 
            $element
        )
        [System.Diagnostics.Process]::Start($element.Link.LinkData.ToString()) | Out-Null
    })

    $Local:SearchBox = New-Object System.Windows.Forms.TextBox
    $Local:SearchBox.Location = New-Object System.Drawing.Point(10, 10)
    $Local:SearchBox.Size = New-Object System.Drawing.Size(360, 30)
    $Local:SearchBox.BackColor = [System.Drawing.Color]::White
    $Local:SearchBox.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
    $Local:SearchBox.Font = New-Object System.Drawing.Font("Arial", 10)
    $Local:SearchBox.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    $Local:SearchBox.add_TextChanged({
        Update-ListView $SearchBox.Text
    })

    $Local:ExportButton = New-Object System.Windows.Forms.Button
    $Local:ExportButton.Location = New-Object System.Drawing.Point(380, 10)
    $Local:ExportButton.Size = New-Object System.Drawing.Size(90, 30)
    $Local:ExportButton.Text = "Export All"
    $Local:ExportButton.BackColor = [System.Drawing.ColorTranslator]::FromHtml($PrimaryColor)
    $Local:ExportButton.ForeColor = [System.Drawing.Color]::White
    $Local:ExportButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $Local:ExportButton.Font = New-Object System.Drawing.Font("Arial", 10)
    $Local:ExportButton.add_Click({
        $CsvContent = $Table | Export-Csv -NoTypeInformation -Force -Path "$env:USERPROFILE\Desktop\export.csv"
        [System.Windows.Forms.MessageBox]::Show("Data exported to Desktop\export.csv", "Export Complete", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    })

    $Local:Form.Controls.Add($ListView)
    $Local:Form.Controls.Add($Footer)
    $Local:Form.Controls.Add($SearchBox)
    $Local:Form.Controls.Add($ExportButton)
    $Local:Form.ShowDialog()
}

# Function to get a list of unique street names
function Get-ListOfUniqueStreetNames([object]$Table) {
    [array]$Local:UniqueStreetNames = $Table | Select-Object -Property office_location -Unique | Sort-Object -Property office_location

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
        BannerMessage "Get specific data from date" $PrimaryColor
        [string]$Local:SelectedDay = ReadColoredLine -text "* Select a day (dd)" -colorHex $PrimaryColor
        [string]$Local:SelectedMonth = ReadColoredLine -text "* Select a month (mm)" -colorHex $PrimaryColor
        [string]$Local:SelectedYear = ReadColoredLine -text "* Select a year (yyyy)" -colorHex $PrimaryColor
        WriteColoredLine -text "*" -colorHex $PrimaryColor
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
        PopupWindowObject $SelectedRows $Title $ColumnNames
    } else {
        WriteColoredLine -text "* No records were found." -colorHex "#ff0000"
        Start-Sleep -Seconds 5
    }
}

# Function to get all unique degrees
function Get-UniqueDegrees([object]$Table, [array]$EducationLevels) {
    [array]$Local:UniqueDegreeNames = $Table | Select-Object -Property education_mother -Unique

    
    [array]$Local:UniqueDegreeNames = $UniqueDegreeNames | Sort-Object -Property {
        $EducationLevels.IndexOf($_.education_mother)
    }

    [array]$Local:UniqueDegrees = @()
    [int]$Local:i = 1

    foreach ($Item in $UniqueDegreeNames) {
        $UniqueDegrees += [pscustomobject]@{
            Id = [int]$i;
            DegreeName = [string]$Item.education_mother
        }
        $i++
    }

    return $UniqueDegrees
}

# Function to get the correlation between failing the exam and partying
function Get-TopGendereDegrees([object]$Table, [object]$UniqueDegrees, [array]$EducationLevels) {
    [array]$Local:GendereScoreF = @(0, 0, 0, 0, 0)
    [array]$Local:GendereScoreM = @(0, 0, 0, 0, 0)

    foreach ($Row in $Table) {
        switch ($Row.education_mother) {
            $EducationLevels[0] { # Master
                if ($Row.gender -eq "F") {
                    $GendereScoreF[0] += 1
                } elseif ($Row.gender -eq "M") {
                    $GendereScoreM[0] += 1
                }
            }
            $EducationLevels[1] { # Bachelor
                if ($Row.gender -eq "F") {
                    $GendereScoreF[1] += 1
                } elseif ($Row.gender -eq "M") {
                    $GendereScoreM[1] += 1
                }
            }
            $EducationLevels[2] { # Primary education
                if ($Row.gender -eq "F") {
                    $GendereScoreF[2] += 1
                } elseif ($Row.gender -eq "M") {
                    $GendereScoreM[2] += 1
                }
            }
            $EducationLevels[3] { # Secondary education
                if ($Row.gender -eq "F") {
                    $GendereScoreF[3] += 1
                } elseif ($Row.gender -eq "M") {
                    $GendereScoreM[3] += 1
                }
            }
            $EducationLevels[4] { # No
                if ($Row.gender -eq "F") {
                    $GendereScoreF[4] += 1
                } elseif ($Row.gender -eq "M") {
                    $GendereScoreM[4] += 1
                }
            }
            Default {}
        }
    }

    [array]$Local:TopScore = @()

    for ($i = 0; $i -le $GendereScoreF.Length; $i++) {
        if ($GendereScoreF[$i] -lt $GendereScoreM[$i]) {
            $TopScore += "M"
        } elseif ($GendereScoreF[$i] -gt $GendereScoreM[$i]) {
            $TopScore += "F"
        } else {
            $TopScore += "M&F"
        }
    }

    [array]$Local:TopGendereDegrees = @()
    [int]$Local:i = 0

    foreach ($Item in $UniqueDegrees) {
        $TopGendereDegrees += [pscustomobject]@{
            Id = [int]$Item.Id;
            DegreeName = [string]$Item.DegreeName;
            TopGendere = [string]$TopScore[$i]
        }
        $i++
    }

    return $TopGendereDegrees
}

# Function to get the correlation between failing the exam and partying
function Get-CorrelationBetweenFailingExamAndPartying([object]$Table) {
    [array]$Local:Correlation = @(0, 0, 0, 0, 0)
    [array]$Local:ColumnNamesParty = @("Every day", "Several times a week", "Once a week", "Rarely", "Never")

    foreach ($Row in $Table) {
        for ($i = 0; $i -le $Correlation.Length; $i++) {
            if ($Row.partying -eq $ColumnNamesParty[$i] -and $Row.Result -eq "Fail") {
                $Correlation[$i] += 1
            }
        }
    }

    [array]$Local:CorrelationTable = @()

    for ($i = 0; $i -lt $Correlation.Length; $i++) {
        $CorrelationTable += [pscustomobject]@{
            Id = [int]$i+1;
            AmountOfFails = [int]$Correlation[$i];
            PartyFrequency = [string]$ColumnNamesParty[$i];
        }
    }
    
    [array]$Local:ColumnNames = @("Id", "AmountOfFails", "PartyFrequency")
    [string]$Local:Title = "Correlation between failing the exam and partying"
    PopupWindowObject $CorrelationTable $Title $ColumnNames
}

# Function to start the script
function Main {
    BannerMessage "Example Exam" $PrimaryColor

    WriteColoredLine -text "*`n* Which flow would you like to do:`n* 1) Violations`n* 2) Study Result`n* 3) Exit" -colorHex $PrimaryColor
    [int]$Local:Number = ReadColoredLine -text "* Enter the number" -colorHex $PrimaryColor

    switch ($Number) {
        1 { # Violations
            [array]$Local:UniqueStreetNamesTable = Get-ListOfUniqueStreetNames $violations
            [array]$Local:TotalAmountPerStreet = Get-TotalAmountOfViolationsPerStreet $violations $UniqueStreetNamesTable
        
            [array]$Local:ColumnNames = @("Id", "StreetName", "AmountOfViolations")
            [string]$Local:Title = "Total amount of violations per street"
            PopupWindowObject $TotalAmountPerStreet $Title $ColumnNames
        
            Show-DataForASpecificDate $violations
        }
        2 { # Study Result
            [array]$Local:EducationLevels = @("Master", "Bachelor", "Primary education", "Secondary education", "No")
            [array]$Local:UniqueDegrees = Get-UniqueDegrees $StudyResult $EducationLevels
            [array]$Local:TopGendereDegrees = Get-TopGendereDegrees $StudyResult $UniqueDegrees $EducationLevels

            [array]$Local:ColumnNames = @("Id", "DegreeName", "TopGendere")
            [string]$Local:Title = "Top gendere per degree"
            PopupWindowObject $TopGendereDegrees $Title $ColumnNames

            # Is there a correlation between failing the exam and partying?
            Get-CorrelationBetweenFailingExamAndPartying $StudyResult
        }
        3 { # Exit
            ExitScript "* Exiting the script" 0
        }
        Default {
            ExitScript "* Not a valid input" 1
        }
    }
    ExitScript "* Till next time" 0
}

Main # Start the script