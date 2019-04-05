FROM ubuntu:18.10

# https://github.com/cmiles74/docker-vscode
# https://hub.docker.com/r/joengenduvel/docker-vscode/dockerfile

ENV DISPLAY=10.0.75.1:0.0

RUN apt-get update \
 && apt-get install -y curl apt-transport-https libgtk2.0-0 libxss1 libasound2 xauth x11-apps dbus git gpg

RUN apt-get install libx11-xcb-dev -y
RUN apt-get install wget -y

RUN mkdir /var/run/dbus

RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
  && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
  && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

RUN apt-get update && apt-get install -y code \
  && apt-get install -f

RUN cp /usr/lib/x86_64-linux-gnu/libxcb.so.1 /usr/share/code/ \
  && cp /usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0 /usr/share/code/ \
  && sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/share/code/libxcb.so.1 \
  && sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/share/code/libxcb.so.1.1.0

# install flat plat theme
run wget 'https://github.com/nana-4/Flat-Plat/releases/download/3.20.20160404/Flat-Plat-3.20.20160404.tar.gz'
run tar -xf Flat-Plat*
run mv Flat-Plat /usr/share/themes
run rm Flat-Plat*gz
run mv /usr/share/themes/Default /usr/share/themes/Default.bak
run ln -s /usr/share/themes/Flat-Plat /usr/share/themes/Default

# install firefox
RUN apt-get install firefox -y
RUN apt-get install --no-install-recommends firefox
ENV BROWSER /usr/bin/firefox

# BUGFIXES

# https://github.com/angular-fullstack/generator-angular-fullstack/issues/1538
RUN apt-get install xdg-utils --fix-missing -y

# fixes broken delete of files
RUN apt-get install gvfs-bin -y

WORKDIR /workspace

ENV USER=dev
ENV GROUP=developers
RUN groupadd $GROUP
RUN useradd -m -G $GROUP $USER
USER $USER

COPY entrypoint.bash /usr/bin/entrypoint.bash
ENTRYPOINT /bin/bash /usr/bin/entrypoint.bash
