#!/bin/sh

MODE="$1"  
SCREENSHOT_DIR=~/Pictures/Screenshots
NAME="screenshot-$(date +%Y%m%d-%H%M%S).png"

mkdir -p "$SCREENSHOT_DIR"

if [ "$MODE" = "window" ]; then  
    grim $SCREENSHOT_DIR/$NAME && \
    exec notify-send -i $SCREENSHOT_DIR/$NAME "Screenshot saved"
elif [ "$MODE" = "selection" ]; then  
    grim -g "$(slurp)" $SCREENSHOT_DIR/$NAME \
    && exec notify-send -i $SCREENSHOT_DIR/$NAME "Screenshot saved"
fi
