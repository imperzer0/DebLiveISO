#!/bin/bash

touch .build/config
if [ "$?" -ne 0 ]; then exit $?; fi

sudo lb bootstrap
if [ "$?" -ne 0 ]; then exit $?; fi

sudo arch-chroot chroot/ /bin/bash -c "apt install -y ca-certificates"
if [ "$?" -ne 0 ]; then exit $?; fi

sudo cp -rfv config/apt/ chroot/etc/
if [ "$?" -ne 0 ]; then exit $?; fi

sudo lb chroot
if [ "$?" -ne 0 ]; then exit $?; fi

sudo lb binary
if [ "$?" -ne 0 ]; then exit $?; fi