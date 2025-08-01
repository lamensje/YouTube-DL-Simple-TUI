#!/bin/bash

Parameters='-4 -i --retries 10 --continue --socket-timeout 10 --embed-subs --write-sub --all-subs --ignore-errors --no-continue --no-overwrites --no-post-overwrites --add-metadata --xattrs --embed-thumbnail'
Archive='--download-archive archive.log -o'
Speed='-r 2M'

while IFS=";" read -r name select url

do
  case $select in
    maximum)
      ./yt-dlp -f "bestvideo+bestaudio" $Speed $Parameters $Archive "../YouTube/$name/%(title).220Bs.%(ext)s" $url
      ;;
    2160p)
      ./yt-dlp -f "bestvideo[height<=?2160]+bestaudio" $Speed $Parameters $Archive "../YouTube/$name/%(title).220Bs.%(ext)s" $url
      ;;
    1440p)
      ./yt-dlp -f "bestvideo[height<=?1440]+bestaudio" $Speed $Parameters $Archive "../YouTube/$name/%(title).220Bs.%(ext)s" $url
      ;;
    1080p)
      ./yt-dlp -f "bestvideo[height<=?1080]+bestaudio" $Speed $Parameters $Archive "../YouTube/$name/%(title).220Bs.%(ext)s" $url
      ;;
    720p)
      ./yt-dlp -f "bestvideo[height<=?720]+bestaudio" $Speed $Parameters $Archive "../YouTube/$name/%(title).220Bs.%(ext)s" $url
      ;;
    480p)
      ./yt-dlp -f "bestvideo[height<=?480]+bestaudio" $Speed $Parameters $Archive "../YouTube/$name/%(title).220Bs.%(ext)s" $url
      ;;
    360p)
      ./yt-dlp -f "bestvideo[height<=?360]+bestaudio" $Speed $Parameters $Archive "../YouTube/$name/%(title).220Bs.%(ext)s" $url
      ;;
    240p)
      ./yt-dlp -f "bestvideo[height<=?240]+bestaudio" $Speed $Parameters $Archive "../YouTube/$name/%(title).220Bs.%(ext)s" $url
      ;;
    mp3)
      ./yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 5 $Speed --add-metadata --xattrs --embed-thumbnail -i --retries 10 --continue --socket-timeout 10 --ignore-errors --no-continue --no-overwrites --no-post-overwrites $Archive "../YouTube/$name/%(title).220Bs.%(ext)s" $url
      ;;
    opus)
      ./yt-dlp  -f bestaudio --extract-audio $Speed --add-metadata --xattrs --embed-thumbnail -i --retries 10 --continue --socket-timeout 10 --ignore-errors --no-continue --no-overwrites --no-post-overwrites $Archive "../YouTube/$name/%(title).220Bs.%(ext)s" $url
      ;;
     *)
      echo "Invalid format for $name, choose between maximum, 2160-240p, mp3 or opus"
      ;;
  esac
done < <(cat links.txt)
