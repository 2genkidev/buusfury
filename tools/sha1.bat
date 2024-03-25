@echo off
setlocal enabledelayedexpansion

:: Check if a file path is provided
if "%~1"=="" (
    echo Usage: %0 ^<file^>
    exit /b 1
)

:: Generate SHA1 hash and extract it
for /f "tokens=*" %%a in ('certutil -hashfile "%~1" SHA1 ^| find /v "SHA1 hash of" ^| find /v "CertUtil"') do (
    set "hash=%%a"
    goto display
)

:display
echo !hash!

endlocal
