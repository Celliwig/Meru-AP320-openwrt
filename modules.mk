#define KernelPackage/usb-ehci-fsl
#	TITLE:=Freescale MPC8349 USB driver
#	KCONFIG:= \
#		CONFIG_USB=y \
#		CONFIG_USB_EHCI_HCD=y \
#		CONFIG_USB_EHCI_FSL
#	DEPENDS:=@TARGET_mpc83xx_meru
#	SUBMENU:=$(USB_MENU)
#	FILES:= \
#		$(LINUX_DIR)/drivers/usb/host/ehci-fsl.ko \
#		$(LINUX_DIR)/drivers/usb/host/fsl-mph-dr-of.ko
#	AUTOLOAD:=$(call AutoLoad,45,usb-ehci-fsl,1)
#endef
#
#define KernelPackage/usb-ehci-fsl/description
#  Support for USB on Freescale MPC8349 SOCs.
#endef
#
#$(eval $(call KernelPackage,usb-ehci-fsl))

