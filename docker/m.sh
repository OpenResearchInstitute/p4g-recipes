#!/bin/bash

docker run -it --rm --privileged -e USER=amsat --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" -v ~/Docker:/home/amsat/Docker -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v /dev/bus/usb:/dev/bus/usb gnuradio:0.1 /bin/bash
