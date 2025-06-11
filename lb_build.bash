#!/bin/bash

sudo lb bootstrap

sudo cp -rfv config/apt/ chroot/etc/

sudo lb chroot

sudo lb binary