#!/bin/sh

SERVICES="$1"

if [ -z "${SERVICES}" ]
then
  echo "\033[1;31mServices must be provided (comma separated, no spaces)\033[0m"
  exit 1
fi

echo "\033[1;36m=================================\033[0m"
echo "\033[1;36m       Installing Pactum!        \033[0m"
echo "\033[1;36m=================================\033[0m"

INSTALLER_DIR='.'

# Sanity check to see if we're still in pactum-installer
if [ ! -d "${INSTALLER_DIR}/templates" ]
then
  # OH MY! We're outside the installer!
  INSTALLER_DIR=${PWD}/pactum-installer
fi

echo "\033[1;34mInstalling required dependencies...\033[0m"

# Make sure that we're in a Node project
if [ ! -f "./package.json" ]
then
  echo "\033[1;33mWARN: Converting current directory to a NodeJS project\033[0m"
  npm init -y > /dev/null
fi

# Install dependencies in local directory
DEPENDENCIES=( $(cat "${INSTALLER_DIR}/dependencies.txt") )
for dep in "${DEPENDENCIES[@]}"
do
  npm install "${dep}" > /dev/null
  echo "Installed ${dep}.";
done

echo "\033[1;32mDone\033[0m"

echo "\033[1;34mSetting up pactum test scripts...\033[0m"
# Clone template
TEMPLATES_DIR="${INSTALLER_DIR}/templates";
STUBBING_SCRIPT="${TEMPLATES_DIR}/stubbing.ts.txt"
TEMP_STUBBING_SCRIPT="${STUBBING_SCRIPT}.tmp"
cat "${STUBBING_SCRIPT}" > "${TEMP_STUBBING_SCRIPT}"

# Update template with the new data
echo "Modifying template..."
INSTALLER_SCRIPTS_DIR="${INSTALLER_DIR}/installer-scripts"
SERVICE_NAMESPACE=$(node "${INSTALLER_SCRIPTS_DIR}/create-services.js" "${SERVICES}");
sed -i '' "s/%SERVICE_NAMESPACE%/${SERVICE_NAMESPACE}/g" "${TEMP_STUBBING_SCRIPT}"

# turn to real file inside src/pactum
echo "Creating real file..."
PACTUM_SCRIPTS="${PWD}/src/pactum";
mkdir -p "${PACTUM_SCRIPTS}"
cat "${TEMP_STUBBING_SCRIPT}" > "${PACTUM_SCRIPTS}/stubbing.ts"

# Destroy temporary template
echo "Cleaning up..."
rm -rf "${TEMP_STUBBING_SCRIPT}"

echo "\033[1;32mDone\033[0m"

# Copy over the pactum server if it doesn't exist!
if [ ! -d "./pactum-server" ]
then
  echo "\033[1;34mCloning pactum-server...\033[0m"
  cp -R "${INSTALLER_DIR}/pactum-server" "./pactum-server"
  echo "\033[1;32mDone\033[0m"
fi

echo "\033[1;34mSetting up environment variables...\033[0m"
ENV_FILE="./.env"
# Create environment variables
if [ ! -f "${ENV_FILE}" ]
then
  echo "\033[1;33mWARN: Creating a .env file in current directory\033[0m"
  touch "${ENV_FILE}" # Create env file one
fi

echo "Appending environment variables..."
echo "PACTUM_URL=http://localhost" >> "${ENV_FILE}"
echo "PACTUM_PORT=3000" >> "${ENV_FILE}"

echo "\033[1;32mDone\033[0m"