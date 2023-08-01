##################################################################
# Creates a Fedora 38 distrobox container focused on development #
##################################################################

distrobox-create --image fedora:38 development
distrobox-enter development

#########################################
# Installs usefull & necessary packages #
#########################################

sudo dnf install curl -y
sudo dnf install chromium -y
sudo dnf install git -y
sudo dnf install neofetch -y

###########
# Node.js #
###########

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
nvm use --lts

#############
# VS Codium #
#############

sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo dnf install codium -y

###################
# Starship Prompt #
###################

curl -sS https://starship.rs/install.sh | sh

#######################################################
# Exports installed app paths to the host environment #
#######################################################

distrobox-export --app codium
