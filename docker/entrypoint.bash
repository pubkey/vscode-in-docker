echo "##################################"
echo "####### ENTRYPOINT.bash ##########"
echo "##################################"

# FIX https://stackoverflow.com/questions/50142049/enospc-no-space-left-on-device-nodejs
echo "# fix: no space left on device"
echo 524288 | tee /proc/sys/fs/inotify/max_user_watches
sysctl -p /etc/sysctl.conf
echo "# Max user watches:"
cat /proc/sys/fs/inotify/max_user_watches


# test deno
deno --version

#bash
echo "# start vscode as $USER"
whoami
echo "# start vscode"
su $USER -c '/usr/bin/code --verbose --user-data-dir /userdata'
