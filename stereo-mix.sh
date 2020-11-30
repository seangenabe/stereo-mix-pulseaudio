#!/usr/bin/env bash

if [ -z "$@" ]
then
  echo "Warning: No output sinks specified. Combined sink will only output to stereo mix. Run `pactl list short sinks` to show available sinks."
fi

function join() {
  local IFS="$1"
  shift
  echo "$*"
}

echo "Setting up stereo-mix"
STEREO_MIX=$(pactl load-module module-null-sink sink_name=stereo-mix)
pacmd 'update-sink-proplist stereo-mix device.description="(Stereo Mix sink)"'
pacmd 'update-source-proplist stereo-mix.monitor device.description="Stereo Mix"'

echo "Setting up stereo-mix-loopback"
LOOPBACK=$(pactl load-module module-loopback sink=stereo-mix)

# Sink that will output to both Stereo Mix and speakers
echo "Setting up combined"
COMBINED=$(pactl load-module module-combine sink_name=combined slaves=$(join , stereo-mix $@))
pacmd 'update-sink-proplist combined device.description="Apps output to Stereo Mix and output devices"'

trap cleanup SIGINT

function cleanup() {
  pactl unload-module $STEREO_MIX
  pactl unload-module $COMBINED
  pactl unload-module $LOOPBACK
  exit 0
}

echo "Setup complete. Ctrl+C to cleanup"

while :
do
  sleep 10000
done
