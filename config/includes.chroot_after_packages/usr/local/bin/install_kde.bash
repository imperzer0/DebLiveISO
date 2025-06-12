#!/bin/bash

# Install SUDO
sudo apt install sudo

### Configure APT ###  <-- sometimes breaks the system, so commented out

# # Mozilla
# sudo install -d -m 0755 /etc/apt/keyrings
# wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc
# echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list
# echo $(cat <<EOF
# Package: *
# Pin: origin packages.mozilla.org
# Pin-Priority: 1000
# EOF
# ) | sudo tee /etc/apt/preferences.d/mozilla 

# # Sublime Text
# wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc
# echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources

### Update the System ###
sudo apt update -y && sudo apt upgrade -y

### Install Package List ###
sudo apt install $(cat <<EOF
util-linux bash-completion vim gpg wget git curl arch-install-scripts
coreutils htop nmap nmap-common ncat openssh-client
cmake g++ gcc

gparted filelight
network-manager

sublime-text

sddm
kde-plasma-desktop
ark gwenview speedcrunch kde-spectacle okular plasma-dataengines-addons plasma-pa
plasma-runners-addons plasma-wallpapers-addons plasma-widgets-addons polkit-kde-agent-1
sweeper plasma-nm

pavucontrol vlc gimp inkscape 

firefox

inxi cups fontforge fonts-noto fonts-cascadia-code
EOF
)