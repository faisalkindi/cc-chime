#!/bin/bash
# chime.sh - Play a notification chime when Claude Code finishes
# Cross-platform support: Windows (via Git Bash), macOS, Linux

play_chime() {
    case "$(uname -s)" in
        MINGW*|MSYS*|CYGWIN*)
            # Windows (Git Bash/MSYS2/Cygwin)
            # Use PowerShell to play Windows system sound
            powershell.exe -NoProfile -Command "[System.Media.SystemSounds]::Asterisk.Play()" 2>/dev/null
            ;;
        Darwin)
            # macOS
            if [ -f "/System/Library/Sounds/Glass.aiff" ]; then
                afplay "/System/Library/Sounds/Glass.aiff" 2>/dev/null &
            else
                # Fallback: use say command for audio feedback
                say "done" 2>/dev/null &
            fi
            ;;
        Linux)
            # Linux - try various audio players
            if command -v paplay >/dev/null 2>&1; then
                # PulseAudio
                paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null &
            elif command -v aplay >/dev/null 2>&1; then
                # ALSA - generate a simple beep
                ( speaker-test -t sine -f 800 -l 1 2>/dev/null & sleep 0.2 && kill $! 2>/dev/null ) &
            elif command -v canberra-gtk-play >/dev/null 2>&1; then
                canberra-gtk-play -i complete 2>/dev/null &
            else
                # Terminal bell as last resort
                printf '\a'
            fi
            ;;
        *)
            # Unknown OS - try terminal bell
            printf '\a'
            ;;
    esac
}

# Run the chime
play_chime

exit 0
