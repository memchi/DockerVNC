# DockerVNC

## How to make a Docker container with VNC access

see: <https://medium.com/@gustav0.lewin/how-to-make-a-docker-container-with-vnc-access-f607958141ae>

## Start the VNC server

To start the VNC server, it’s necessary to execute the script start-vnc.sh.
You can automate this process by specifying an entrypoint in the Dockerfile.
However, if you prefer manual execution like me:
docker exec -ti vnc_ubuntu /bin/bash

Once you have access to the container’s CLI:
`./start-vnc.sh`

Now you can use a VNC client in the host machine to access your container
via localhost:5901 (tested with RealVNC Viewer).
The password was defined in the Dockerfile as “password”.

<https://youtu.be/_udIBPKcimo>
