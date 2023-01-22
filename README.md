# Vendor_dlkm Repacker #

### Prerequisites ###
- Linux running kernel 5.4 or up (check with `uname -r`)
This repository based on [rain2wood/erofs](https://github.com/rain2wood/erofs.git)

### How to use ###
- Usage:

```
git clone -b vendor_dlkm https://github.com/natsumerinchan/erofs.git

cd ./erofs

// Please copy your offical vendor_dlkm.img into erofs folder

sudo mkdir /mnt/vendor_dlkm

sudo mount ./vendor_dlkm.img /mnt/vendor_dlkm -o loop

sudo cp -r /mnt/vendor_dlkm ./vendor_dlkm

sudo umount /mnt/vendor_dlkm

sudo rm -rf /mnt/vendor_dlkm

sudo chmod -R 777 ./vendor_dlkm

// Now you can modify vendor_dlkm

// Repack vendor_dlkm.img

sudo bash ./repack_dlkm vendor_dlkm

// Now you can flash vendor_dlkm-ext4.img to your device.

fastboot flash vendor_dlkm ./vendor_dlkm-ext4.img

```

### Credits and Thanks ###
[rain2wood](https://github.com/rain2wood)

[Amack](https://github.com/amackpro)

[Erfan Abdi](https://github.com/erfanoabdi)

[Velosh](https://github.com/velosh)

[Piraterex](https://github.com/piraterex)

[Xiaoxindada](https://github.com/xiaoxindada)

And all those I forgot to mention.
