# LINE on Chromium (Unofficial) – Linux Desktop

<div align="center">
  <img src="https://raw.githubusercontent.com/6MA-606/Unofficial-LINE-on-Chromium/main/assets/line-chromium.png" alt="LINE on Chromium" width="300"/>
</div>

## 📌 Overview

**LINE on Chromium** is an **unofficial helper script** that sets up the **official LINE Web extension** (available from LINE Corporation) to work in Chromium-based browsers — specifically [Chromium](https://www.chromium.org/chromium-projects/) — and presents it in a way that mimics the look and feel of the LINE desktop app for Windows.

This project does **not** modify or repackage the LINE extension. It simply installs the extension in a compatible way and adds a launcher to integrate it into the Linux desktop experience.

⚠️ **This project is not affiliated with or endorsed by LINE Corporation.**  
It uses publicly available and unmodified components to enhance user convenience on Linux.

**Note:** If LINE Corporation ever releases an official Linux version of the LINE desktop app, this helper project will be removed immediately.

---

## ✅ Features

- Uses the **official LINE Web extension** from LINE Corporation
- Integrates it into Chromium with a desktop launcher and app icon
- Provides a native-like experience on Debian-based Linux distributions (e.g., Ubuntu)

---

## 🚀 Installation

Run the following commands in your terminal:

```bash
curl -sSL -o install.sh https://raw.githubusercontent.com/6MA-606/Unofficial-LINE-on-Chromium/refs/heads/main/install.sh && \
chmod +x install.sh && \
./install.sh
```

This will:
- Download and install the Chromium browser (if not already installed)
- Download and install the LINE Web extension into Chromium (if not already installed)
- Create a desktop shortcut and app icon for easier access

---

## 🧹 Uninstallation

To remove everything:

```bash
curl -sSL -o uninstall.sh https://raw.githubusercontent.com/6MA-606/Unofficial-LINE-on-Chromium/refs/heads/main/uninstall.sh && \
chmod +x uninstall.sh && \
./uninstall.sh
```

You’ll be prompted whether to remove:

- The LINE extension from Chromium (optional)  
- The Chromium browser itself (optional)  
- The shortcut and icon files  

---

## 📎 Disclaimer

This is an **independent, unofficial helper project** created for personal and educational use only.  
All trademarks, logos, and the LINE Web extension itself are the property of **LINE Corporation**.  
No part of the original LINE extension is modified or redistributed.
