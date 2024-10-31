@echo off
echo --------------------------------------------------------------------------------
echo %DATE% %TIME% %~nx0 for user: "%USERNAME%" on computer: "%COMPUTERNAME%" starting
echo --------------------------------------------------------------------------------

:: Now you can build an image called vnc_ubuntu:
docker build -t vnc_ubuntu .

:: Run the container with this command:
docker run -dt --rm --name vnc_ubuntu -p 5901:5901 vnc_ubuntu

:: To start the VNC server, it’s necessary to execute the script start-vnc.sh.
:: You can automate this process by specifying an entrypoint in the Dockerfile. 
:: However, if you prefer manual execution like me:
:: docker exec -ti vnc_ubuntu /bin/bash

:: Once you have access to the container’s CLI:
:: # ./start-vnc.sh

:: Now you can use a VNC client in the host machine to access your container 
:: via localhost:5901 (tested with RealVNC Viewer). 
:: The password was defined in the Dockerfile as “password”.

:: start vncviewer and point to localhost:5901
vncviewer.exe -connect localhost:5901 -password password

:END
echo --------------------------------------------------------------------------------
echo %DATE% %TIME% %~nx0 for user: "%USERNAME%" on computer: "%COMPUTERNAME%" ended
echo --------------------------------------------------------------------------------
::pause
