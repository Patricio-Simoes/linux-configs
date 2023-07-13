#!/bin/bash

# Install any missing necessary packages
sudo apt install xorg lightdm slick-greeter lightdm-settings lxappearance nitrogen pulseaudio alsa-utils pavucontrol picom

# Install the apps used in the keybindings
sudo apt install chromium alacritty

# Install fonts
./fonts/install.sh

# Move fontawesome fonts
sudo mv ./font-awesome-4.7.0/* /usr/share/fonts/opentype/font-awesome/

# Copy wallpapers to the share folder
sudo cp ./wallpapers/wallpaper-login.jpg /usr/share/images/
sudo cp ./wallpapers/wallpaper-main.jpg /usr/share/images/

# Copy theme & icons to the share folder
sudo cp -r ./themes/Nordic-darker-v40/ /usr/share/icons/
sudo cp -r ./icons/Nordzy-dark/ /usr/share/themes/

# Remove any i3wm files already present
rm -rf ~/.config/i3

# Move the files from this folder to i3's folder
sudo mkdir ~/.config/i3/
sudo mv ./bumblebee-status ~/.config/i3/
sudo mv ./config ~/.config/i3/
sudo mv ./i3status.conf ~/.config/i3/