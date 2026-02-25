# AudioManager

Autoload singleton for SFX, music, and audio bus control.

## Setup

1. In **Project Settings → Autoload**, add `audio_manager.gd` with the name `AudioManager`.
2. In **Project Settings → Audio**, create two buses: `SFX` and `Music` (both routed to Master).
   - If your buses have different names, configure the `sfx_bus` and `music_bus` exports on the AutoLoad node.

## Usage

### Sound effects

```gdscript
# Play a one-shot sound (supports overlapping via internal pool)
AudioManager.play_sfx(preload("res://sounds/jump.wav"))

# Play with custom volume
AudioManager.play_sfx(preload("res://sounds/explosion.wav"), -6.0)

# Stop a specific sound early
var player = AudioManager.play_sfx(preload("res://sounds/loop.wav"))
AudioManager.stop_sfx(player)
```

### Music

```gdscript
# Play music (crossfades from any currently playing track)
AudioManager.play_music(preload("res://music/theme.ogg"))

# Play with a longer crossfade
AudioManager.play_music(preload("res://music/boss.ogg"), 2.0)

# Stop music with a fade out
AudioManager.stop_music(1.5)

# React to transitions
AudioManager.music_started.connect(func(stream): print("Now playing: ", stream))
AudioManager.music_stopped.connect(func(): print("Music stopped"))
```

### Bus control

```gdscript
# Adjust volume (in decibels)
AudioManager.set_bus_volume("Master", -10.0)
AudioManager.set_bus_volume("SFX", -5.0)
AudioManager.get_bus_volume("Music")  # returns float

# Mute/unmute
AudioManager.set_bus_muted("SFX", true)
AudioManager.is_bus_muted("Music")   # returns bool
```

## Configuration

| Export | Default | Description |
|--------|---------|-------------|
| `sfx_bus` | `"SFX"` | Audio bus name for sound effects |
| `music_bus` | `"Music"` | Audio bus name for music |
| `pool_size` | `8` | Initial number of SFX players (expands automatically) |
