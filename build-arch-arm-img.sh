#!/usr/bin/env bash

set -e
set -x

IMG_DIR="images"
IMG_URL="$1"
IMG_NAME=${IMG_URL##*/}
IMG_PATH=${IMG_DIR}/${IMG_NAME}
TARGET_IMAGE=$(basename -s .tar.gz "$IMG_NAME").img
TARGET_IMAGE_MD5=${TARGET_IMAGE}.md5
MD5_URL=${IMG_URL}.md5
MD5_NAME=${MD5_URL##*/}

losetup /dev/loop0 && exit 1 || true

## Download the md5
mkdir -p IMG_DIR
pushd $IMG_DIR
wget -N $MD5_URL
if md5sum -c $MD5_NAME ; then
  echo "Cached ${IMG_NAME} already downloaded!"
else
  echo "Cached ${IMG_NAME} did not match MD5 of latest image, downloading"
  wget -N $IMG_URL
  md5sum -c $MD5_NAME
fi
popd

truncate -s 1500M $TARGET_IMAGE
losetup /dev/loop0 $TARGET_IMAGE
parted -s /dev/loop0 mklabel msdos
parted -s /dev/loop0 mkpart primary fat32 -a optimal -- 0% 100MB
parted -s /dev/loop0 set 1 boot on
parted -s /dev/loop0 unit mb mkpart primary ext2 -a optimal -- 100MB 100%
parted -s /dev/loop0 print
mkfs.vfat -I -n SYSTEM /dev/loop0p1
mkfs.ext4 -F -L root -b 4096 -E stride=4,stripe_width=1024 /dev/loop0p2

mkdir -p root
mount /dev/loop0p2 root

bsdtar xfz $IMG_PATH -C root
mv root/boot root/boot-temp
mkdir -p root/boot
mount /dev/loop0p1 root/boot
mv root/boot-temp/* root/boot/
rm -rf root/boot-temp
sed -i "s/ defaults / defaults,noatime /" root/etc/fstab
umount root/boot root
losetup -d /dev/loop0
rm -rf root
md5sum $TARGET_IMAGE > $TARGET_IMAGE_MD5

# Take from https://gist.github.com/larsch/4ae5499023a3c5e22552
