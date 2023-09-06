############################
# Installs useful Packages #
############################

sudo apt install curl -y
sudo apt install distrobox -y
sudo apt install gcolor3 -y
sudo apt install gedit -y
sudo apt install gimp -y
sudo apt install git -y
sudo apt install gnome-shell-extension-manager -y
sudo apt install gufw -y
sudo apt install keepassxc -y
sudo apt install libavcodec-extra -y
sudo apt install neofetch -y
sudo apt install rofi -y
sudo apt install timeshift -y
sudo apt install vlc -y
sudo apt install zip -y

##############
# QEMU Setup #
##############

sudo apt install qemu-kvm -y
sudo apt install qemu-system -y
sudo apt install qemu-utils -y
sudo apt install python3 -y
sudo apt install python3-pip -y
sudo apt install libvirt-clients -y
sudo apt install libvirt-daemon-system -y
sudo apt install bridge-utils -y
sudo apt install virtinst -y
sudo apt install libvirt-daemon -y
sudo apt install virt-manager -y

sudo virsh net-start default
sudo virsh net-autostart default

sudo usermod -aG libvirt $USER
sudo usermod -aG libvirt-qemu $USER
sudo usermod -aG kvm $USER
sudo usermod -aG input $USER
sudo usermod -aG disk $USER

###################
# Microsoft Fonts #
###################

sudo apt install ttf-mscorefonts-installer -y
sudo apt install fonts-roboto -y

################
# Starship CLI #
################

curl -sS https://starship.rs/install.sh | sh

sudo apt update && sudo apt upgrade
