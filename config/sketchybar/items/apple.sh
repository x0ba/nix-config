#!/usr/bin/env sh

POPUP_OFF="sketchybar --set apple.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar --add item apple.logo left \
    --set apple.logo icon="" \
    icon.font="$FONT:Black:16.0" \
    icon.color=$BLUE \
    icon.padding_left=10 \
    icon.padding_right=0 \
    background.padding_left=-1 \
    background.padding_right=17 \
    background.height=26 \
    background.corner_radius=$CORNER_RADIUS \
    label.drawing=off \
    click_script="$POPUP_CLICK_SCRIPT" \
    \
    --add item apple.prefs popup.apple.logo \
    --set apple.prefs icon="" \
    label="Preferences" \
    click_script="open -a 'System Preferences';
                                            $POPUP_OFF" \
    \
    --add item apple.activity popup.apple.logo \
    --set apple.activity icon="" \
    label="Activity" \
    click_script="open -a 'Activity Monitor';
                                            $POPUP_OFF" \
    \
    --add item apple.lock popup.apple.logo \
    --set apple.lock icon="" \
    label="Lock Screen" \
    click_script="pmset displaysleepnow;
                                            $POPUP_OFF"
