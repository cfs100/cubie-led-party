#!/bin/bash

LEDS=""
RAND=0
NUTS=0
LOOP=1
ECHO=0
TIME=0.1

for arg in $@; do
	case "$arg" in
		"-random")	RAND=1 ;;
		"-nuts")	NUTS=1 ;;
		"-on")		LOOP=0
				ECHO=1 ;;
		"-off")		LOOP=0 ;;
		"-slow")	TIME=0.2 ;;
		"-fast")	TIME=0.05 ;;
		"-fastest")	TIME=0.025 ;;
		"-led="*)
			LEDS+="$(echo $arg | sed 's/-led=//') "
			;;
		*)
			echo "Usage: $0 [OPTIONS]"
			echo "Small handler for Cubieboard's built-in LEDs"
			echo
			echo "All available arguments are optional and can be combined"
			echo "  -random	use available leds randomly"
			echo "  -nuts		make led status (on/off) random"
			echo "  -on		turn on available leds and quit"
			echo "  -off		turn off available leds and quit"
			echo "  -slow		use a slow speed between actions"
			echo "  -fast		use a fast speed between actions"
			echo "  -fastest	use the fastest speed between actions"
			echo "  -led=VALUE	add this led to the available leds list"
			echo
			echo "Available leds are:"
			for color in $(ls /sys/class/leds/ | sed 's/:.*//'); do
				echo "  - $color"
			done
			exit 1
			;;
	esac
done

[[ "$LEDS" = "" ]] && LEDS="1 2 3 4"


function led {
	echo $2 > $(find /sys/class/leds/ -type l \( -name "*$1" -o -name "$1*" \))/brightness
}

while :; do
	[[ $RAND = 1 ]] && LEDS=$(shuf -e $LEDS)
	[[ $NUTS = 1 && $LOOP = 1 ]] && ECHO=$(shuf -e 0 1)

	for LED in $LEDS; do
		led $LED $ECHO
		sleep $TIME
	done

	if [ "$ECHO" = "1" ]; then ECHO=0; else ECHO=1; fi

	[[ $LOOP = 1 ]] || break
done
