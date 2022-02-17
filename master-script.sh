#!/bin/sh

# Note:
# This is the code you paste into your own repository!

SERVICES="$1"

if [ -z "${SERVICES}" ]
then
  echo "\033[1;31mServices must be provided (comma separated, no spaces)\033[0m"
  echo "\033[1;31mUsage: ./add-pactum.sh \"service1,service2,service3\"\033[0m"
  exit 1
fi

PACTUM_INSTALLER_REPO="https://github.com/chrisrabe/pactum-installer.git"
PACTUM_INSTALLER_DIR="./pactum-installer"
INSTALL_SCRIPT="install-pactum.sh"

git clone "${PACTUM_INSTALLER_REPO}"
mv "${PACTUM_INSTALLER_DIR}/${INSTALL_SCRIPT}" .

chmod +x "./${INSTALL_SCRIPT}"

# Run the installer
./${INSTALL_SCRIPT} "${SERVICES}"

# Clean up everything
rm -rf "./${INSTALL_SCRIPT}"
rm -rf "${PACTUM_INSTALLER_DIR}"
