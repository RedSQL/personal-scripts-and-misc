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

Alternatively, if you want, you can opt for a... less elegant method of copying stuff - via a DBus! For that, you do not need `wl-clipboard`, and instead of calling `wl-copy` you just call: `dbus-send --type=method_call --dest=org.kde.klipper /klipper org.kde.klipper.klipper.setClipboardContents string:"%u"` instead. As a bonus to removing a dependency, this method is **window system agnostic** - it will run both under X11 Plasma and Wayland Plasma. Sadly, it's not as elegant and I opted for `wl-clipboard` instead, since this is a personal desktop file script. However, you are free to change it though if it bothers you much - it's open source, after all!

### [hashUtils.desktop](https://github.com/RedSQL/personal-scripts-and-misc/blob/master/kservices5/ServiceMenus/hashUtils.desktop)

This service menu contains common hashing utilities helpers. As of the moment that I am writing this it only calculates and copies SHA1, SHA256 and SHA512 sums as I haven't seen the need to have other hashing algorithms/methods.

Requirements:

* Awk

* wl-clipboard (For clipboard copy on Wayland)

If you need to copy on X, see section about getFilePath.
