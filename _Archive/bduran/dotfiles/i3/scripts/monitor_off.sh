#!/usr/bin/env sh

# Set DPMS to turn off the display
xset dpms force off

# Get the ID of the mouse device
MOUSE_ID=9

# Function to check for mouse movement
check_mouse_move() {
    # Get the current position of the mouse
    xinput --query-state "$MOUSE_ID" | grep "valuator\[0\]" | awk '{print $3}'
}

# Get the initial mouse position
initial_position=$(check_mouse_move)

# Loop until mouse movement is detected
while true; do
    current_position=$(check_mouse_move)

    # If the mouse has moved, break the loop and exit
    if [ "$current_position" != "$initial_position" ]; then
        break
    fi

    # Sleep briefly to avoid CPU overuse
    sleep 0.5
done
