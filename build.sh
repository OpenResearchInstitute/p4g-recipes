#! /bin/sh
set PyBOMBS_prefix=deleteme
bin/pybombs recipes add p4g-recipes git+https://github.com/phase4ground/p4g-recipes
bin/pybombs recipes add gr-etcetera git+https://github.com/gnuradio/gr-etcetera.git
bin/pybombs recipes add gr-recipes git+https://github.com/gnuradio/gr-recipes.git
bin/pybombs prefix init -a $PyBOMBS_prefix
# pybombs -p $PyBOMBS_prefix -v install "uhd" 
bin/pybombs -p $PyBOMBS_prefix -v install "libiio"
bin/pybombs -p $PyBOMBS_prefix -v install "gr-iio" 
# pybombs -p $PyBOMBS_prefix -v install "gr-osmosdr"
# pybombs -p $PyBOMBS_prefix -v install "limesuite"
# pybombs -p $PyBOMBS_prefix -v install "rtl-sdr"
bin/pybombs -p $PyBOMBS_prefix -v install --deps-only "gnuradio"
bin/pybombs -p $PyBOMBS_prefix -v install --no-deps "gnuradio"
# ldconfig $PyBOMBS_init/lib $PyBOMBS_init/lib/x86_64-linux-gnu
