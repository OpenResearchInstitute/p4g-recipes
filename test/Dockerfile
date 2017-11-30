# Derive from Ubuntu
FROM ubuntu:16.04

# Set prefix variables
ENV TheUser amsat
ENV TheHomeDir /home/${TheUser}
# Alias (shorthand) for P4G_Path
ENV P4G p4g
# Where we are going to install
ENV P4G_Path ${TheHomeDir}/${P4G}

# Update apt database, install prerequisites for pybombs, and some tools
RUN apt-get update
# Checkme
RUN apt-get -y upgrade
# FIXME - the update and install need to be in the same statement for production use.
RUN apt-get install -y --no-install-recommends  \
        # For pybombs
        apt-utils python-pip python-apt python-setuptools \
        # System management
        sudo vim xterm screen usbutils git-core \
        # experimental
        lxde-core lxterminal tightvncserver

# Create user amsat, and enable sudo
RUN groupadd -r ${TheUser} && useradd -m -r -g ${TheUser} ${TheUser} && usermod -aG sudo ${TheUser}
RUN echo ${TheUser}' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
WORKDIR ${TheHomeDir}

# Switch user
USER ${TheUser}

# Update pip to the latest version
RUN sudo -H pip install --upgrade pip
# RUN sudo -H pip install urllib3[secure] --upgrade

# Install PyBOMBS
RUN sudo -H pip install PyBOMBS

# Create pybombs prefix and add its environment to bash startup script
RUN sudo -H pybombs prefix init ${P4G_Path} -a ${P4G}
RUN echo "source "${P4G_Path}"/setup_env.sh" >> .bashrc

# Add recipes to PyBOMBS
RUN sudo -H pybombs recipes add p4g-recipes git+https://github.com/phase4ground/p4g-recipes
RUN sudo -H pybombs recipes add gr-etcetera git+https://github.com/gnuradio/gr-etcetera.git
RUN sudo -H pybombs recipes add gr-recipes git+https://github.com/gnuradio/gr-recipes.git

# Finally: Run pybombs, then update the system's shared library registry
RUN sudo -H pybombs -p ${P4G} install gr-iio && sudo -H rm -rf ${P4G_Path}/src/*
RUN sudo -H pybombs -p ${P4G} install gr-osmosdr && sudo -H rm -rf ${P4G_Path}/src/*
RUN sudo -H pybombs -p ${P4G} install limesuite && sudo -H rm -rf ${P4G_Path}/src/*
RUN sudo -H ldconfig ${P4G_Path}/lib ${P4G_Path}/lib/x86_64-linux-gnu

# Install LXDE and VNC server
# RUN DEBIAN_FRONTEND=noninteractive sudo apt-get install -y lxde-core lxterminal tightvncserver

# Expose ports.
EXPOSE 5901

# Start VNC server
CMD vncserver :1 -geometry 1440x900 -depth 24 && tail -F /root/.vnc/*.log
