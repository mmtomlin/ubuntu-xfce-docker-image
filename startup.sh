#!/bin/sh

# Set default VNC password if not provided
if [ -z "${VNC_PASSWORD}" ]; then
    echo "WARNING: No VNC_PASSWORD provided, using default password 'vncpassword'"
    VNC_PASSWORD="vncpassword"
fi

# Set up VNC password
echo "${VNC_PASSWORD}" | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

export DISPLAY=:1.0

# Start novnc
/root/noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 0.0.0.0:6081 &

# Start the VNC server
vncserver -geometry 1280x800 -depth 24

# Start autocutsel to sync clipboard
autocutsel -fork

tail  /root/.vnc/*.log # <---- this is where the VNC logs are
