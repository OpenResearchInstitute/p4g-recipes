FROM debian:stretch

# Set prefix variables
ENV TheUser amsat
ENV TheHomeDir /home/${TheUser}
# Alias (shorthand) for P4G_Path
ENV P4G p4g
# Where we are going to install
ENV P4G_Path ${TheHomeDir}/${P4G}

# Update apt database, install prerequisites for pybombs, and some tools
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
        # For pybombs
        apt-utils python-pip python-apt python-setuptools python-dev \
        # System management
        sudo vim xterm screen usbutils git-core net-tools \
        # Avoid building wxPython
        python-wxgtk3.0-dev python-gtk2 \
        # for thrift
        zlib1g-dev

# Create user amsat, and enable sudo
RUN adduser ${TheUser} && usermod -aG sudo ${TheUser}
RUN echo ${TheUser}' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
WORKDIR ${TheHomeDir}

# Install PyBOMBS
RUN pip install pybombs

# Switch user
USER ${TheUser}

RUN pybombs recipes add-defaults
RUN pybombs recipes add p4g-recipes https://github.com/phase4ground/p4g-recipes.git

RUN pybombs prefix init ${P4G_Path} -a ${P4G} 
RUN pybombs install gnuradio && rm -rf ${P4G_Path}/src/*

RUN pybombs install limesuite && rm -rf ${P4G_Path}/src/*
RUN pybombs install gr-limesdr && rm -rf ${P4G_Path}/src/*
# RUN pybombs install gr-iio && rm -rf ${P4G_Path}/src/*
RUN pybombs install gr-dvbs2  && rm -rf ${P4G_Path}/src/*

RUN sudo -H ldconfig ${P4G_Path}/lib ${P4G_Path}/lib/x86_64-linux-gnu

# Create pybombs prefix and add its environment to bash startup script
RUN echo "source "${P4G_Path}"/setup_env.sh" >> .bashrc
RUN echo "export PATH=$PATH:~/.local/bin" >> .bashrc

# Add pybombs to path
ENV PATH=${TheHomeDir}/.local/bin:${PATH}

