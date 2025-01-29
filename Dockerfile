# Use an official Ubuntu base image
#FROM ubuntu:20.04
FROM ubuntu

# Avoid warnings by switching to noninteractive for the build process
ENV DEBIAN_FRONTEND=noninteractive

ENV USER=root

# update all
RUN apt-get autoclean -y && apt-get autoremove -y && apt-get -f install -y && apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get autoclean -y && apt-get autoremove -y

# https://wiki.ubuntuusers.de/VNC/
RUN apt-get install tightvncserver -y

# https://help.ubuntu.com/community/ServerGUI
RUN apt-get install xauth -y
RUN apt-get install xorg -y

# https://wiki.ubuntuusers.de/Openbox/
# https://help.ubuntu.com/community/Openbox
RUN apt-get install openbox -y
RUN apt-get install obconf -y
#RUN apt-get install openbox-menu -y
#RUN apt-get install obmenu -y
RUN apt-get install xfonts-base -y

# install my stuff
RUN apt-get install dos2unix --assume-yes
RUN apt-get install firefox --assume-yes

# update all
RUN apt-get autoclean -y && apt-get autoremove -y && apt-get -f install -y && apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get autoclean -y && apt-get autoremove -y

# Setup VNC server
RUN mkdir /root/.vnc
RUN echo "password" | vncpasswd -f > /root/.vnc/passwd
RUN chmod 600 /root/.vnc/passwd

# Create an .Xauthority file
RUN touch /root/.Xauthority

# Set display resolution (change as needed)
#ENV RESOLUTION=1920x1080
ENV RESOLUTION=1024x800

# Expose VNC port
EXPOSE 5901

# Set the working directory in the container
WORKDIR /app

# Copy a script to start the VNC server
COPY start-vnc.sh start-vnc.sh
RUN chmod +x start-vnc.sh
RUN dos2unix start-vnc.sh

# List the contents of the /app directory
RUN ls -Al /app

# An ENTRYPOINT allows you to configure a container that will run as an executable.
ENTRYPOINT ["/app/start-vnc.sh"]
