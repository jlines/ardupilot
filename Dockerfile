FROM ubuntu

MAINTAINER Jason Lines "commanderjason@gmail.com"

ENV USER root

# Update aptitude with new repo
RUN dpkg --add-architecture i386
RUN apt-get update

# Install software 
RUN apt-get install -y git wget

# Clone the conf files into the docker container
RUN git clone https://github.com/diydrones/ardupilot.git /usr/local/src/ardupilot

RUN /usr/local/src/ardupilot/Tools/scripts/install-prereqs-ubuntu.sh -y
#RUN -w /usr/local/src/ardupilot/Copter make configure
#RUN -w /usr/local/src/ardupilot/Copter make