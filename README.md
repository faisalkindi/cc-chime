# CC-Chime

A Claude Code plugin that plays a notification chime when Claude finishes responding.

## Features

- Plays an audio notification when Claude Code completes a response
- Cross-platform support (Windows, macOS, Linux)
- Lightweight with no external dependencies

## How It Works

The plugin uses the `Stop` hook event which fires whenever Claude Code finishes generating a response. When triggered, it plays an audio notification:

- **Windows**: Plays a custom sound (`sounds/lock.wav`) via PowerShell
- **macOS**: Plays the "Glass" system sound using `afplay`
- **Linux**: Tries PulseAudio (`paplay`), ALSA, or canberra-gtk-play

## Installation

1. Add the marketplace:
   ```
   /plugin marketplace add faisalkindi/cc-chime
   ```

2. Install:
   ```
   /plugin install cc-chime@cc-chime
   ```

## Requirements

### Windows
- Git for Windows (provides bash.exe for running shell scripts)
- Default installation expected at `C:\Program Files\Git\bin\bash.exe`

### macOS
- No additional requirements (uses built-in `afplay`)

### Linux
- PulseAudio (`paplay`) or ALSA (`aplay`) for audio playback

## Customization

### Replacing the Sound File

The easiest way to customize is to replace `sounds/lock.wav` with your own `.wav` file (keep the same filename).

### Using a Different Path

Edit `hooks/chime.sh` to point to a different sound file or use system sounds:

**Windows - Custom path:**
```powershell
powershell.exe -NoProfile -Command "(New-Object Media.SoundPlayer 'C:\path\to\sound.wav').PlaySync()"
```

**Windows - System sounds:**
- `[System.Media.SystemSounds]::Asterisk.Play()`
- `[System.Media.SystemSounds]::Beep.Play()`
- `[System.Media.SystemSounds]::Exclamation.Play()`
- `[System.Media.SystemSounds]::Hand.Play()`
- `[System.Media.SystemSounds]::Question.Play()`

**macOS - Custom sound:**
```bash
afplay "/path/to/your/sound.aiff"
```

## Uninstalling

```
/plugin uninstall cc-chime@cc-chime-dev
```

## Troubleshooting

### No sound on Windows
- Ensure Git for Windows is installed
- Check that `C:\Program Files\Git\bin\bash.exe` exists
- Try running the script manually in Git Bash

### No sound on Linux
- Install PulseAudio: `sudo apt install pulseaudio-utils`
- Or use ALSA: `sudo apt install alsa-utils`

## License

MIT
