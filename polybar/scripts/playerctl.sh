#!/bin/bash

base_color="%{F#f5e0dc}"

pctl() {
  playerctl -p spotify $1
}

pctlcmd() {
  echo "playerctl -p spotify $1"
}

previous_icon=
play_pause_icon=
next_icon=
loop_icon="%{F#f38ba8}$base_color"
shuffle_icon="%{F#f38ba8}"

player_status=$(pctl "status" 2> /dev/null)
exit_code=$?
if [ $exit_code -eq 1 ]; then
  echo "$previous_icon  $play_pause_icon  $next_icon  $loop_icon  $shuffle_icon"
  exit 0
fi

if [ "$player_status" == "Playing" ]; then
  play_pause_icon=
fi

loop_command=`pctlcmd "loop playlist"`

current_loop=$(pctl "loop")

if [ "$current_loop" == "Playlist" ]; then
  loop_icon=
  loop_command=`pctlcmd "loop track"`
elif [ "$current_loop" == "Track" ]; then
  loop_icon="%{F#a6e3a1}$base_color"
  loop_command=`pctlcmd "loop none"`
fi

shuffle_command=`pctlcmd "shuffle on"`

shuffle_status=$(pctl "shuffle")

if [ "$shuffle_status" == "On" ]; then
  shuffle_icon=
  shuffle_command=`pctlcmd "shuffle off"`
fi

echo "%{A1:`pctlcmd "previous"`:}$previous_icon%{A}  %{A1:`pctlcmd "play-pause"`:}$play_pause_icon%{A}  %{A1:`pctlcmd "next"`:}$next_icon%{A}  %{A1:$loop_command:}$loop_icon%{A}  %{A1:$shuffle_command:}$shuffle_icon%{A}"
