#!/bin/bash
#set -x

EXCEPTIONS=
ESSENTIAL="AppleALC.kext FakePCIID_XHCIMux.kext SATA-RAID-unsupported.kext"

# include subroutines
source "$(dirname ${BASH_SOURCE[0]})"/_tools/_install_subs.sh
warn_about_superuser

# install tools
install_tools

# remove old kexts
remove_deprecated_kexts
# USBXHC_Envy.kext is not used any more (using USBInjectAll.kext instead)
remove_kext USBXHC_Envy.kext

# using AppleALC.kext, remove AppleHDA injectors
remove_kext AppleHDA_IDT76e0_Envy.kext
remove_kext AppleHDA_ALC282.kext
remove_kext AppleHDA_ALC290.kext

# install required kexts
install_download_kexts
install_brcmpatchram_kexts
install_backlight_kexts

# some models need FakePCIID_XHCIMux.kext
install_fakepciid_xhcimux

# some models have fixed SATA mode as RAID (iRST)
install_kext kexts/SATA-RAID-unsupported.kext

# all kexts are now installed, so rebuild cache
rebuild_kernel_cache

# update kexts on EFI/CLOVER/kexts/Other
update_efi_kexts

# VoodooPS2Daemon is deprecated
remove_voodoops2daemon

#EOF
