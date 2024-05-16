############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################

# Get all processes.
Get-Process

# Open notepad.
notepad

# Get all processes of notepad.
Get-Process notepad

# Get all processes of notepad and format the output in a list.
Get-Process notepad | Format-List

# Get all processes of notepad and format the output in a table.
Get-Process notepad | Format-Table

# Get all processes of notepad and format the output in a table with the "Name" and "Path" properties.
Get-Process notepad | Format-Table Name,Path

# Get all processes of notepad and format the output in a table with all properties.
Get-Process notepad | Format-Table *

# Stop all processes of notepad.
Get-Process notepad | Stop-Process

# Get the first process with the name notepad.
Get-Process notepad | Select-Object -First 1 # of -Last 1

# Sort the processes by the name notepad.
Sort-Object -Property notepad

# Group the processes by the name notepad.
Group-Object -Property notepad

# Count the number of notepad processes.
Measure-Object -Property notepad

# Get the first 5 services.
Get-Service | Select-Object -First 5

# Get date and format the output Date, Month, Year.
Get-date | Select-Object -Property Day,Month,Year

# Get all processes and format the output in a table with the "Name" and "LastWriteTime" and put in a file.
Get-ChildItem | Select-Object LastWriteTime | Sort-Object Name, LastWriteTime > C:\Users\elias\Desktop\output.txt

# Get all services and group them by their status.
Get-Service | Group-Object -Property Status

# Get the number of processes + Format the output.
Get-Process | Measure-Object | Select-Object -Property Count

# Get all services and group them by their status.
Get-Service | Group-Object -Property Status

############################

# Question: What is the difference between the following commands?
Get-date | Select-Object -Property day, month, year
Get-date | Format-Table -Property day, month, year
# Answer: The first command creates a new object, while the second command formats the output.

############################

# Get the date and store it in a variable.
$datum = Get-Date

# Format the output (DayOfWeek)
$datum.DayOfWeek

# Format the output (Month)
$datum.Month

# Add a day to the date.
$datum.AddDays(1)

# () is nessesary to execute the comandlet first to get the object and then the method can be called on the object.
(Get-Date).DayOfWeek

# Get all processes and store them in a variable.
$processes = Get-Process

# Show process 9.
$processes[9]

# Show the name of process 9.
$processes[9].ProcessName

# Show all process names.
$processes.ProcessName

# Show all members of the process object.
"" | Get-Member

# Get string 2 to 5.
"Hallo Wereld".Substring(2,5)

# Define an array.
$rij = 1,2,3,4,5

# Show the first element of the array.
Get-Member -InputObject $rij

# Show the length of the array.
$rij.Length
############################
# -eq, -ne, -lt, -le, -gt, -ge, -like, -not, !, -and, -or

# Get all processes that start with the letter w.
Get-Process | Where-Object {$_.Name -like "w*"}
# Get-Process w*

# Get all processes that have an id lower than 1000.
Get-Process | Where-Object {$_.Id -lt 1000}

# Get all processes that have a status = running.
Get-Service | ? {$_.Status -eq "Running"}

# Get all Running services and stop them.
Get-Service | ? {$_.Status -eq "Running"} | Stop-Service

# Get processes notepad and go through each process and print the id.
Get-Process notepad | Foreach-Object {$_.Id}
# (Get-Process notepad).id

# Get processes notepad and go through each process and kill it.
Get-Process notepad | % {$_.kill()}

# Get all processes and calculate the sum of their ids.
Get-Process | % {$a += $_.id } ; $a

############################

# 1. Show a list of all properties of all subdirectories in your home directory whose names start with a D.
Get-ChildItem D* -Directory | Format-List *

# 2. Display a table with only Fullname and Attributes of all files and directories in your home directory, sorted in reverse by name.
Get-ChildItem | Sort-Object Fullname, Attributes -Descending | Format-Table Fullname, Attributes

# 3. View the methods and properties of Get-Process. Show the title of your Powershell window. Do this again, but now in uppercase.
(Get-Process notepad).MainWindowTitle

# 4. Show the services that the DHCP service depends on.
(Get-Service dhcp).ServicesDependedOn

# 5. Add the VirtualMemorySize of all processes that start with c.
Get-Service c* | ForEach-Object {$size += $_.VirtualMemorySize}
$size

# 6. Create a file "filelist.txt" in your home directory containing the full path names of "c:\windows\win.ini" and "c:\windows\system.ini".
New-Item -Path C:\Users\elias\ -Name filelist.txt -ItemType File
Add-Content -Path C:\Users\elias\filelist.txt -Value "C:\Windows\win.ini"
Add-Content -Path C:\Users\elias\filelist.txt -Value "C:\Windows\system.ini"

# Display the on-screen contents of all files in "filelist.txt". This should also work if you add a file to "filelist.txt".
Get-Content -Path C:\Users\elias\filelist.txt | ForEach-Object {Get-Content $_}

# Drop the "filelist.txt" file.
Remove-Item -Path C:\Users\elias\filelist.txt

############################