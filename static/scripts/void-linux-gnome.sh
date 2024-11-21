#!/bin/sh
function xorg() {
    xbps-install xorg
}

function wayland() {
    xbps-install -y xorg-server-xwayland
    xbps-install -y qt5-wayland # for qt5 applications
    xbps-install -y kwayland    # for kde applications

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

    echo 'Updating system and installing required applications...'
    xbps-install -Suy
    xbps-install -y gnome gdm xdg-desktop-portal-gnome #gnome-apps
    xbps-install -y dbus turnstile seatd acpid

    echo 'Enabling services...'
    ln -sf /etc/sv/gdm /var/service/
    ln -sf /etc/sv/dbus /var/service/
    ln -sf /etc/sv/turnstile /var/service/
    ln -sf /etc/sv/seatd /var/service/
    ln -sf /etc/sv/acpid /var/service/

    echo 'Setting up Xorg or Wayland...'
    # xorg    && echo 'Rebooting...' && reboot && exit 0
    # wayland && echo 'Rebooting...' && reboot && exit 0

    echo 'You need to uncomment xorg or wayland in main function'
    exit 1
}

main
