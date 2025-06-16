#!/bin/bash

# === CONFIG ===
CLEAN_UP=true
EXT_ID="ophjlpahpchlmihnnnihgmmeilfjmjjc"
EXT_PATH="$HOME/snap/chromium/common/chromium/Default/Extensions/$EXT_ID"
ICON_URL="https://raw.githubusercontent.com/6MA-606/Unofficial-LINE-on-Chromium/main/assets/line-chromium.png"
ICON_PATH="/usr/share/icons/hicolor/256x256/apps/line-chromium.png"
DESKTOP_FILE="/usr/share/applications/line-chromium.desktop"
LAUNCH_CMD="chromium --app=\"chrome-extension://$EXT_ID/index.html\" --window-size=800,600 --window-position=100,100"

# === Check for root privileges ===
if [ "$1" == "--no-clean" ]; then
    CLEAN_UP=false
    echo "⚠️ Running without cleanup. Use --no-clean to skip cleanup."
else
    echo "🔧 Running with cleanup enabled."
fi

# === Install Chromium if not present ===
if ! command -v chromium-stable &> /dev/null; then
    echo "🔧 Installing Chromium..."
    sudo apt-get update
    sudo apt-get install -y wget chromium-browser
    echo "✅ Chromium installed."
else
    echo "✅ Chromium already installed."
fi

# === Launch Chromium to install LINE extension ===
if [ ! -d "$EXT_PATH" ]; then
    echo "🧩 Launching Chromium to install LINE extension..."
    chromium "https://chrome.google.com/webstore/detail/line/$EXT_ID" --window-size=800,600 &> /dev/null &
    echo "⌛ Please install the LINE extension manually. Waiting for it to appear..."

    while [ ! -d "$EXT_PATH" ]; do
        sleep 5
        echo "🕒 Still waiting for LINE extension..."
    done

    echo "✅ LINE extension installed."
else
    echo "✅ LINE extension already installed."
fi

# === Create .desktop icon ===
echo "📝 Creating launcher shortcut..."

# === Download icon from GitHub ===
echo "🎨 Downloading icon from GitHub..."
TEMP_ICON="/tmp/line-chromium.png"
wget -qO "$TEMP_ICON" "$ICON_URL"
if [ -f "$TEMP_ICON" ]; then
    sudo mkdir -p "$(dirname "$ICON_PATH")"
    sudo mv "$TEMP_ICON" "$ICON_PATH"
    echo "✅ Icon downloaded and moved successfully."
else
    echo "❌ Failed to download icon, creating placeholder icon..."
    convert -size 256x256 xc:lightblue -gravity center -pointsize 32 -annotate 0 "LINE" "$TEMP_ICON"
    sudo mkdir -p "$(dirname "$ICON_PATH")"
    sudo mv "$TEMP_ICON" "$ICON_PATH"
fi

# === Write .desktop file ===
sudo tee "$DESKTOP_FILE" > /dev/null <<EOL
[Desktop Entry]
Name=LINE on Chromium
Comment=Open LINE Chat Extension on Chromium
Exec=$LAUNCH_CMD
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Utility;
StartupWMClass=Chromium
EOL

echo "✅ Launcher shortcut created."

# === Clean up ===
if [ "$CLEAN_UP" = true ]; then
    echo "🧹 Cleaning up installation script..."
    rm -f "$0"
else
    echo "🧹 Skipping cleanup as per user request."
fi

sudo chmod +x "$DESKTOP_FILE"
sudo update-desktop-database /usr/share/applications/

echo "🎉 Launcher created: You can now open LINE on Chromium via your app menu!"
