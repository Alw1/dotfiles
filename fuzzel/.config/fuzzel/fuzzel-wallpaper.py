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

wallpapers = {name.split('.')[0]: name for name in wallpapers}

wallpaper = run(
    ['fuzzel','--dmenu','-l', f'{len(wallpapers)}', '-p', 'Wallpaper: '],
    input="\n".join(wallpapers),
    capture_output=True,
    text=True).stdout.strip()

if wallpaper in wallpapers:
    run(['matugen', 'image', f'{wallpaper_dir}/{wallpapers[wallpaper]}'])
