# CC-Chime

A Claude Code plugin that plays a notification chime when Claude finishes responding.

## Features

- Plays an audio notification when Claude Code completes a response
- Cross-platform support (Windows, macOS, Linux)
- Lightweight with no external dependencies

## How It Works

The plugin uses the `Stop` hook event which fires whenever Claude Code finishes generating a response. When triggered, it plays a system sound appropriate for your platform:

- **Windows**: Uses PowerShell to play the Windows "Asterisk" system sound
- **macOS**: Plays the "Glass" system sound using `afplay`
- **Linux**: Tries PulseAudio (`paplay`), ALSA, or canberra-gtk-play

## Installation

### From Local Development

1. Add the plugin as a local marketplace:
   ```
   /plugin marketplace add C:\Users\faisa\Ai\CCChime
   ```

2. Install the plugin:
   ```
   /plugin install cc-chime@cc-chime-dev
   ```

3. Restart Claude Code to activate the hooks.

### From GitHub (after publishing)

1. Add the marketplace:
   ```
   /plugin marketplace add your-username/cc-chime
   ```

2. Install:
   ```
   /plugin install cc-chime@your-marketplace
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

To change the sound, edit `hooks/chime.sh`:

### Windows Custom Sound
Replace the PowerShell command with:
```powershell
powershell.exe -NoProfile -Command "(New-Object Media.SoundPlayer 'C:\path\to\sound.wav').PlaySync()"
```

Available system sounds:
- `[System.Media.SystemSounds]::Asterisk.Play()`
- `[System.Media.SystemSounds]::Beep.Play()`
- `[System.Media.SystemSounds]::Exclamation.Play()`
- `[System.Media.SystemSounds]::Hand.Play()`
- `[System.Media.SystemSounds]::Question.Play()`

### macOS Custom Sound
Replace `Glass.aiff` with any sound file:
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
