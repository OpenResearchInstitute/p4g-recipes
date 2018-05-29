#!/bin/bash

docker run -it --rm --privileged -e USER=amsat -v ~/Docker:/home/amsat/Docker molino-lime:0.1 /bin/bash

