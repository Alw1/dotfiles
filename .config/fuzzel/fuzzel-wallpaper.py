#!/usr/bin/env python3

import os
import glob
import sys
from subprocess import run
from getpass import getuser

wallpaper_dir = f'/home/{getuser()}/Pictures/Wallpapers'

os.chdir(wallpaper_dir)

supported_formats = [
    "jpeg",
    "jpg",
    "png",
    "gif",
    "pnm",
    "tga",
    "tiff",
    "webp",
    "bmp",
    "farbfeld",
]

wallpapers = []
for format in supported_formats:
    wallpapers += glob.glob(f'*.{format}')

    if (wallpaper := f'wallpaper.{format}') in wallpapers:
        wallpapers.remove(wallpaper)

wallpaper = run(
    ['fuzzel','--dmenu','-l', f'{len(wallpapers)}'],
    input="\n".join(wallpapers),
    capture_output=True,
    text=True).stdout.strip()

if wallpaper in wallpapers:
    match sys.argv[1]:
        case 'swww':
            run(['swww', 'img', f'{wallpaper_dir}/{wallpaper}', '--transition-type', 'center'])
        case _:
            run(['notify-send', 'Wallpaper Picker', f'Invalid Wallpaper Engine'])
