# Stereo Mix with PulseAudio

## Usage

```sh
stereo-mix.sh
stereo-mix.sh output.analog-stereo
```

## How to set up

1. Run the command, passing your desired hardware output device sink. Multiple sinks can be passed. To check available sinks, run `pactl list short sinks`.
2. Set up your playback apps to output to "Apps output to Stereo Mix and output devices".
3. Set up your recording apps to input from "Stereo Mix".
