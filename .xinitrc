#!/bin/bash

# Load resources
xrdb -merge .Xresources

# Set the background color
xsetroot -solid midnightblue

feh --bg-scale ~/.wallpaper/160633.jpg

# Fire up apps

xbindkeys &

xsetroot -cursor_name left_ptr

xrandr --dpi 120

xinput set-prop "ELAN0673:00 04F3:3188 Touchpad" "Synaptics Palm Detection" 1

xinput set-prop "ELAN0673:00 04F3:3188 Touchpad" "Synaptics Palm Dimensions" 5, 5



export _JAVA_AWT_WM_NONREPARENTING=1

#xset m 0:0

#xinput set-float-prop 8 148 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 3.37

#redshift &

setxkbmap -layout us,ru -variant ,typewriter-legacy -option grp:caps_toggle

#setxkbmap us,ru,ua -variant ,typewriter-waterlaz,typewriter

redshift &

exec xmonad
