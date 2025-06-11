#!/bin/bash

touch .build/config

sudo lb bootstrap

sudo arch-chroot chroot/ /bin/bash -c "apt install -y ca-certificates"

sudo cp -rfv config/apt/ chroot/etc/

sudo lb chroot

sudo lb binary