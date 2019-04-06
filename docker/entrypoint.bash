# FIX https://stackoverflow.com/questions/50142049/enospc-no-space-left-on-device-nodejs
echo 524288 | tee /proc/sys/fs/inotify/max_user_watches
sysctl -p /etc/sysctl.conf
echo "# Max user watches:"
cat /proc/sys/fs/inotify/max_user_watches

# start vscode
su dev -c 'echo "hello from $USER"'
echo "# start vscode"
su dev -c '/usr/bin/code --verbose --user-data-dir /userdata'
