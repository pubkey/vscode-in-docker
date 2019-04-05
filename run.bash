#!/usr/bin/env bash


SCRIPT="`readlink -e $0`"
SCRIPTPATH="`dirname $SCRIPT`"
echo $SCRIPTPATH

source ${SCRIPTPATH}/config.bash

mkdir -f ${WORKSPACE}/userdata

# throw if workspace-folder not set
if [ ${WORKSPACE} = "/" ]; then
   echo "Please set your workspace-folder at the config.bash"
   exit 1
else
  echo "## Workspace-folder: ${WORKSPACE}"
fi

MODULENAME="vscode"

#install docker if not done before
echo "try install docker if not exists"
if which docker >/dev/null; then
    echo "docker exists: wont install"
    #service docker start
else
  echo "docker not exists: i will install"
  curl -sSL https://get.docker.com/ | sh
fi

#delete previous container
echo "delete old container"
docker stop $MODULENAME
docker rm -f $MODULENAME

#build docker image
echo "delete old image: $MODULENAME"
#docker rmi $MODULENAME
echo "building image"
docker build -t $MODULENAME $SCRIPTPATH/docker


#allow xHost
xhost +

#make and run container
echo "make container"
echo "IMPORTANT: DONT close this terminal or vscode will close"
docker run --name $MODULENAME \
-it \
--privileged \
--ipc host \
-v $WORKSPACE:/workspace \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev/shm:/dev/shm \
-e DISPLAY=${DISPLAY} \
-v $SCRIPTPATH/userdata:/userdata:Z \
 $MODULENAME

# -v $SCRIPTPATH/mapped:/root/.atom \

#disallow xHost
xhost -
