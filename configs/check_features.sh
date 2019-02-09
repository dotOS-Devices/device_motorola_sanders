#!/sbin/sh

sku=`getprop ro.boot.hardware.sku`

if [ "$sku" = "XT1806" ]; then
    # XT1806 doesn't have NFC chip
    rm /vendor/etc/permissions/android.hardware.nfc.xml
    rm /vendor/etc/permissions/android.hardware.nfc.hce.xml
    rm /vendor/etc/permissions/android.hardware.nfc.hcef.xml
    rm /vendor/etc/permissions/com.android.nfc_extras.xml
    rm -r /system/app/NfcNci
else
    # Only XT1806 variant got a compass
    rm /vendor/etc/permissions/android.hardware.sensor.compass.xml
fi

if [ "$sku" = "XT1802" ]; then
    # Only XT1802 got DTV
    echo "insmod /vendor/lib/modules/isdbt.ko" >> /vendor/bin/init.mmi.boot.sh
else
    # If not... Remove DTV APKs and libs
    rm -r /system/priv-app/DTVPlayer
    rm -r /system/priv-app/DTVService
    rm /vendor/lib*/libdtv*.so
fi
