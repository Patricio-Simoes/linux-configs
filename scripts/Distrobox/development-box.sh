##################################################################################
# Creates a distrobox container based on Arch Linux focused on development tools #
##################################################################################

distrobox-create --image quay.io/toolbx-images/archlinux-toolbox --name Development
distrobox-enter Development

#########################################
# Installs usefull & necessary packages #
#########################################

sudo pacman -S git
sudo pacman -S curl
sudo pacman -S neofetch

####################
# Installs Node.js #
####################

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
nvm use --lts

###################
# Starship Prompt #
###################

curl -sS https://starship.rs/install.sh | sh
