#!/bin/bash

# Colors for text formatting
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to add Kali repository
add_kali_repo() {
    sudo sh -c "echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list"
}

# Function to install GnuPG
install_gnupg() {
    sudo apt install -y gnupg
}

# Function to add the public key of Kali Linux distribution
add_kali_key() {
    wget 'https://archive.kali.org/archive-key.asc'
    sudo apt-key add archive-key.asc
}

# Function to set the correct priority for Kali Linux packages
set_kali_priority() {
    sudo sh -c "echo 'Package: *'>/etc/apt/preferences.d/kali.pref; echo 'Pin: release a=kali-rolling'>>/etc/apt/preferences.d/kali.pref; echo 'Pin-Priority: 50'>>/etc/apt/preferences.d/kali.pref"
}

# Function to install the specified package
install_package() {
    sudo apt install -y -t kali-rolling "$1"
}

# Main function to execute the script
main() {
    # Check if Kali repository is already added
    if grep -q "kali-rolling" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
        echo -e "${GREEN}Kali repository is already added.${NC}"
    else
        echo -e "${YELLOW}Adding Kali repository...${NC}"
        add_kali_repo || { echo -e "${RED}Error adding Kali repository.${NC}"; exit 1; }
        # Install GnuPG if not already installed
        if ! command -v gpg &> /dev/null; then
            echo -e "${YELLOW}Installing GnuPG...${NC}"
            install_gnupg || { echo -e "${RED}Error installing GnuPG.${NC}"; exit 1; }
        fi
        # Add the public key of Kali Linux distribution
        echo -e "${YELLOW}Adding Kali Linux public key...${NC}"
        add_kali_key || { echo -e "${RED}Error adding Kali Linux public key.${NC}"; exit 1; }
        # Set the correct priority for Kali Linux packages
        echo -e "${YELLOW}Setting priority for Kali Linux packages...${NC}"
        set_kali_priority || { echo -e "${RED}Error setting priority for Kali Linux packages.${NC}"; exit 1; }
    fi

    # Update the package lists
    echo -e "${YELLOW}Updating package lists...${NC}"
    sudo apt update || { echo -e "${RED}Error updating package lists.${NC}"; exit 1; }

    # Install the specified package
    if [ $# -eq 0 ]; then
        echo -e "${YELLOW}No package specified.${NC}"
    else
        echo -e "${YELLOW}Installing $1...${NC}"
        install_package "$1" || { echo -e "${RED}Error installing $1.${NC}"; exit 1; }
    fi
}

# Check if script is run with sudo
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}Please run this script with sudo.${NC}"
    exit 1
fi

# Call the main function with the provided package name
main "$@"
