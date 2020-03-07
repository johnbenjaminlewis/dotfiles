TOUCHPAD=$(xinput list | grep -oP '\w[\w\d\s:]+?Touchpad')
TOUCHPAD_ID=$(xinput list --id-only $TOUCHPAD)
xinput set-prop $TOUCHPAD_ID "libinput Accel Speed" .8
xinput set-prop $TOUCHPAD_ID "libinput Natural Scrolling Enabled" 1
xinput set-prop $TOUCHPAD_ID "libinput Tapping Enabled" 1
xinput set-prop $TOUCHPAD_ID "libinput Tapping Drag Lock Enabled" 1
