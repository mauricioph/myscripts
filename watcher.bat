echo off
rem script to watch Liberty's Downloads folder and move the downloaded content 
rem to respective folder of the programme which is on air or at production stage in given time.
rem ######## PRODUCTION STAGE DO NOT USE IT YET #################

rem Set the date and time for later manipulation
set day=%date:~0,2%
if "%day:~0,1%" == " " set day=0%day:~1,1%
set month=%date:~3,2%
if "%month:~0,1%" == " " set month=0%month:~1,1%
set year=%date:~-4%
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
set secs=%time:~6,2%
if "%secs:~0,1%" == " " set secs=0%secs:~1,1%
set datetimef=%day%-%month%-%year%_%hour%-%min%-%secs%

echo Started on %datetimef%

set programme=unknown
if "%hour%" == "06" set programme="Breakfast" 
if "%hour%" == "07" set programme="Breakfast"
if "%hour%" == "08" set programme="Breakfast"
if "%hour%" == "09" set programme="Breakfast"
if "%hour%" == "11" set programme="MiddayBoost"
if "%hour%" == "12" set programme="MiddayBoost"
if "%hour%" == "20" set programme="Str8up"
if "%hour%" == "21" set programme="Str8up"
if "%hour%" == "22" set programme="Be_Inspired"
if "%hour%" == "23" set programme="Love_Talk"
echo Setting up for %programme%



rem loop watching folder
:loop
if exist "D:\Users\sounds\Downloads\Photos\*.jpg" (
for %%a in ("D:\Users\sounds\Downloads\Photos\*.jpg") do (

echo %%a 
rem start "" /w "c:\droplet_path\droplet.exe" "%%a"

ping -n 10 localhost >nul
rem del "%%a"
echo moved %%a to folder 
)
)
ping -n 10 localhost >nul
goto :loop