# Stereo Mix with PulseAudio

Terminologies:

* Sink - an input to the PulseAudio system. E.g. microphones
* Source - an output from the PulseAudio system. E.g. speakers
* Loopback - reroutes a source to a sink.
* Monitor - an automatically generated source from a sink.

```
    SOURCES                      SINKS
    Apps outputting sound
                                                                   mic
                                 ↓                                 ↓
        combined.monitor         combine-sink combined
```

```
MY_MIC=your-mic

## Create a null sink to act as your microphone.

```
pactl load-module module-null-sink sink_name=stereo-mix
```

## Create a loopback from your app 
