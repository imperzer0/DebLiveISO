# Debian Live ISO
This is my custom debian live system configuration.
I did not touch the installer - only the live system.
The live system has many essential packages for system rescue preinstalled.
Moreover, I preconfigured some of the applications.
Among the changes are:
 * Disabled `kwallet`
 * Disabled `discover` autostart
 * Replaced `firefox-esr` with regular Mozilla Firefox (`firefox`)
 * Touchpad tapping enabled by default through `libinput` config

If you want to suggest any packages or features - you can do it through opening an Issue here on GitHub or contact me via email: [dmytroperets@gmail.com](mailto:dmytroperets@gmail.com)


## Build
To build this image run:
~~~bash
sudo bash lb_build.bash
~~~

*You can run this command without sudo. In that case it might ask you for a password in the middle of the build, which is not ideal.*

## Customisation
If you really want to customise it even more - follow Debian's official documentation.


# License
This ENTIRE repository is under GPLv3.0
