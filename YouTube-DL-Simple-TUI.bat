@echo off
set path=-o "..\YouTube\%%(playlist)s\%%(title)s.%%(ext)s"
set thumbnail=--write-thumbnail
set arguments=--embed-subs --write-sub --sub-lang en --ignore-errors --no-continue --no-overwrites --no-post-overwrites %thumbnail% --add-metadata

:Restart
cls
goto Start

:Start
title YouTube-DL Preset Downloader
echo Default save path is on the same drive, in the folder "YouTube" 
echo next to the folder where this executable is located in.
echo ----------------------------------------------------------------
echo Please select the highest desirable quality from the list
echo with the corresponding number.
echo ----------------------------------------------------------------

echo [0] exit
echo [1] Music only
echo [2] 360p
echo [3] 480p
echo [4] 720p
echo [5] 1080p
echo [6] 1440p
echo [7] 2160p
echo [8] Maximum
echo [9] Menu
echo.
set /p input= Choice: 

if %input%==0 exit
if %input%==1 goto Music
if %input%==2 goto 360p
if %input%==3 goto 480p
if %input%==4 goto 720p
if %input%==5 goto 1080p
if %input%==6 goto 1440p
if %input%==7 goto 2160p
if %input%==8 goto Maximum
if %input%==9 goto Menu

echo Invalid selection!
echo.
echo Press any key to go back.
pause >nul
goto Restart

:Execute
cls
set /p url= Enter YouTube playlist URL: 
%command% %url%

set "input="
set "url="
set "command="

echo.
echo Done!
echo Press any key to go back.
pause >nul
goto Restart

:Menu
cls
echo ----------------------------------------------------------
echo [0] Back
echo [1] Manual save path
echo [2] Default save path
echo [3] Clear Archive
echo [4] Toggle Thumbnail
echo.
set /p input= Choice: 

if %input%==0 goto Restart
if %input%==1 goto ManualSavePath
if %input%==2 goto DefaultSavePath
if %input%==3 goto ClearArchivePrompt
if %input%==4 goto Thumbnail

echo Invalid selection!
echo.
echo Try again.
pause >nul
goto Menu

:ManualSavePath
cls
echo Each video will be stored in a seperate folder named after the playlist.
set /p manualpath= Manual path:   
set path=-o "%manualpath%\%%(playlist)s\%%(title)s.%%(ext)s"
echo Manual save path set!
echo.
echo Press any key to go back.
pause >nul
goto Menu

:DefaultSavePath
echo.
set path=-o "..\YouTube\%%(playlist)s\%%(title)s.%%(ext)s"
echo Default save path set!
echo.
echo Press any key to go back.
pause >nul
goto Menu

:ClearArchivePrompt
cls
echo This will result in longer checking if a video has already been downloaded!
set /p input= Are you sure? [Y/N]: 
if %input%==Y goto ClearArchive
if %input%==N goto Menu
echo Invalid selection!
echo.
echo Try again.
pause >nul
goto ClearArchivePrompt

:ClearArchive
cls
break>archive.log
echo Archive cleared!
echo.
echo Press any key to go back.
pause >nul
goto Restart

:Thumbnail
cls
echo [1] Enable Thumbnails
echo [2] Disable Thumbnails
echo.
set /p input= Choice: 

if %input%==1 goto EnableThumbnail
if %input%==2 goto DisableThumbnail

echo Invalid selection!
echo.
echo Try again.
pause >nul
goto Thumbnail

:EnableThumbnail
echo.
set thumbnail=--write-thumbnail
echo Thumbnails enabled!
echo.
echo Press any key to go back.
pause >nul
goto Menu

:DisableThumbnail
echo.
set "thumbnail="
echo Thumbnails disabled!
echo.
echo Press any key to go back.
pause >nul
goto Menu

:Command
cls
echo You have selected a maximum quality of %quality%p.
set command=youtube-dl --download-archive archive.log -i  %quality% %path%
goto Execute

:Music
cls
set quality=--extract-audio -f bestaudio %thumbnail%
goto Command

:360p
cls
set quality=-f "bestvideo[height<=?360]+bestaudio" %arguments%
goto Command

:480p
cls
set quality=-f "bestvideo[height<=?480]+bestaudio" %arguments%
goto Command

:720p
cls
set quality=-f "bestvideo[height<=?720]+bestaudio" %arguments%
goto Command

:1080p
cls
set quality=-f "bestvideo[height<=?1080]+bestaudio" %arguments%
goto Command

:1440p
cls
set quality=-f "bestvideo[height<=?1440]+bestaudio" %arguments%
goto Command

:2160p
cls
set quality=-f "bestvideo[height<=?2160]+bestaudio" %arguments%
goto Command

:MP3
cls
set quality=--extract-audio -f 140, --audio-format mp3 %thumbnail%
goto command

:Maximum
cls
set quality=-f "bestvideo+bestaudio" %arguments%
goto Command
