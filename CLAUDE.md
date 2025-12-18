# lofi-stream-odysee

24/7 lofi stream to Odysee with an underwater/deep sea theme.

## Secrets

```bash
# Stream key and RTMP URL
cat ~/api-secrets/lofi-stream/platforms/odysee.env

# SSH key for servers
~/api-secrets/hetzner-server/id_ed25519
```

## Quick Reference

```bash
# Local development - open in browser
cd docs && python3 -m http.server 8080

# Deploy to dev server for testing
make deploy-dev

# Check production status
ssh root@135.181.150.82 'systemctl status lofi-stream-odysee'
```

## Architecture

```
GitHub Pages (static HTML/CSS/JS)
        ↓ (rendered by)
Chromium on Hetzner VPS (:94)
        ↓ (captured by)
FFmpeg → RTMP → Odysee
```

## Theme: Deep Sea / Underwater

Visual elements:
- Deep ocean gradient background with light rays from above
- Rising bubbles of various sizes
- Submarine porthole window with metal frame
- Swimming fish (multiple colors/sizes)
- Floating jellyfish with animated tentacles
- Coral branches and swaying seaweed
- Bioluminescent glowing orbs
- Depth gauge display with waveform

Color palette:
- Deep ocean: #001520, #002030, #000810
- Water blue: #003050, #00aaff
- Bioluminescent: #00ffcc, #ff66cc
- Coral: #ff6666, #ff9966
- Seaweed green: #33cc66, #009933

## Audio: Deep Sea Ambient Lofi

- Filtered noise for underwater ambience
- Deep bass drone (pressure effect)
- Minor key ethereal pads with slow swell
- Whale song-like frequency sweeps
- Sonar ping sounds
- Bubble sound effects
- Occasional metal creaking (submarine hull)

## Server Configuration

| Setting | Value |
|---------|-------|
| Display | :94 |
| Audio Sink | odysee_speaker |
| User Data Dir | /tmp/chromium-odysee |
| RTMP URL | rtmp://stream.odysee.com/live |
| Video Bitrate | 3500 kbps |
| Audio Bitrate | 160 kbps |
| Resolution | 1280x720 @ 30fps |

## File Structure

```
lofi-stream-odysee/
├── CLAUDE.md           # This file
├── README.md           # Public readme
├── Makefile            # Dev server deployment
├── docs/
│   ├── index.html      # Underwater visuals + Web Audio
│   └── style.css       # Deep sea styling
└── server/
    ├── stream.sh       # Main streaming script
    ├── setup.sh        # Server setup automation
    ├── health-check.sh # Monitoring script
    └── lofi-stream-odysee.service # systemd unit
```

## Deployment

### First-time setup on production server:

```bash
# On VPS (135.181.150.82)
cd /opt
git clone https://github.com/ldraney/lofi-stream-odysee.git
cd lofi-stream-odysee/server
chmod +x *.sh
./setup.sh

# Edit service file to add stream key
sudo nano /etc/systemd/system/lofi-stream-odysee.service
# Change: Environment=ODYSEE_KEY=YOUR_STREAM_KEY_HERE

# Start the service
sudo systemctl daemon-reload
sudo systemctl enable lofi-stream-odysee
sudo systemctl start lofi-stream-odysee
```

### Get Odysee Stream Key:

1. Go to https://odysee.com
2. Click "Go Live" or find livestream settings
3. Copy the Stream Key

## Odysee Platform Notes

- Decentralized platform (LBRY blockchain)
- Revenue: LBC cryptocurrency + tips
- No censorship, freedom-focused
- 24/7 streaming: Fully supported
- Good for YouTube alternative audience

## Troubleshooting

### No audio in stream
- Check if PulseAudio sink exists: `pactl list sinks | grep odysee`
- Verify Chromium audio routing: `pactl list sink-inputs`
- Ensure PULSE_SERVER is exported in stream.sh

### Stream not connecting
- Odysee uses standard RTMP (not RTMPS)
- Verify stream key is correct
- Check Odysee dashboard for any account issues

### Video quality issues
- Odysee supports reasonable bitrates - 3500 kbps should work well
- Check CPU usage: `htop`
- Verify ffmpeg is using hardware acceleration if available

## Related Repos

- [lofi-stream-youtube](https://github.com/ldraney/lofi-stream-youtube) - Night city theme
- [lofi-stream-twitch](https://github.com/ldraney/lofi-stream-twitch) - Coffee shop theme
- [lofi-stream-kick](https://github.com/ldraney/lofi-stream-kick) - Arcade theme
- [lofi-stream-dlive](https://github.com/ldraney/lofi-stream-dlive) - Space station theme
- [lofi-stream-docs](https://github.com/ldraney/lofi-stream-docs) - Documentation hub
