#!/usr/bin/env python3

import os
from subprocess import run

# niri and Hyprland each need their own exit command.
logout = "niri msg action quit -s" if os.environ.get('NIRI_SOCKET') else "hyprctl dispatch exit"

# Name : Command
options = {
    "Lock"           : "hyprlock",
    "Suspend"        : "systemctl suspend",
    "Log Out"        : logout,
    "Reboot"         : "systemctl reboot",
    "Reboot to UEFI" : "systemctl reboot --firmware-setup",
    "Shutdown"       : "systemctl poweroff",
}

option = run(
    ['fuzzel','--dmenu','-l', f'{len(options)}', '-p', 'Power Menu: '],
    input="\n".join([f'{i}. {opt}' for i, opt in enumerate(options, start=1)]),
    capture_output=True,
    text=True).stdout.strip()

if (opt := option.split('.')[1].strip()) in options:
    run(options[opt], shell=True)
