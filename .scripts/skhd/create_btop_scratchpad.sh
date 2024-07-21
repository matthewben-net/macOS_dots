#/bin/sh

# Launch iterm with my custom btop-monitor profile
osascript -e 'tell application "iTerm"' -e 'create window with profile "scratchpad"' -e 'end tell'

# query yabai to figure out the id of that newly created window
btop_id=$(yabai -m query --windows app,id,title | jq -r '.[] | select(.title | contains("scratchpad")) | select(.app == "iTerm2") | .id')

# set the scratchpad to the found window id and make it be floating
yabai -m window $btop_id --scratchpad btop_monitor --grid 11:11:1:1:9:9
