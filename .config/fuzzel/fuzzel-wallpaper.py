#!/usr/bin/env python3

import os
import glob
import sys
from subprocess import run
from getpass import getuser

wallpaper_dir = f'/home/{getuser()}/Pictures/Wallpapers'

os.chdir(wallpaper_dir)

file_list = glob.glob('*.png') + glob.glob('*.jpg')

if 'wallpaper.jpg' in file_list: 
    file_list.remove('wallpaper.jpg')

if 'wallpaper.png' in file_list: 
    file_list.remove('wallpaper.png')

wallpaper_list = "\n".join(file_list)

selected_wallpaper = run(['fuzzel','--dmenu','-l', f'{len(file_list)}'],
                         input=wallpaper_list,
                         capture_output=True,
                         text=True
                         ).stdout.strip()

if selected_wallpaper in file_list:
    match sys.argv[1]:
        case 'swww':
            run(['swww', 'img', f'{wallpaper_dir}/{selected_wallpaper}', '--transition-type', 'center'])
        case _:
            run(['notify-send', 'Wallpaper Picker', f'Invalid Wallpaper Engine {sys.argv[1]}'])
            exit()

    run(['cp', f'{wallpaper_dir}/{selected_wallpaper}', f'{wallpaper_dir}/{selected_wallpaper}'])

