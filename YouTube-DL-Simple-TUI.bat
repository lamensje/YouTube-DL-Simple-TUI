@echo off
set path=-o "..\YouTube\%%(playlist)s\%%(title)s.%%(ext)s"
set metadata=--add-metadata
set arguments=--retries 5 --continue --socket-timeout 10 --embed-subs --write-sub --all-subs --ignore-errors --no-continue --no-overwrites --no-post-overwrites %thumbnail% %metadata% 

:Restart
cls
goto Start

:Start
cls
title YouTube-DL Preset Downloader
echo Default save path is on the same drive, in the folder "YouTube" 
echo next to the folder where this executable is located in.
echo ----------------------------------------------------------------
echo Select the desirable option from the list
echo with the corresponding number.
echo ----------------------------------------------------------------

echo [0] exit
echo [1] 360p
echo [2] 480p
echo [3] 720p
echo [4] 1080p
echo [5] 1440p
echo [6] 2160p
echo [7] Maximum
echo [8] Direct Opus Audio Download
echo [9] Download highest quality .mp3 Audio
echo [10] Download 128kbps .mp3 Audio
echo [11] Manual save path
echo [12] Default save path
echo [13] Clear Archive
echo [14] Toggle Thumbnail
echo.
set /p input= Choice: 

if %input%==0 exit
if %input%==1 goto 360p
if %input%==2 goto 480p
if %input%==3 goto 720p
if %input%==4 goto 1080p
if %input%==5 goto 1440p
if %input%==6 goto 2160p
if %input%==7 goto Maximum
if %input%==8 goto Music
if %input%==9 goto MP3
if %input%==10 goto MP3128
if %input%==11 goto ManualSavePath
if %input%==12 goto DefaultSavePath
if %input%==13 goto ClearArchivePrompt
if %input%==14 goto Thumbnail

echo Invalid selection!
echo.
echo Press any key to go back.
pause >nul
goto Restart

:Execute
cls
set /p url= Enter YouTube video/playlist/channel URL: 
%command% %url%

set "input="
set "url="
set "command="

echo.
echo Done!
echo Press any key to go back.
pause >nul
goto Restart

:ManualSavePath
cls
echo Each video will be stored in a seperate folder named after the playlist.
set /p manualpath= Manual path:   
set path=-o "%manualpath%\%%(playlist)s\%%(title)s.%%(ext)s"
echo Manual save path set!
echo.
echo Press any key to go back.
pause >nul
goto Start

:DefaultSavePath
echo.
set path=-o "..\YouTube\%%(playlist)s\%%(title)s.%%(ext)s"
echo Default save path set!
echo.
echo Press any key to go back.
pause >nul
goto Start

:ClearArchivePrompt
cls
echo This will result in longer checking if a video has already been downloaded!
set /p input= Are you sure? [Y/N]: 
if %input%==Y goto ClearArchive
if %input%==N goto Start
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
set thumbnail=--write-thumbnail --xattrs --embed-thumbnail
echo Thumbnails enabled!
echo.
echo Press any key to go back.
pause >nul
goto Start

:DisableThumbnail
echo.
set "thumbnail="
echo Thumbnails disabled!
echo.
echo Press any key to go back.
pause >nul
goto Start

:Metadata
cls
echo [1] Enable Metadata
echo [2] Disable Metadata
echo.
set /p input= Choice: 

if %input%==1 goto EnableMetadata
if %input%==2 goto DisableMetadata

echo Invalid selection!
echo.
echo Try again.
pause >nul
goto Thumbnail

:EnableMetadatal
echo.
set metadata=--add-metadata
echo Metadata enabled!
echo.
echo Press any key to go back.
pause >nul
goto Start

:DisableMetadata
echo.
set "metadata="
echo Metadata disabled!
echo.
echo Press any key to go back.
pause >nul
goto Start

:Command
cls
echo You have selected a maximum quality of %quality%p.
set command=yt-dlp --download-archive archive.log -i  %quality% %path%
goto Execute

:MP3128
cls
set quality=--extract-audio -f 140, --audio-format mp3 %thumbnail%
goto command

:MP3
cls
set quality=--extract-audio -f bestaudio, --audio-format mp3 %thumbnail%
goto command

:Music
cls
set quality=--extract-audio -f bestaudio
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

:Maximum
cls
set quality=-f "bestvideo+bestaudio" %arguments%
goto Command
