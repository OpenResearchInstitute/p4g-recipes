Testing
=======
Docker containers are a useful way to test whether the desired gnuradio versions can successfully
be built on particular OSs. These are some versions to test on, based on feedback on Slack:

Linux x86_64:
* Ubuntu 14.04 / Mint 17.3
* Ubuntu 16.04
* Debian 9.1
* RHEL 6.8
* RHEL 7.3
* SUSe Enterprise Linux 11.4
* SUSe Enterprise Linux 12.2

Linux ARM:
* ADI Linux (version?)
* Parallella Linux (version?)

Eventually:
* Custom Yocto recipe

Running with a docker container
-------------------------------
You can run the test container interactively using the `docker run` command. It is considered a best 
practice to consider docker containers ephemeral, i.e. we are not going to 
preserve any state inside the container, and destroy all evidence after 
it is done running.

There are a few more things we want to do with this:

- Map a local directory, so it is visible inside the container. This is done with
  the `-v` option.
- Allow access to external devices, e.g. your SDR hardware. This requires
  `--privileged`.
- Run a vnc server inside the container, so we can get a GUI out of it. The command
  to run this is added to the very end of our lengthy command line. 

You can adjust the mapped VNC server port with altering the argument
'-p 5901:PORT' and the screen size with changing the '-geometry WIDTHxHEIGHT'
part.

You will be asked to set a password for the access via VNC.

Start a container, using the image that we just built. You will get logged in as user "amsat".
For example, under Linux, the invocation would be:

```
docker run -it --rm --privileged -p 5901:5901 -e USER=amsat -v ~/Docker:/home/amsat/Docker p4g:0.9 /bin/bash -c "vncserver :1 -geometry 1440x900 -depth 24 && tail -F /home/amsat/.vnc/*.log"
```

Or, under Windows:
```
docker run -it --rm --privileged -p 5901:5901 -e USER=amsat -v C:/home/jan p4g:0.9 /bin/bash -c "vncserver :1 -geometry 1440x900 -depth 24 && tail -F /home/amsat/.vnc/*.log"
```

This starts the VNC server in the image and exposes it on port 5901. Prileged access is
required in order to access external devices. As it the server starts, it will make 
you set a password.

Connect via VNC client
----------------------

I assume that you are running the container on the same machine you are
running the VNC client. Then you can connect via the ip address
'localhost:5901'. For example using vinagre:

```
$ vinagre localhost:5901
```

Run GNU Radio Companion
-----------------------

Simply open a terminal with the appropriate button in Start/System Tools/XTerm
and run 'gnuradio-companion' from the terminal.

Install new GNU Radio Out-of-Tree modules
-----------------------------------------

The image contains a full PyBOMBS installation. So feel free to run PyBOMBS
and install new packages. For example:

```
$ pybombs install gr-radar
```
