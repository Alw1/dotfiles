#!/usr/bin/env python3
"""
Dynamically renames Hyprland workspaces based on the last focused window.
Run as a daemon alongside waybar.
"""

import json
import os
import socket
import subprocess
import sys


def get_label(class_name: str) -> str:
    # Normalize class names that are awkward as-is
    overrides = {
        'google-chrome': 'chrome',
        'code-oss': 'code',
        'codium': 'VSCode',
        'org.gnome.nautilus': 'files',
        'kitty': 'terminal'
    }
    lower = class_name.lower()
    if lower in overrides:
        return overrides[lower]
    # Strip reverse-DNS prefixes like org.gnome.*, com.example.*, etc.
    parts = class_name.split('.')
    if len(parts) >= 3 and parts[0].lower() in ('org', 'com', 'io', 'net'):
        return parts[-1]
    return class_name


def rename_workspace(ws_id: int, name: str):
    subprocess.run(
        ['hyprctl', 'dispatch', 'renameworkspace', str(ws_id), name],
        capture_output=True,
    )


def get_active_workspace_id() -> int:
    result = subprocess.run(
        ['hyprctl', 'activeworkspace', '-j'],
        capture_output=True, text=True,
    )
    return json.loads(result.stdout)['id']


def initialize():
    """Set workspace names based on current window state."""
    clients = json.loads(subprocess.run(
        ['hyprctl', 'clients', '-j'], capture_output=True, text=True
    ).stdout)
    workspaces = json.loads(subprocess.run(
        ['hyprctl', 'workspaces', '-j'], capture_output=True, text=True
    ).stdout)

    # Find most-recently-focused window per workspace (lowest focusHistoryID wins)
    best: dict[int, tuple[int, str]] = {}
    for c in clients:
        ws_id = c['workspace']['id']
        fid = c.get('focusHistoryID', 999999)
        if ws_id not in best or fid < best[ws_id][0]:
            best[ws_id] = (fid, c['class'])

    for ws in workspaces:
        ws_id = ws['id']
        if ws_id in best:
            rename_workspace(ws_id, f'{ws_id}: {get_label(best[ws_id][1])}')


def main():
    sig = os.environ.get('HYPRLAND_INSTANCE_SIGNATURE')
    if not sig:
        sys.exit('HYPRLAND_INSTANCE_SIGNATURE not set — is Hyprland running?')

    runtime = os.environ.get('XDG_RUNTIME_DIR', f'/run/user/{os.getuid()}')
    socket_path = f'{runtime}/hypr/{sig}/.socket2.sock'

    initialize()

    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock.connect(socket_path)

    buf = ''
    while True:
        data = sock.recv(4096).decode('utf-8', errors='replace')
        if not data:
            break
        buf += data
        while '\n' in buf:
            line, buf = buf.split('\n', 1)
            line = line.strip()
            if '>>' not in line:
                continue

            event, payload = line.split('>>', 1)

            if event == 'activewindow':
                # payload: "class,title"
                class_name = payload.split(',', 1)[0]
                ws_id = get_active_workspace_id()
                if class_name:
                    rename_workspace(ws_id, f'{ws_id}: {get_label(class_name)}')
                else:
                    # Workspace is now empty — reset to plain number
                    rename_workspace(ws_id, str(ws_id))


if __name__ == '__main__':
    main()
