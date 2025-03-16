FROM ubuntu:20.04

# Set environment variable to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install packages for xfce and other tools
RUN apt-get update && \
    apt-get install -y tzdata && \
    apt-get install -y xfce4 && \
    apt-get install -y tightvncserver && \
    apt-get install -y wget && \
    apt-get install -y sudo && \
    apt-get install -y git && \
    apt-get install -y xfce4-terminal && \
    apt-get clean

RUN apt-get install -y autocutsel
RUN apt-get install -y python3 python3-pip
# RUN apt-get install firefox -y
RUN apt-get install -y npm
# Install VS Code Insiders using Microsoft's package repository
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg && \
    sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    rm -f packages.microsoft.gpg && \
    apt-get update && \
    apt-get install -y code-insiders
RUN apt-get clean

# Setup VNC server directory
RUN mkdir -p /root/.vnc

COPY xstartup /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

# Install noVNC
RUN git clone https://github.com/novnc/noVNC.git /root/noVNC

# Copy startup script
COPY startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

# Set USER environment variable
ENV USER=root

# Expose NoVNC port
EXPOSE 5901
EXPOSE 6081

# Start the VNC server and noVNC
CMD ["/root/startup.sh"]
