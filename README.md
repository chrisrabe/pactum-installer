# Pactum Installer

>
> Stage: Prototype
>


## Pre-requisites
- You are using Jest as your testing framework
- You are using Typescript for your project
- You code is within the a `src` folder
- You have a `docker-compose.yml` file somewhere in your root directory
- You are using `axios` as your HTTP client
- You are using a Macbook to run the script
- You have NodeJS and NPM installed
- Scripts are pulled OUT of the directory

## Getting Started

1. Create a file called `install-pactum.sh` in your repository with the following contents:
```shell
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
INSTALL_SCRIPT="installer.sh"

git clone "${PACTUM_INSTALLER_REPO}" > /dev/null
mv "${PACTUM_INSTALLER_DIR}/${INSTALL_SCRIPT}" .

chmod +x "./${INSTALL_SCRIPT}"

# Run the installer
./${INSTALL_SCRIPT} "${SERVICES}"

# Clean up everything
rm -rf "./${INSTALL_SCRIPT}"
rm -rf "${PACTUM_INSTALLER_DIR}"
```

2. Make the file executable using `chmod +x ./install-pactum.sh`
3. Run the script `./install-pactum.sh "service1,service2,serviceN"`

NOTE: The arguments passed in the pactum installation script represents third party services
that your application interacts with. If you're not interacting with other services, feel free
to just run `./install-pactum.sh "default"`. This can be modified later within the code.

## Why build this?
This installer was created to streamline the pactum set up and installation process for
your environment.

## Benefits
- Removes the decision making for setting up pactum
- Installs a pactum-server which can be used as a server for local development
- Faster to install dependencies and set up