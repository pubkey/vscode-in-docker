FROM ubuntu:20.04

# https://github.com/cmiles74/docker-vscode
# https://hub.docker.com/r/joengenduvel/docker-vscode/dockerfile

ENV DISPLAY=10.0.75.1:0.0
ARG DEBIAN_FRONTEND=noninteractive

##
## ubuntu stuff
##

RUN apt-get update \
 && apt-get install -y curl apt-transport-https libgtk2.0-0 libxss1 libasound2 xauth x11-apps dbus git gpg

RUN apt-get install libx11-xcb-dev -y
RUN apt-get install wget -y

RUN mkdir /var/run/dbus

# install firefox
RUN apt-get install firefox -y
RUN apt-get install --no-install-recommends firefox
ENV BROWSER /usr/bin/firefox

# install nodejs and npm
RUN wget https://nodejs.org/dist/v11.13.0/node-v11.13.0-linux-x64.tar.gz -O /tmp/nodejs.tar.gz
RUN tar -C /usr/local --strip-components 1 -xzf /tmp/nodejs.tar.gz
RUN ls -l /usr/local/bin/node
RUN ls -l /usr/local/bin/npm
RUN ln -s `which node` /usr/bin/nodejs
RUN npm i -g npm
RUN npm install -g n
RUN n latest

# npm modules
RUN npm install -g eslint
RUN npm install -g typescript

# install python (needed for some vscode plugins like python formater)
RUN apt-get install python3.6 -y
RUN python3 --version
RUN apt-get update && apt-get install python3-pip -y
RUN pip3 install pylint
RUN pip3 install autopep8

# install flat plat theme
RUN wget 'https://github.com/nana-4/Flat-Plat/releases/download/3.20.20160404/Flat-Plat-3.20.20160404.tar.gz'
RUN tar -xf Flat-Plat*
RUN mv Flat-Plat /usr/share/themes
RUN rm Flat-Plat*gz
RUN mv /usr/share/themes/Default /usr/share/themes/Default.bak
RUN ln -s /usr/share/themes/Flat-Plat /usr/share/themes/Default

##
## /ubuntu stuff
##

##
## vscode stuff
##

RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
  && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
  && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# show available vscode versions
RUN apt-cache policy code


RUN apt-get update && apt-get install -y code=1.48.2-1598353430 \
  && apt-get install -f

RUN cp /usr/lib/x86_64-linux-gnu/libxcb.so.1 /usr/share/code/ \
  && cp /usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0 /usr/share/code/ \
  && sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/share/code/libxcb.so.1 \
  && sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/share/code/libxcb.so.1.1.0

# change user so vscode does not run as root
ENV USER=dev
ENV GROUP=developers
RUN groupadd $GROUP
RUN useradd -m -G $GROUP $USER
USER $USER

# vscode-extensions
RUN /usr/bin/code --install-extension dbaeumer.vscode-eslint
RUN /usr/bin/code --install-extension naumovs.color-highlight
RUN /usr/bin/code --install-extension mde.select-highlight-minimap
RUN /usr/bin/code --install-extension coenraads.bracket-pair-colorizer-2
RUN /usr/bin/code --install-extension eamodio.gitlens
RUN /usr/bin/code --install-extension vscode-icons-team.vscode-icons
RUN /usr/bin/code --install-extension ms-azuretools.vscode-docker
RUN /usr/bin/code --install-extension donjayamanne.githistory
RUN /usr/bin/code --install-extension naumovs.theme-oceanicnext
RUN /usr/bin/code --install-extension pflannery.vscode-versionlens
RUN /usr/bin/code --install-extension rokoroku.vscode-theme-darcula
RUN /usr/bin/code --install-extension xabikos.JavaScriptSnippets
RUN /usr/bin/code --install-extension zhuangtongfa.Material-theme
RUN /usr/bin/code --install-extension octref.vetur
RUN /usr/bin/code --install-extension oderwat.indent-rainbow
RUN /usr/bin/code --install-extension tomoki1207.pdf
RUN /usr/bin/code --install-extension ms-vscode.vscode-typescript-tslint-plugin
RUN /usr/bin/code --install-extension mikebovenlander.formate
RUN /usr/bin/code --install-extension redhat.vscode-yaml
RUN /usr/bin/code --install-extension william-voyek.vscode-nginx
RUN /usr/bin/code --install-extension ms-python.python

# angular
RUN /usr/bin/code --install-extension angular.ng-template

RUN /usr/bin/code --list-extensions

USER root

##
## /vscode stuff
##


# BUGFIXES

# https://github.com/angular-fullstack/generator-angular-fullstack/issues/1538
RUN apt-get install xdg-utils --fix-missing -y

# fixes broken delete of files
RUN apt-get update && apt-get install gvfs-bin -y



WORKDIR /workspace

COPY entrypoint.bash /usr/bin/entrypoint.bash
ENTRYPOINT /bin/bash /usr/bin/entrypoint.bash
