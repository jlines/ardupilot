#!/bin/bash
set -e

CWD=$(pwd)
OPT="/opt"

BASE_PKGS="gawk make git arduino-core curl"
SITL_PKGS="g++ python-pip python-matplotlib python-serial python-wxgtk2.8 python-scipy python-opencv python-numpy python-pyparsing ccache"
AVR_PKGS="gcc-avr binutils-avr avr-libc"
PYTHON_PKGS="pymavlink MAVProxy droneapi"
PX4_PKGS="python-serial python-argparse openocd flex bison libncurses5-dev \
          autoconf texinfo build-essential libftdi-dev libtool zlib1g-dev \
          zip genromfs"
UBUNTU64_PKGS="libc6:i386 libgcc1:i386 gcc-4.6-base:i386 libstdc++5:i386 libstdc++6:i386"
ASSUME_YES=false

# GNU Tools for ARM Embedded Processors
# (see https://launchpad.net/gcc-arm-embedded/)
ARM_ROOT="gcc-arm-none-eabi-4_7-2014q2"
ARM_TARBALL="$ARM_ROOT-20140408-linux.tar.bz2"
ARM_TARBALL_URL="http://firmware.diydrones.com/Tools/PX4-tools/$ARM_TARBALL"

# Ardupilot Tools
ARDUPILOT_TOOLS="ardupilot/Tools/autotest"



exportline="export PATH=$OPT/$ARM_ROOT/bin:\$PATH";
if ! grep -Fxq "$exportline" ~/.profile ; then
    if maybe_prompt_user "Add $OPT/$ARM_ROOT/bin to your PATH [Y/n]?" ; then
        echo $exportline >> ~/.profile
        $exportline
    else
        echo "Skipping adding $OPT/$ARM_ROOT/bin to PATH."
    fi
fi

exportline2="export PATH=$CWD/$ARDUPILOT_TOOLS:\$PATH";
if ! grep -Fxq "$exportline2" ~/.profile ; then
    if maybe_prompt_user "Add $CWD/$ARDUPILOT_TOOLS to your PATH [Y/n]?" ; then
        echo $exportline2 >> ~/.profile
        $exportline2
    else
        echo "Skipping adding $CWD/$ARDUPILOT_TOOLS to PATH."
    fi
fi

apt-cache search arm-none-eabi
