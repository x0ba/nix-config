#!/usr/bin/env sh

sketchybar --add item clock right \
	--set clock update_freq=1 \
	icon.padding_left=0 \
	icon.color="$WHITE" \
	label.color=$WHITE \
	label.padding_right=0 \
	label.width=58 \
	align=center \
	script="$PLUGIN_DIR/clock.sh" \
	background.height=26 \
	background.color=$BLACK \
	background.corner_radius=$CORNER_RADIUS \
	background.padding_right=2
