#!/usr/bin/env python3

from subprocess import run

options = {
    "Lock"           : "hyprlock",
    "Suspend"        : "systemctl suspend",
    "Log Out"        : "hyprctl dispatch exit",
    "Reboot"         : "systemctl reboot",
    "Reboot to UEFI" : "systemctl reboot --firmware-setup",
    "Shutdown"       : "systemctl poweroff",
}

option = run(
    ['fuzzel','--dmenu','-l', f'{len(options)}', '-p', 'Power Menu: '],
    input="\n".join([f'{i+1}. {opt}' for i, opt in enumerate(options)]),
    capture_output=True,
    text=True).stdout.strip()

if (opt := option.split('.')[1].strip()) in options:
    run(options[opt], shell=True)
