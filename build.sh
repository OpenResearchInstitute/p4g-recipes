#! /bin/sh
# pybombs -p $PyBOMBS_prefix -v install "uhd" 
pybombs install "libiio"
pybombs install "gr-iio" 
# pybombs -p $PyBOMBS_prefix -v install "gr-osmosdr"
# pybombs -p $PyBOMBS_prefix -v install "limesuite"
# pybombs -p $PyBOMBS_prefix -v install "rtl-sdr"
pybombs install "gnuradio"
# ldconfig $PyBOMBS_init/lib $PyBOMBS_init/lib/x86_64-linux-gnu
