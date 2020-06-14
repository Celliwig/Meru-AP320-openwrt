// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * arch/powerpc/platforms/83xx/meru-ap320.c
 *
 * Meru Networks AP320
 *
 * Copied from:
 * arch/powerpc/platforms/83xx/asp834x.c
 */

#include <linux/pci.h>
#include <linux/of_platform.h>

#include <asm/time.h>
#include <asm/ipic.h>
#include <asm/udbg.h>

#include <sysdev/fsl_soc.h>
#include "mpc83xx.h"

/* ************************************************************************
 *
 * Setup the architecture
 *
 */
static void __init meru_ap320_setup_arch(void)
{
	__be32 __iomem *wdt_reg_base = ioremap(get_immrbase() + 0x20e, 0xff);	// System Watchdog Service Register
	iowrite32be(0x556C0000, wdt_reg_base);		// Reset watchdog
	iowrite32be(0xAA390000, wdt_reg_base);

	mpc83xx_setup_arch();
	//mpc834x_usb_cfg();
}

machine_device_initcall(meru_ap320, mpc83xx_declare_of_platform_devices);

/*
 * Called very early, MMU is off, device-tree isn't unflattened
 */
static int __init meru_ap320_probe(void)
{
	return of_machine_is_compatible("meru,ap320");
}

define_machine(meru_ap320) {
	.name			= "Meru Networks AP320",
	.probe			= meru_ap320_probe,
	.setup_arch		= meru_ap320_setup_arch,
	.init_IRQ		= mpc83xx_ipic_init_IRQ,
	.get_irq		= ipic_get_irq,
	.restart		= mpc83xx_restart,
	.time_init		= mpc83xx_time_init,
	.calibrate_decr		= generic_calibrate_decr,
	.progress		= udbg_progress,
};
