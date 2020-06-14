/* SPDX-License-Identifier: GPL-2.0 */
#include "ppc_asm.h"

#define SPRN_HID0	0x3F0		/* Hardware Implementation Register 0 */
#define SPRN_HID3	0x3F3		/* Hardware Implementation Register 3 */
#define HID0_ICE	(1<<15)		/* Instruction Cache Enable */
#define HID0_DCE	(1<<14)		/* Data Cache Enable */

#define MSR_IR		(1<<5)
#define MSR_DR		(1<<4)

	.text
	.global _zimage_start
_zimage_start:
	// HID0: d000
	// Turn off data/instruction cache, data cache lock
	li	r20, 0x0
	sync
	isync
	mtspr	SPRN_HID0, r20
	isync

	// MSR: b002
	// Disable External interrupts
	li	r20, 0x3002
	mtmsr	r20
	sync

	// WDT cfg: ffff0007
	// Reset WDT
	lis	r20, -0x2000
	ori	r20, r20, 0x20e
	lis	r21, 0x556c
	stw	r21, 0(r20)
	lis	r21, -0x55c7
	stw	r21, 0(r20)

	b	_zimage_start_lib
