#!/bin/sh

# Note:
# This is the code you paste into your own repository!

PACTUM_INSTALLER_REPO="https://github.com/chrisrabe/pactum-installer.git"
PACTUM_INSTALLER_DIR="./pactum-installer"
INSTALL_SCRIPT="install-pactum.sh"

git clone "${PACTUM_INSTALLER_REPO}"
mv "${PACTUM_INSTALLER_DIR}/${INSTALL_SCRIPT}" .

chmod +x "./${INSTALL_SCRIPT}"

# Run the installer
./${INSTALL_SCRIPT}

# Clean up everything
rm -rf "./${INSTALL_SCRIPT}"
rm -rf "${PACTUM_INSTALLER_DIR}"
