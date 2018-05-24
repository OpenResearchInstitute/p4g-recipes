#!/bin/bash

docker run -it --rm --privileged -p 5901:5901 -e USER=amsat -v ~/Docker:/home/amsat/Docker p4g:0.7 /bin/bash

