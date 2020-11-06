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

# Create a null source to act as your microphone.
pactl load-module module-null-source source_name=virtual-mic
pacmd 'update-source-proplist virtual-mic device.description="Virtual Mic Stereo Mix"'

# Create a null sink to act as your default output.
pactl load-module module-null-sink sink_name=app-sink sink_properties='device.description="App Sink"'
pacmd 'update-sink-proplist app-sink device.description="App Sink"'

# Create an app loopback.
pactl load-module module-loopback name=app-loopback sink=app-sink

# Create a combined sink from your mic and `app-sink`
pactl load-module module-combine-sink sink_name=combined slaves=app-sink,$MY_MIC sink_properties=device.description=Combined

# Pipe `combined` to `combined-source`
pactl load-module module-loopback source=combined.monitor sink=combined-source
```

