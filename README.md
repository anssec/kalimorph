# KaliMorph

KaliMorph is a Bash script that automates the process of adding the Kali Linux repository to your system and installing Kali tools on Debian-based distributions.

## Features

- Checks if the Kali repository is already added to your system.
- Adds the Kali repository if not already added.
- Installs GnuPG if not already installed.
- Adds the public key of the Kali Linux distribution.
- Sets the correct priority for Kali Linux packages.
- Updates the package lists.
- Installs the specified Kali tool package.

## Prerequisites

- This script is intended for Debian-based Linux distributions.
- Ensure that `wget` is installed on your system.
- Run the script with sudo privileges.

## Usage

1. Clone this repository to your local machine:

git clone https://github.com/anssec/kalimorph.git

2. Navigate to the directory containing the script:

cd kalimorph

3. Make the script executable:

chmod +x kalimorph.sh

4. Run the script with sudo, specifying the name of the Kali tool package you want to install:

sudo ./kalimorph.sh [package_name]


Replace `[package_name]` with the name of the Kali tool package you want to install.

## Example

To install the `burpsuite` package, run the following command:

sudo ./kalimorph.sh burpsuite

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
