# Stereo Mix with PulseAudio

Terminologies:

* Sink - an input to the PulseAudio system.
* Source - an output from the PulseAudio system.
* Loopback - reroutes a source to a sink.
* Monitor - an automatically generated source from a sink.

## Create a null sink

You can create a null sink named `null-collector` using:

```sh
pactl load-module module-null-sink sink_name=null-collector
```

## 
