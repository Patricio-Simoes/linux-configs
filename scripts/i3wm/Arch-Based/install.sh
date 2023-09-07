############
# Packages #
############
sudo pacman -S code
sudo pacman -S chromium
sudo pacman -S filezilla
sudo pacman -S gimp
sudo pacman -S gufw
sudo pacman -S keepassxc
sudo pacman -S neofetch
sudo pacman -S veracrypt

#########
# Fonts #
#########

sudo pacman -S ttf-fira-code
sudo pacman -S ttf-firacode-nerd
sudo pacman -S ttf-roboto
sudo pacman -S ttf-roboto-mono
sudo pacman -S ttf-roboto-mono-nerd

##########
# Gaming #
##########

sudo pacman -S --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
sudo pacman -S steam

##################
#Flatpak support #
##################

sudo pacman -S flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

############
# Starship #
############

curl -sS https://starship.rs/install.sh | sh
