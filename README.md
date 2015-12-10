# cubie-led-party
Small handler for Cubieboard's built-in LEDs

Usage: cubie-led-party.sh [OPTIONS]

All available arguments are optional and can be combined
  -random			use available leds randomly
  -nuts				make led status (on/off) random
  -on					turn on available leds and quit
  -off				turn off available leds and quit
  -slow				use a slow speed between actions
  -fast				use a fast speed between actions
  -fastest		use the fastest speed between actions
  -led=VALUE	add this led to the available leds list

Available leds are:
  - blue
  - green
  - orange
  - white
