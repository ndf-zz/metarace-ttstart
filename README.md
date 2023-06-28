# metarace-ttstart

Time trial start console application. Includes time of day,
rider number, rider name, a 30 second count-down and audible
start beeps.

![ttstart screenshot](screenshot.png "ttstart")

For battery operated terminals, the screen can be set to dim
in between starters.

## Configuration

Configuration is via metarace sysconf section 'ttstart' with the
following keys:

key           | (type) description [default]
---           | ---
topic         | (string) telegraph topic for start list updates [startlist]
fullscreen    | (boolean) run application fullscreen after initialisation
backlightdev  | (string) sysfs path to backlight device [null] (1) eg: /sys/class/backlight/acpi_video0
backlightlow  | (float) dimmed backlight level between starters [0.25]
backlighthigh | (float) backlight level during countdown [1.0]
startlist     | (string) filename for a csv startlist file [startlist.csv]
syncthresh    | (float) maximum allowed audio de-sync in seconds [0.12] (2)

Notes:

   1.  The backlight brightness file must be writable in order
       for dimming to work
   2.  The acoustic start signal is terminated if it is not playing
       in sync with the displayed countdown.

## Remote Control

ttstart connects to telegraph and subscribes to the topic nominated.
To re-configure the start list, publish a JSON encoded array of arrays
with the following columns:

   - start time (string), required
   - rider number (string), optional
   - rider series (string), ignored
   - rider name (string), optional

For example:

	[["9h15:00","","","[Event Start]"], ["9h16:00","1","","First RIDER"]]


## Requirements

   - Python >= 3.9
   - Gtk >= 3.0
   - metarace >= 2.1.1
   - tex-gyre fonts
   - gstreamer alsa plugins

Note: Some 32 bit systems (notably Intel Atom Toughbooks) will not
play audio with the default Debian desktop installation.
The workaround is to remove pulseaudio and use alsa directly:

	$ sudo apt remove 'pulseaudio*'

## Installation

### Debian 11+

Install system requirements for ttstart and metarace with apt:

	$ sudo apt install python3-venv python3-pip python3-cairo python3-gi python3-gi-cairo
	$ sudo apt install gir1.2-gtk-3.0 gir1.2-rsvg-2.0 gir1.2-pango-1.0 gir1.2-gstreamer-1.0 gstreamer1.0-alsa tex-gyre
	$ sudo apt install python3-serial python3-paho-mqtt python3-dateutil python3-xlwt

If not already created, add a virtualenv for metarace packages:

	$ mkdir -p ~/Documents/metarace
	$ python3 -m venv --system-site-packages ~/Documents/metarace/venv

Activate the virtualenv and install ttstart with pip:

	$ source ~/Documents/metarace/venv/bin/activate
	(venv) $ pip3 install metarace-ttstart

