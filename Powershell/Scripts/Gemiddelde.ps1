############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################
# Gemiddelde.ps1

<#
.SYNOPSIS
    This script reads the scores of students for multiple courses and calculates the average score for each course.
.DESCRIPTION
    This script reads the scores of students for multiple courses and calculates the average score for each course.
    The scores are saved to a CSV file and then read from the file to calculate the average score for each course.
    The average score for each course is then displayed.
.EXAMPLE
    Gemiddelde.ps1
.NOTES
File: Gemiddelde.ps1
Author: Elias De Hondt
Version: 1.0
#>

$file_path = "..\Data\StudentsScores.csv"

function Lees-Punten {
    while ($true) {
        $number_of_courses = Read-Host "Enter the number of courses"
        $number_of_students = Read-Host "Enter the number of students"
        # Check if the input is a number and if it is greater than 0
        if ($number_of_courses -as [int] -and $number_of_students -as [int] -and $number_of_courses -gt 0 -and $number_of_students -gt 0) {
            Write-Host "Number of courses: $number_of_courses"
            Write-Host "Number of students: $number_of_students"
            break
        }
        else {
            Write-Host "Please enter a valid number greater than 0"
            Start-Sleep -Seconds 10
            Clear-Host
        }
    }

    $courses = @()
    for ($i = 0; $i -lt $number_of_courses; $i++) {
        $course = Read-Host "Enter the name of course $($i+1)"
        $courses += $course
    }

    $students_scores = @()
    for ($j = 0; $j -lt $number_of_courses; $j++) {
        $course_scores = @($courses[$j])
        for ($i = 0; $i -lt $number_of_students; $i++) {
            $score = Read-Host "Enter the score of student $($i+1) for course $($j+1)"
            $course_scores += $score
        }
        $students_scores += ,@($course_scores -join ",") # -join is used to convert the array to a string
    }

    $header = "CourseName" + "," + (1..$number_of_students -join ",") # Add the header to the file
    
    # Write the header and then the scores to the file
    Set-Content -Path $file_path -Value $header
    $students_scores | ForEach-Object { $_ } | Add-Content -Path $file_path

    Write-Host "Scores have been saved to $file_path"
}

function Schrijf-Gemiddelde {
    $importedFile = Import-CSV -Path $file_path -Delimiter ","

    $importedFile | ForEach-Object {
        $courseName = $_.CourseName
        $scores = $_.PSObject.Properties | Where-Object { $_.Name -ne "CourseName" } | ForEach-Object { $_.Value }
        $average = ($scores | Measure-Object -Average).Average
        Write-Host "The average score for $courseName is $average"
    }
}

Lees-Punten
Schrijf-Gemiddelde