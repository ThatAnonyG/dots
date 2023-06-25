#!/bin/bash

base_color="%{F#f5e0dc}"

previous_icon=

play_pause_icon=

if [[ $(playerctl status) = "Paused" ]]; then
  play_pause_icon=
fi

next_icon=

loop_icon="%{F#f38ba8}$base_color"
loop_command="playerctl loop playlist"

if [[ $(playerctl loop) = "Playlist" ]]; then
  loop_icon=
  loop_command="playerctl loop track"
elif [[ $(playerctl loop) = "Track" ]]; then
  loop_icon="%{F#a6e3a1}$base_color"
  loop_command="playerctl loop none"
fi

shuffle_icon="%{F#f38ba8}"
shuffle_command="playerctl shuffle on"

if [[ $(playerctl shuffle) = "On" ]]; then
  shuffle_icon=
  shuffle_command="playerctl shuffle off"
fi

echo "%{A1:playerctl previous:}$previous_icon%{A}  %{A1:playerctl play-pause:}$play_pause_icon%{A}  %{A1:playerctl next:}$next_icon%{A}  %{A1:$loop_command:}$loop_icon%{A}  %{A1:$shuffle_command:}$shuffle_icon%{A}"
