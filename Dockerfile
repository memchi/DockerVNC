# Use an official Ubuntu base image
#FROM ubuntu:20.04
FROM ubuntu

# Avoid warnings by switching to noninteractive for the build process
ENV DEBIAN_FRONTEND=noninteractive

ENV USER=root

RUN apt-get autoclean -y && apt-get autoremove -y && apt-get -f install -y && apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get autoclean -y && apt-get autoremove -y

# Install XFCE, VNC server, dbus-x11, and xfonts-base
RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    dbus-x11 \
    xfonts-base \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get autoclean -y && apt-get autoremove -y && apt-get -f install -y && apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get autoclean -y && apt-get autoremove -y

# install my stuff
RUN apt-get install dos2unix --assume-yes
#RUN apt-get install firefox --assume-yes

RUN apt-get autoclean -y && apt-get autoremove -y && apt-get -f install -y && apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get autoclean -y && apt-get autoremove -y

# Setup VNC server
RUN mkdir /root/.vnc \
    && echo "password" | vncpasswd -f > /root/.vnc/passwd \
    && chmod 600 /root/.vnc/passwd

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