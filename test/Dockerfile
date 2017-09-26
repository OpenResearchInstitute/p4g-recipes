# Derive from Ubuntu
FROM ubuntu:14.04

# Set prefix variables
ENV TheUser amsat
ENV TheHomeDir /home/${TheUser}
# Where we are going to install
ENV P4G_Path ${TheHomeDir}/p4g
# Alias (shorthand) for P4G_Path
ENV P4G p4g

# Update apt and install requirements for pybombs, and other essentials
RUN apt-get update; apt-get install -y --no-install-recommends apt-utils 
RUN apt-get install -y --no-install-recommends \
        sudo \
        vim \
        xterm \ 
        screen \
        python-dev \
        python-pip \
        python-yaml \
        python-apt \
        python-setuptools \
        usbutils \
        git-core

# Create user amsat, and enable sudo
RUN groupadd -r ${TheUser} && useradd -m -r -g ${TheUser} ${TheUser} && usermod -aG sudo ${TheUser}
RUN echo ${TheUser}' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
WORKDIR ${TheHomeDir}

# Switch user
USER ${TheUser}

RUN sudo pip install --upgrade pip

# Install PyBOMBS
RUN sudo pip install PyBOMBS

RUN pybombs prefix init ${P4G_Path} -a ${P4G}
RUN echo "source "${P4G_Path}"/setup_env.sh" >> .bashrc

# Add recipes to PyBOMBS
RUN pybombs recipes add p4g-recipes git+https://github.com/phase4ground/p4g-recipes
RUN pybombs recipes add gr-etcetera git+https://github.com/gnuradio/gr-etcetera.git
RUN pybombs recipes add gr-recipes git+https://github.com/gnuradio/gr-recipes.git

# Setup environment
RUN sudo pybombs -p ${P4G} install "uhd" && sudo rm -rf ${P4G_Path}/src/*
RUN sudo pybombs -p ${P4G} install "libiio" && sudo rm -rf ${P4G_Path}/src/*
RUN sudo pybombs -p ${P4G} install "gr-iio" && sudo rm -rf ${P4G_Path}/src/*
RUN sudo pybombs -p ${P4G} install "gr-osmosdr" && sudo rm -rf ${P4G_Path}/src/*
RUN sudo pybombs -p ${P4G} install "limesuite" && sudo rm -rf ${P4G_Path}/src/*
RUN sudo pybombs -p ${P4G} install "rtl-sdr" && sudo rm -rf ${P4G_Path}/src/*
RUN sudo pybombs -p ${P4G} install --deps-only "gnuradio" && sudo rm -rf ${P4G_Path}/src/*
RUN sudo pybombs -p ${P4G} install --no-deps "gnuradio" && sudo rm -rf ${P4G_Path}/src/*
RUN sudo ldconfig ${P4G_Path}/lib ${P4G_Path}/lib/x86_64-linux-gnu

# Install LXDE and VNC server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y lxde-core lxterminal tightvncserver

# Expose ports.
EXPOSE 5901

# Start VNC server
CMD vncserver :1 -geometry 1280x1024 -depth 24 && tail -F /root/.vnc/*.log
