@echo off
echo --------------------------------------------------------------------------------
echo %DATE% %TIME% %~nx0 for user: "%USERNAME%" on computer: "%COMPUTERNAME%" starting
echo --------------------------------------------------------------------------------

echo "Now you can build an image called vnc_ubuntu"
docker build -t vnc_ubuntu .

IF errorlevel 1 (
    echo "docker build not passing"
    goto PAUSEEND
)

echo "Run the container with this command"
docker run -dt --rm --name vnc_ubuntu -p 5901:5901 vnc_ubuntu

IF errorlevel 1 (
    echo "docker run not passing"
    goto PAUSEEND
)

echo "List the running containers"
docker ps

echo "start vncviewer and point to localhost:5901"
vncviewer.exe -connect localhost:5901 -password password

echo "Stop a running Docker container"
docker stop vnc_ubuntu

echo "List the running containers"
docker ps

::echo "Remove the container"
::docker rm vnc_ubuntu  

goto END

:PAUSEEND
pause

:END
echo --------------------------------------------------------------------------------
echo %DATE% %TIME% %~nx0 for user: "%USERNAME%" on computer: "%COMPUTERNAME%" ended
echo --------------------------------------------------------------------------------
::pause
