 #!/usr/bin/env bash

sleep 2 &
# Set background image with feh
feh --bg-fill /home/nazgul/img/wall3.png &

xrdb ~/.Xresources &

xmonad
