# frey-archlinux
Scripts and customization things

## ZSH THEME
Don't forget to add \$(battery_pct_prompt) to load battery percentage to shell

#CONTROL CHARGING:
echo 60  > /sys/class/power_supply/BAT0/charge_control_end_threshold
