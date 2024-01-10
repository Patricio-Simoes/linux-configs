##################################
# Adds Flatpak Support to Debian #
##################################

sudo apt install flatpak -y

# Uncomment for Gnome software plugin.
#sudo apt install gnome-software-plugin-flatpak -y

flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

# Installs all the necessary flatpak packages

flatpak install --user flathub org.mozilla.firefox
flatpak install --user flathub org.mozilla.Thunderbird
flatpak install --user flathub com.github.tchx84.Flatseal
flatpak install --user flathub io.freetubeapp.FreeTube
flatpak install --user flathub org.onlyoffice.desktopeditors
flatpak install --user flathub md.obsidian.Obsidian
flatpak install --user flathub com.usebottles.bottles
flatpak install --user flathub com.valvesoftware.Steam
