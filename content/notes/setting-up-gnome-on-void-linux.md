+++
title = "Void Linux GNOME Setup"
description = "Setting up GNOME on Void Linux with Xorg/Wayland."
date = 2024-11-22
insert_anchor_links = "heading"
draft = true

[extra]
keywords = ["void", "linux", "gnome", "xorg", "wayland", "setup"]
code = true
+++

The script below is made for someone wanting a fresh GNOME install on Void Linux.  
**If you already have a system set up, errors can occur between seat managers,
services and the desktop environment.**

```sh
curl -f https://stigsen.dev/assets/scripts/void-linux.sh | sh
```

```sh
#!/bin/sh
function xorg() {
    xbps-install xorg
}

function wayland() {
    xbps-install -y xorg-server-xwayland
    xbps-install -y qt5-wayland # for qt5 application
    xbps-install -y kwayland # for kde applications
    
    echo 'Setting environment variables...'
    [ -z "$ELM_DISPLAY"        ] && echo 'ELM_DISPLAY=wl'              >> /etc/environment
    [ -z "$SDL_VIDEODRIVER"    ] && echo 'SDL_VIDEODRIVER=wayland'     >> /etc/environment
    [ -z "$QT_QPA_PLATFORM"    ] && echo 'QT_QPA_PLATFORM=wayland-egl' >> /etc/environment
    [ -z "$MOZ_ENABLE_WAYLAND" ] && echo 'MOZ_ENABLE_WAYLAND=1'        >> /etc/environment
}

function main() {
    clear
    if [ $(id -u) -ne 0 ]; then
        echo 'Please run this script as root or using sudo!'
        exit
    fi

    xbps-install -Suy
    xbps-install -y gnome gdm xdg-desktop-portal-gnome #gnome-apps
    xbps-install -y dbus turnstile seatd acpid

    echo 'Enabling services...'
    ln -s /etc/sv/gdm /var/service/
    ln -s /etc/sv/dbus /var/service/
    ln -s /etc/sv/turnstile /var/service/
    ln -s /etc/sv/seatd /var/service/
    ln -s /etc/sv/acpid /var/service/

    # choose xorg or wayland here
    # xorg
    wayland

    reboot
}

main
```
