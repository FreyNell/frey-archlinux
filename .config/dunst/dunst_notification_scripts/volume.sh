#!/bin/bash

function send_notification() {
	current_volume=$(pamixer --get-volume-human)
	case $current_volume in
	muted)
		dunstify -a "pamixer" -u low -r 9993 -h int:value:"$current_volume" "Volume: Muted" -t 2000
		;;
	*)
		dunstify -a "pamixer" -u low -r 9993 -h int:value:"$current_volume" "Volume: ${current_volume}" -t 2000
		;;
	esac
	
}

send_notification
