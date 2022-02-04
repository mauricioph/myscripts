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
set datetimeb=%day%-%month%-%year%

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

rem Define folders
if "%programme%" == "unknown" set folder=C:\Users\PC2\Documents\Unknown
if "%programme%" == "Breakfast" set folder=C:\Users\PC2\Documents\Breakfast
if "%programme%" == "Be_Inspired" set folder=C:\Users\PC2\Documents\Be Inspired
if "%programme%" == "BeatDepression" set folder=C:\Users\PC2\Documents\Beat Depressions
if "%programme%" == "LLL" set folder=C:\Users\PC2\Documents\LLL
if "%programme%" == "Love_Talk" set folder=C:\Users\PC2\Documents\Love  Talk Show
if "%programme%" == "MiddayBoost" set folder=C:\Users\PC2\Documents\Midday Boost
if "%programme%" == "Str8up" set folder=C:\Users\PC2\Documents\str8upradio
if "%programme%" == "ROD" set folder=C:\Users\PC2\Documents\ROD

rem loop watching folder
:loop
if exist "D:\Users\sounds\Downloads\Photos\*.jpg" (
for %%a in ("D:\Users\sounds\Downloads\Photos\*.jpg") do (

echo %%a 
rem start "" /w "c:\droplet_path\droplet.exe" "%%a"

ping -n 10 localhost >nul
rem del "%%a"
echo moved %%a to %folder%\%datetimeb%\
)
)
ping -n 10 localhost >nul
goto :loop
