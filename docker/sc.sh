#!/bin/bash

docker run -it --rm --privileged -e USER=amsat -v ~/Docker:/home/amsat/Docker molino-gnuradio:0.1 /bin/bash

