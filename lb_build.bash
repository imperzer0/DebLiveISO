#!/bin/bash

### STEP 1 ###
# Mark configuration step as completed
touch .build/config
if [ "$?" -ne 0 ]; then exit $?; fi


### STEP 2 ###
sudo lb bootstrap
if [ "$?" -ne 0 ]; then exit $?; fi

# Install ca-certificated, so custom repos can get verified
sudo arch-chroot chroot/ /bin/bash -c "apt install -y ca-certificates"
if [ "$?" -ne 0 ]; then exit $?; fi

# Copy APT Config Files
sudo cp -rfv config/apt/ chroot/etc/
if [ "$?" -ne 0 ]; then exit $?; fi


### STEP 3 ###
sudo lb chroot
if [ "$?" -ne 0 ]; then exit $?; fi

# Create a non-root user
sudo arch-chroot chroot/ /bin/bash -c "useradd -mg users -G sudo -s /bin/bash dima; exit 0;"
if [ "$?" -ne 0 ]; then exit $?; fi

# Set non-root password
sudo arch-chroot chroot/ /bin/bash -c "echo -e \"Enter New non-root password:\n\"; passwd dima"
if [ "$?" -ne 0 ]; then exit $?; fi

# Purge firefox-esr
sudo arch-chroot chroot/ /bin/bash -c "apt purge -y firefox-esr"
if [ "$?" -ne 0 ]; then exit $?; fi

# Purge leftovers
sudo arch-chroot chroot/ /bin/bash -c "apt autopurge -y"
if [ "$?" -ne 0 ]; then exit $?; fi

# Quick lil peek...
sudo arch-chroot chroot/ /bin/bash
if [ "$?" -ne 0 ]; then exit $?; fi


### STEP 4 ###
sudo lb binary
if [ "$?" -ne 0 ]; then exit $?; fi