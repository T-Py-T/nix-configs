#!/usr/bin/env sh

# Volume retrieval
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)"%"}')
mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep "MUTED")

# Bluetooth battery retrieval
device_info=$(upower -i $(upower -e | grep headset))
battery_level=$(echo "$device_info" | grep "percentage:" | awk '{print $2}')

# Determine what to display based on the mute status and Bluetooth connection
if [ ! -z "$mute" ]; then
  volume_display="VOL:  muted"
else
  volume_display="VOL:  $volume"
fi

# Append Bluetooth battery level if available
if [ ! -z "$battery_level" ]; then
  echo "$volume_display - 🎧 $battery_level"
else
  echo "$volume_display"
fi
e_display"
fi
