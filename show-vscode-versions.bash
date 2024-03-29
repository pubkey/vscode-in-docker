sudo apt-get update

sudo curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
  && sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
  && sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get update && apt-get install -y code

# show available vscode versions
sudo apt-cache policy code
