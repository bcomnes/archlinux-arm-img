# archlinux-arm-img
[![Build Status](https://travis-ci.com/bcomnes/archlinux-arm-img.svg?branch=master)](https://travis-ci.com/bcomnes/archlinux-arm-img)

![logo](./alarm.png)

A simple (unofficial) CI/CD bash script to build a zipped `.img` of [Arch Linux Arm](https://archlinuxarm.org) installation archives, released to [GitHub releases](https://github.com/bcomnes/archlinux-arm-img/releases).

The `alarm` project does not publish images, just inconveniently packaged archives that require a very up-to-date version of  [`bsdtar`](https://www.libarchive.org).

Intended to be used with [packer](https://packer.io) and the [packer-builder-arm-image](https://github.com/solo-io/packer-builder-arm-image) plugin.

## Usage

The indented usage is to just consume the artifacts published on the [GitHub releases](https://github.com/bcomnes/archlinux-arm-img/releases) page, but you can also run it locally on linux.

```console
$ git clone https://github.com/bcomnes/archlinux-arm-img.git
$ cd archlinux-arm-img
$ sudo ./build-arch-arm-img.sh http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz
```

The script requires sudo access, because it needs to mount things.  Read the script, it short.

There is also a script to install new `bsdtar`, but its just a simple `./configure ; make ; make install`, so its not recommended to use outside of a disposable environment.  Find a way to install `bsdtar` 3.3.1 or greater with your system package manager.


## Examples

- See [.travis.yml](./travis.yml) for example usage
- See [github.com/bcomnes/raspi-packer](https://github.com/bcomnes/raspi-packer) for example consumption of this image with packer. (Note this is a WIP)

## Releases

Currently publishing the following installations.  Open a pull request if you would like additional images added or to request a rebuild.  Images are dated when they were created.

- [ArchLinuxARM-rpi-2-latest.tar.gz](https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3)([rpi2](https://archlinuxarm.org/platforms/armv7/broadcom/raspberry-pi-2))
- [ArchLinuxARM-rpi-3-latest.tar.gz](https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3)

Run your own builds CI for a greater level of trust in the build output.

## See also

-  [Packer](https://www.packer.io)
-  [archlinuxarm.org](https://archlinuxarm.org)
-  [projects/archlinux-rpi2/](https://sourceforge.net/projects/archlinux-rpi2/) - Similar project, but little transparency around builds
- [gist.github.com/larsch/4ae5499023a3c5e22552](https://gist.github.com/larsch/4ae5499023a3c5e22552) - A gist this workflow was based on
