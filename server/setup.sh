#!/bin/bash
# Setup script for lofi-stream-odysee on VPS

set -e

echo "Setting up lofi-stream-odysee..."

# Install dependencies
echo "Installing dependencies..."
apt-get update
apt-get install -y xvfb chromium-browser ffmpeg pulseaudio xdotool curl jq

# Create directory
echo "Creating /opt/lofi-stream-odysee..."
mkdir -p /opt/lofi-stream-odysee

# Copy scripts
echo "Copying scripts..."
cp stream.sh /opt/lofi-stream-odysee/
cp health-check.sh /opt/lofi-stream-odysee/
chmod +x /opt/lofi-stream-odysee/*.sh

# Install systemd service
echo "Installing systemd service..."
cp lofi-stream-odysee.service /etc/systemd/system/
systemctl daemon-reload

echo ""
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit /etc/systemd/system/lofi-stream-odysee.service"
echo "   Change: Environment=ODYSEE_KEY=YOUR_STREAM_KEY_HERE"
echo ""
echo "2. Get your Odysee stream key from:"
echo "   https://odysee.com -> Go Live -> Stream Setup"
echo ""
echo "3. Enable and start the service:"
echo "   systemctl enable lofi-stream-odysee"
echo "   systemctl start lofi-stream-odysee"
echo ""
echo "4. Check status:"
echo "   systemctl status lofi-stream-odysee"
echo "   journalctl -u lofi-stream-odysee -f"
