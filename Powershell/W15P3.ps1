############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 01/02/2024        #
############################

#
Get-Process

#
notepad

#
Get-Process notepad

#
Get-Process notepad | Format-List

#
Get-Process notepad | Format-Table

#
Get-Process notepad | Format-Table Name,Path

#
Get-Process notepad | Format-Table *

#
Get-Process notepad | Stop-Process

# Get the first process with the name notepad.
Get-Process notepad | Select-Object -First 1 # of -Last 1

# Sort the processes by the name notepad.
Sort-Object -Property notepad

# Group the processes by the name notepad.
Group-Object -Property notepad

# Count the number of notepad processes.
Measure-Object -Property notepad

#
Get-Service | Select-Object -First 5

#
Get-date | Select-Object -Property Day,Month,Year

#
Get-ChildItem | Select-Object LastWriteTime | Sort-Object Name, LastWriteTime > C:\Users\elias\Desktop\output.txt

#
Get-Service | Group-Object -Property Status

# Get the number of processes + Format the output.
Get-Process | Measure-Object | Select-Object -Property Count

# Get all services and group them by their status.
Get-Service | Group-Object -Property Status

############################
# Wat is the difference between the following commands?
Get-date | Select-Object -Property day, month, year
Get-date | Format-Table -Property day, month, year
# Answer: The first command creates a new object, while the second command formats the output.
############################

# Get the date and store it in a variable.
$datum = Get-Date

#
$datum.DayOfWeek

#
$datum.Month

# Add a day to the date.
$datum.AddDays(1)

# () is nessesary to execute the comandlet first to get the object and then the method can be called on the object.
(Get-Date).DayOfWeek

#
$processes = Get-Process

#
$processes[9]

#
$processes[9].ProcessName

#
$processes.ProcessName

# 
"" | Get-Member

#
"Hallo Wereld".Substring(2,5)

#
$rij = 1,2,3,4,5

#
Get-Member -InputObject $rij

#
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
# 1. Toon een lijst met alle properties van alle subdirectories in je homedirectory waarvan de naam met een D begint.
Get-ChildItem D* -Directory | Format-List *

# 2. Toon een tabel met enkel Fullname en Attributes van alle files en directories in je homedirectory, omgekeerd gesorteerd op naam.
Get-ChildItem | Sort-Object Fullname, Attributes -Descending | Format-Table Fullname, Attributes

# 3. Bekijk de methods en properties van Get-Process. Toon de titel van je Powershell venster. Doe dit nogmaals, maar nu in uppercase.
(Get-Process notepad).MainWindowTitle

# 4. Toon de services waar de DHCP service afhankelijk van is.
(Get-Service dhcp).ServicesDependedOn

# 5. Tel de VirtualMemorySize op van alle processen die met een c beginnen.
Get-Service c* | ForEach-Object {$size += $_.VirtualMemorySize}
$size

# 6. Maak een bestand "filelist.txt" in je homedirectory met daarin de volledige padnamen van "c:\windows\win.ini" en "c:\windows\system.ini".
New-Item -Path C:\Users\elias\ -Name filelist.txt -ItemType File
Add-Content -Path C:\Users\elias\filelist.txt -Value "C:\Windows\win.ini"
Add-Content -Path C:\Users\elias\filelist.txt -Value "C:\Windows\system.ini"

# Toon de inhoud op het scherm van alle files in "filelist.txt". Dit moet ook nog werken als je een file toevoegt aan "filelist.txt".
Get-Content -Path C:\Users\elias\filelist.txt | ForEach-Object {Get-Content $_}

# Drop the "filelist.txt" file.
Remove-Item -Path C:\Users\elias\filelist.txt