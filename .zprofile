# Zprofile runs only on login shell, like ssh or getty 
if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
	exec startx
fi

