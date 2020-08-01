# Meru-AP320-openwrt

OpenWRT target for Meru Networks AP320.

## Build

- git clone https://git.openwrt.org/openwrt/openwrt.git
- cd openwrt
- cd target/linux/
- ln -s ../../../Meru-AP320-openwrt/ mpc83xx
- cd -
- ~~git tag~~
- ~~git checkout <tag_name>~~
- ./scripts/feeds update -a
- ./scripts/feeds install -a
- edit 'package/firmware/wireless-regdb/Makefile'
	-	$(CP) $(PKG_BUILD_DIR)/regulatory.db $(1)/lib/firmware/
	-+	$(CP) $(PKG_BUILD_DIR)/regulatory.db.p7s $(1)/lib/firmware/
- cp target/linux/mpc83xx/meru_defconfig .config
- make defconfig
- make
- cd bin/targets/mpc83xx/meru/
- cat openwrt-0-1-mpc83xx-meru-ap320-squashfs-fdt.bin openwrt-0-1-mpc83xx-meru-ap320-squashfs-kernel.bin openwrt-0-1-mpc83xx-meru-ap320-squashfs-rootfs.bin > __meru_ap320.fw__

## Install
- Boot to U-boot.
- Copy __meru_ap320.fw__ to the device memory.
- Write to flash memory starting at the second sector: 0xff020000

## Operation

- Default password: Sumeru
- Default IP: 192.168.1.1

## ToDo
- Move to ubifs.
- Implement sysupgrade.
