FROM ubuntu

MAINTAINER Jason Lines "commanderjason@gmail.com"

ENV USER root

# Update aptitude with new repo
RUN dpkg --add-architecture i386
RUN apt-get update

# Install software 

RUN apt-get install -y gawk wget screen make git arduino-core curl g++ python-pip python-matplotlib python-serial python-wxgtk2.8 python-scipy python-opencv python-numpy python-pyparsing ccache gcc-avr binutils-avr avr-libc python-serial python-argparse openocd flex bison libncurses5-dev autoconf texinfo build-essential libftdi-dev libtool zlib1g-dev zip genromfs libc6:i386 libgcc1:i386 gcc-4.6-base:i386 libstdc++5:i386 libstdc++6:i386

# Clone the conf files into the docker container
RUN git clone -b jlines https://github.com/jlines/ardupilot.git /usr/local/src/ardupilot
RUN git clone https://github.com/diydrones/PX4Firmware.git /usr/local/src/PX4Firmware
RUN git clone https://github.com/diydrones/PX4NuttX.git /usr/local/src/PX4NuttX
RUN git clone https://github.com/diydrones/uavcan.git /usr/local/src/uavcan

WORKDIR "/usr/local/src"

RUN wget http://firmware.diydrones.com/Tools/PX4-tools/gcc-arm-none-eabi-4_7-2014q2-20140408-linux.tar.bz2
RUN tar xjf gcc-arm-none-eabi-4_7-2014q2-20140408-linux.tar.bz2
RUN rm gcc-arm-none-eabi-4_7-2014q2-20140408-linux.tar.bz2

#RUN /usr/local/src/ardupilot/Tools/scripts/install-prereqs-ubuntu.sh -y
RUN pip install pymavlink MAVProxy

ENV PATH=$PATH:/usr/local/src/ardupilot/Tools/autotest
ENV PATH=$PATH:/usr/local/src/gcc-arm-none-eabi-4_7-2014q2/bin

WORKDIR "/usr/local/src/ardupilot/ArduCopter"
RUN make configure
RUN make sitl
CMD sim_vehicle.sh
