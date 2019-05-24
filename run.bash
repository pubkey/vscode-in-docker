#!/usr/bin/env bash

echo "# Starting vs-code-in-docker.."

SCRIPT="`readlink -e $0`"
SCRIPTPATH="`dirname $SCRIPT`"

echo "# SCRIPTPATH:"
echo $SCRIPTPATH

source ${SCRIPTPATH}/config.bash

mkdir -p ${WORKSPACE}/userdata

# clear logs
echo "# clear logs"
rm -rf userdata/logs/*

# throw if workspace-folder not set
if [ ${WORKSPACE} = "/" ]; then
   echo "# Please set your workspace-folder at the config.bash"
   exit 1
else
  echo "# Workspace-folder: ${WORKSPACE}"
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

echo "# delete old container"

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
--rm \
--privileged \
-v $WORKSPACE:/workspace \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
-v /dev/shm:/dev/shm \
-e DISPLAY=${DISPLAY} \
-v $SCRIPTPATH/userdata:/userdata:Z \
 $MODULENAME

# -v $SCRIPTPATH/mapped:/root/.atom \

#disallow xHost
xhost -
