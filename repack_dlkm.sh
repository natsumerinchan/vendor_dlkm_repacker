#!/bin/bash

PARTITION=$1
SIZE=$2

rm -rf log.txt >> /dev/null
touch log.txt

NEWIMAGE="$PARTITION-ext4.img"
LOCALDIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`
MOUNTDIR="$LOCALDIR/$PARTITION"
toolsdir="$LOCALDIR/tools"
tmpdir="$LOCALDIR/tmp"
fileconts="$tmpdir/plat_file_contexts"

usage() {
    echo "sudo ./$0 <partition name>"
}

if [[ $1 == "" ]]; then 
    usage
fi

contextfix() {
    echo "/(vendor_dlkm|vendor/vendor_dlkm|system/vendor/vendor_dlkm)(/.*)?         u:object_r:vendor_file:s0" >> "$fileconts"
    echo "/(vendor_dlkm|vendor/vendor_dlkm|system/vendor/vendor_dlkm)/etc(/.*)?     u:object_r:vendor_configs_file:s0" >> "$fileconts"
}

rebuild() {
    mkdir $tmpdir
    echo "[INFO] Rebuilding $PARTITION as ext4 image..."
    cp -fpr $(sudo find $MOUNTDIR | grep file_contexts) $tmpdir/ >/dev/null 2>&1 
    contextfix
    SIZE=`du -sk $MOUNTDIR | awk '{$1*=1024;$1=int($1);printf $1}'`
    sudo $toolsdir/mkuserimg_mke2fs.py "$MOUNTDIR/" "$NEWIMAGE" ext4 "/$PARTITION" $SIZE $fileconts -j "0" -T "1230768000" -L "$PARTITION" -I "256" -i "80" -M "/$PARTITION" -m "0" >> log.txt 
    sudo rm -rf $tmpdir
    sudo chmod -R 777 $LOCALDIR
    echo "[INFO] Done"
}

rebuild
