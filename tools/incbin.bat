@echo off
setlocal enabledelayedexpansion

:: Check for correct number of arguments
if "%~3"=="" (
    echo Usage: %0 filename startHexOffset endHexOffset
    echo Example: %0 myfile.txt 0x04 0xA0
    exit /b 1
)

:: Arguments
set "fileName=%~1"
set "startHex=%~2"
set "endHex=%~3"

:: Convert hex offsets to decimal
set /a start=!startHex!
set /a end=!endHex!

:: Validate conversion
if "!start!"=="0" if "%startHex%" neq "0x0" (
    echo Invalid start offset
    exit /b 1
)
if "!end!"=="0" if "%endHex%" neq "0x0" (
    echo Invalid end offset
    exit /b 1
)


if exist "!fileName!_!startHex!_!endHex!.extracted" (
    	exit /b
) else (
	:: Calculate length to extract
	set /a length=!end!-!start!

	:: PowerShell command to extract part of the file
	set "psCommand=Get-Content -Path '!fileName!' -Encoding Byte | Select-Object -Skip !start! -First !length! | Set-Content -Path '!fileName!_!startHex!_!endHex!.extracted' -Encoding Byte"

	:: Execute the PowerShell command
	powershell -Command "!psCommand!"

	echo Done. Extracted content saved to '!fileName!_!startHex!_!endHex!.extracted'
)


