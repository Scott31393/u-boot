.. SPDX-License-Identifier: GPL-2.0+

imx8mm_evk
==========

U-Boot for the NXP i.MX8MM EVK board

Quick Start
-----------

- Build the ARM Trusted firmware binary
- Get ddr firmware
- Build U-Boot
- Boot

Get and Build the ARM Trusted firmware
--------------------------------------

Note: builddir is U-Boot build directory (source directory for in-tree builds)
Get ATF from: https://source.codeaurora.org/external/imx/imx-atf
branch: imx_5.4.47_2.2.0

.. code-block:: bash

   $ make PLAT=imx8mm bl31
   $ cp build/imx8mm/release/bl31.bin $(builddir)

Get the ddr firmware
--------------------

.. code-block:: bash

   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.9.bin
   $ chmod +x firmware-imx-8.9.bin
   $ ./firmware-imx-8.9
   $ cp firmware-imx-8.9/firmware/ddr/synopsys/lpddr4*.bin $(builddir)

Build U-Boot
------------

.. code-block:: bash

   $ export CROSS_COMPILE=aarch64-poky-linux-
   $ make imx8mm_evk_defconfig
   $ make

Booting from the SD card
------------------------

Burn the flash.bin to MicroSD card offset 33KB and u-boot.itb to
offset 384kB.

.. code-block:: bash

   $sudo dd if=flash.bin of=/dev/sd[x] bs=1024 seek=33 conv=notrunc

Booting from the eMMC
---------------------

Power off the board and put the boot mode switches
to Download Mode.

Connect a USB cable between the TypeC port 1 and the host PC.

Load flash.bin via the 'uuu' tool:

.. code-block:: bash

   $ sudo uuu flash.bin

Load u-boot.itb via the 'uuu' tool:

.. code-block:: bash

   $ sudo uuu SDPV: write -f u-boot.itb -addr 0x42000000
   $ sudo uuu SDPV: jump -addr 0x42000000

Then U-Boot will be launched.

Run the ums tool to flash the eMMC:

.. code-block:: bash

   => ums 0 mmc 2
   => sudo dd if=flash.bin of=/dev/sd[x] bs=1024 seek=33; sync
   => sudo dd if=u-boot.itb of=/dev/sd[x] bs=1024 seek=384; sync

Power off the board. Put the boot switches to eMMC boot mode
and power it on.
