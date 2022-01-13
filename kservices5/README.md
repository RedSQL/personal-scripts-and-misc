# My KServices5 Utilities

This folder contains all my KServices5 utilities that I have written for personal use.

## Service Menus
### [getFilePath.desktop](https://github.com/RedSQL/personal-scripts-and-misc/blob/master/kservices5/ServiceMenus/getFilePath.desktop)

This service menu contains options to copy file paths, file names and converted (unix -> windows) file paths into clipboard on Wayland.

Requirements:

* wl-clipboard (For clipboard copy on Wayland)

* (Optional) [My python script](https://github.com/RedSQL/personal-scripts-and-misc/blob/master/python/convunix2nt.py) for converting file paths and names into windows format. 

If you want optional path conversion and copy to work, you will need my script and place it either into the path I have it at, or change the path to something else that is more convenient to you. 

This should work on X11 too - just install `xclip` and replace all `wl-copy` instances with `xclip`. 

Alternatively, if you want, you can opt for a... less elegant method of copying stuff - via a DBus! For that, you do not need `wl-clipboard`, and instead of calling `wl-copy` you just call: `dbus-send --type=method_call --dest=org.kde.klipper /klipper org.kde.klipper.klipper.setClipboardContents string:"%u"` instead.
