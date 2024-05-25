![logo](https://eliasdh.com/assets/media/images/logo-github.png)
# 💙🤍Example Exam🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [🔦Requirements](#🔦requirements)
    1. [🌐General Requirements](#🌐general-requirements)
    2. [🪟For Windows Users](#🪟for-windows-users)
    3. [🍎For MacOS Users](#🍎for-macos-users)
    4. [🐧For Linux Users](#🐧for-linux-users)
4. [📝Assignment](#📝assignment)
5. [⚖️Calculate your score](#⚖️calculate-your-score)
6. [🔗Links](#🔗links)

---

## 🖖Introduction

Welcome to the Example Exam for PowerShell! In this assessment, attention to detail is key. Make sure to thoroughly review each assignment, ensuring you have all the necessary data and correct file structures. While the exercises may seem complex, don't fret—encountering challenges is part of the learning process. Embrace the opportunity to expand your skills, and remember, learning from mistakes is perfectly normal and encouraged.

Good luck, and happy scripting!

## 🔦Requirements

### 🌐General Requirements

- **Operating System:** Windows, MacOS, or Linux
- **PowerShell Version:** PowerShell 5.1 or later
- **Text Editor:** Visual Studio Code, Notepad++, or any other text editor
- **File structure**
    - We will be working in the root directory of the operating system (C:\, /, etc.)
    - In the root directory we will have cloned this repository.
        ```git
        git clone https://github.com/EliasDeHondt/ComputerSystems2-ISB.git
        cd ComputerSystems2-ISB/Powershell/Exam
        ```

### 🪟For Windows Users

- **PowerShell Version:** PowerShell 5.1 or later
- **Execution Policy:** `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- **PowerShell Installation:** Included with Windows

### 🍎For MacOS Users

- **PowerShell Version:** PowerShell 7.1 or later
- **Homebrew:** [Homebrew](https://brew.sh/)
- **PowerShell Installation:** `brew install --cask powershell`

### 🐧For Linux Users

- **PowerShell Version:** PowerShell 7.1 or later
- **PowerShell Installation:** [Powershell Installation](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7.1)

## 📝Assignment

- If you need any help with the syntax see the [scripts](/Powershell/scripts) folder in this repository.
- The name of the script should be `Example-Exam.ps1`
- The script will be divided in different functions.
- Make sure that you document your code with comments and that you use the best practices for writing PowerShell scripts.

<font color="red">**Initialization of script**</font>

1. The below 'param' are global, not defined in a function.
    - `$NoColor` If the script is run with the `-NoColor` parameter, the script will not use any colors.
    - `$RunNewWindow` If the script is run with the `-RunNewWindow` parameter, the script will run in a new window.
    - `$RunInOtherDirectory` If the script is run with the `-RunInOtherDirectory` parameter, the script will run in a different directory.
        - Attribute: `Path` The path where the script will run (***So relative paths will change***).
        - Type: `String`
        - Default: `C:\`
    - `$RunAsAdministrator` If the script is run with the `-RunAsAdministrator` parameter, the script will run as an administrator.
    - `$RunInDebugMode` If the script is run with the `-RunInDebugMode` parameter, the script will run in debug mode.

2. The script will have a `Main` function that will call all other functions.
3. The script will have a `Exit` function that will exit the script with an error/success/... message. The function will have a parameter called `Message` that will be the message. The function will exit the script with an code that will be passed as a parameter `Code`. Example: `Exit -Message "Error message" -Code 1`. If the code is 1 the message will be red, if the code is 0 the message will be green.

<font color="green">**Write-Log**</font>

1. The script will have a `Write-Log` function that will write a log message. The function will have a parameter called `Message` that will be the log message.  The function will have a parameter called `LogFileName` that will be the log file name. The function will have a parameter called `LogPath` that will be the log file path. Example: `Write-Log -Message "Log message" -LogFileName "Log" -LogPath "C:\Logs"`. The log file will have the following format: `2024-01-01 00:00:00 - Log message`. The log file will be saved in the `LogPath` directory. If there is no `LogPath` of the `LogFileName` use the default values. `Example-Exam-Log-2024-01-01.log`, `~\Logs`.

<font color="blue">**X**</font>

<font color="yellow">**X**</font>

<font color="purple">**X**</font>

<font color="orange">**X**</font>

<font color="pink">**X**</font>


- You can find the solution here [Example-Exam-Solution.ps1](/Powershell/Exam/Example-Exam.ps1)
    - **Note:** This is a solution, not a step-by-step guide. Try to solve the assignment on your own before reviewing the solution.
    - **Note:** The solution is not the only way to solve the assignment. There are multiple ways to solve each problem.


## ⚖️Calculate your score

- Every function or aspect of the script has a different color each color represents of value calculate and find out what your score is.

| Color | Value |
| ----- | ----- |
| Red   | 1     |
| Green | 3     |
| Blue  | 3     |
| Yellow| 4     |
| Purple| 2     |
| Orange| 2     |
| Pink  | 5     |

- The sum of all is 20 points.

## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us elias.dehondt@outlook.com