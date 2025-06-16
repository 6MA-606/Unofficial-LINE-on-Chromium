#!/bin/bash

# === CONFIG ===
CLEAN_UP=true
EXT_ID="ophjlpahpchlmihnnnihgmmeilfjmjjc"
CHROMIUM_PROFILE="$HOME/snap/chromium/common/chromium/Default"
ICON_PATH="/usr/share/icons/hicolor/256x256/apps/line-chromium.png"
DESKTOP_FILE="/usr/share/applications/line-chromium.desktop"

if [ "$1" == "--no-clean" ]; then
    CLEAN_UP=false
    echo "⚠️ Running without cleanup. Use --no-clean to skip cleanup."
else
    echo "🔧 Running with cleanup enabled."
fi

# === Function to remove LINE extension ===
remove_line_extension() {
    if [ -d "$CHROMIUM_PROFILE/Extensions/$EXT_ID" ]; then
        echo "🧩 Removing LINE extension..."
        rm -rf "$CHROMIUM_PROFILE/Extensions/$EXT_ID"
        rm -rf "$CHROMIUM_PROFILE/Extension State/$EXT_ID"
        rm -rf "$CHROMIUM_PROFILE/Local Extension Settings/$EXT_ID"

        sed -i "/$EXT_ID/d" "$CHROMIUM_PROFILE/Preferences" 2> /dev/null
        sed -i "/$EXT_ID/d" "$CHROMIUM_PROFILE/Secure Preferences" 2> /dev/null

        echo "✅ LINE extension removed."
    else
        echo "❌ LINE extension not found."
    fi
}

# === Function to remove Chromium ===
remove_chromium() {
    if command -v chromium-stable &> /dev/null; then
        echo "🔧 Do you want to remove Chromium? (y/n)"
        read -r REMOVE_CHROMIUM
        if [[ "$REMOVE_CHROMIUM" == "y" || "$REMOVE_CHROMIUM" == "Y" ]]; then
            echo "🔧 Removing Chromium..."
            sudo apt-get remove --purge chromium-browser -y
            sudo apt-get autoremove -y
            echo "✅ Chromium removed."

            echo "🧹 Do you want to remove Chromium config files as well? (y/n)"
            read -r REMOVE_CONFIG
            if [[ "$REMOVE_CONFIG" =~ ^[yY]$ ]]; then
                rm -rf "$CONFIG_DIR"
                echo "✅ Config files removed."
            fi

        else
            echo "❌ Chromium will not be removed."
        fi
    else
        echo "❌ Chromium is not installed."
    fi
    
}

# === Check if Chromium is running and prompt to close ===
if pgrep -x "chromium" > /dev/null; then
    echo "⚠️ Chromium is running. Do you want to close it automatically? (y/n)"
    read -r CLOSE_CHROMIUM
    if [[ "$CLOSE_CHROMIUM" =~ ^[yY]$ ]]; then
        pkill -x "chromium-stable"
        sleep 1
    else
        echo "❌ Please close Chromium manually and try again."
        exit 1
    fi
fi


# === Prompt to remove LINE extension ===
echo "🧩 Do you want to remove the LINE extension from Chromium? (y/n)"
read -r REMOVE_LINE
if [[ "$REMOVE_LINE" =~ ^[yY]$ ]]; then
    remove_line_extension
else
    echo "❌ LINE extension will not be removed."
fi

# === Prompt to remove Chromium ===
remove_chromium

# === Remove .desktop file and icon ===
if [[ -f "$DESKTOP_FILE" || -f "$ICON_PATH" ]]; then
    echo "🧹 Removing .desktop shortcut and icon..."
    sudo rm -f "$DESKTOP_FILE"
    sudo rm -f "$ICON_PATH"
    echo "✅ Shortcut and icon removed."
else
    echo "❌ Shortcut or icon not found."
fi

# === Clean up any remaining files ===
if [ "$CLEAN_UP" = true ]; then
    echo "🧹 Cleaning up installation script..."
    rm -f "$0"
else
    echo "⚠️ Skipping cleanup as per user request."
fi

echo "🎉 Uninstall process completed!"
