# vscode in docker
This is a docker-container with the [vscode](https://code.visualstudio.com/)-editor.

## Why you should use this?

* You can commit your vs-code settings and plugins and share them on different devices
* You always have your dependencies installed inside the container
* You can limit the internet-access to ensure no data will be send to microsoft

## Install
1. `git clone https://github.com/pubkey/vscode-in-docker.git`
2. `cd vscode-in-docker`
3. Edit the config.bash and include your workspace-folder
4. `sudo bash run.bash`
5. (It will take about 15 minutes when it runs for the first time.)

## ( optional to start the container without root )
6. `sudo usermod -a -G docker alice` // replace alice with your username
7. restart your system
