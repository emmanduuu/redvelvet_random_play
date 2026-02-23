#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# check if requirements are met, else exit 
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

if ! command_exists "yt-dlp" ; then
  echo "yt-dlp not detected, please install. exiting."
  exit
elif  ! command_exists "kitty" ; then
  echo "kitty not detected, please install. exiting"
  exit
elif  ! command_exists "mpv"  ; then
  echo "mpv not detected, please install. exiting"
  exit
fi


file_path="$SCRIPT_DIR/links.txt"

mapfile -t links < "$file_path"

size=${#links[@]}
index=$(( RANDOM % size ))
random_link=${links[$index]}
working_dir=$(pwd)

kitty mpv --quiet --vo=kitty --no-osc --volume=20  --ytdl-raw-options=match-filter="uploader_id ~= '.*(redvelvet|SMTOWN|wendy_offcl).*' & title ~= '(?i)(irene|seulgi|wendy|joy|yeri|red\\ velvet)' " $random_link
#kitty $working_dir/play_video.sh $random_link

read