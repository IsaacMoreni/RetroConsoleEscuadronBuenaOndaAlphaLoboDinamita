#!/bin/bash

devicesList=`blkid | grep '/dev/sd' | cut -d ":" -f 1`
IFS=$'\n' read -rd '' -a devicearray <<<"$devicesList"

mountedDevices=`df -h | grep "/dev/sd" | cut -d " " -f 1`
IFS=$'\n' read -rd '' -a mountedArray <<<"$mountedDevices"

count=1
new=0
romsadded=0

for diviceConected in "${devicearray[@]}"; do
    for diviceMounted in "${mountedArray[@]}"; do
        if [ "$diviceConected" = "$diviceMounted" ]; then
            new=1
        fi
    done
    if [ "$new" -eq "1" ]; then
        new=0
    else
        echo se monta $diviceConected >> /home/pi/testo.txt
        mkdir -p /media/usb$count
        mount $diviceConected /media/usb$count
        sleep 6
        if [[ -d /media/usb$count/roms ]]
        then
            files=`ls /media/usb$count/roms/*.gb  | wc -l`
            romsadded=$(( $romsadded + $files ))
            files=`ls /media/usb$count/roms/*.gbc | wc -l`
            romsadded=$(( $romsadded + $files ))
            files=`ls /media/usb$count/roms/*.gba | wc -l`
            romsadded=$(( $romsadded + $files ))
            cp /media/usb$count/roms/*.gb  /home/pi/GameBoy-pi/UserInterface/newRoms/
            cp /media/usb$count/roms/*.gbc /home/pi/GameBoy-pi/UserInterface/newRoms/
            cp /media/usb$count/roms/*.gba /home/pi/GameBoy-pi/UserInterface/newRoms/
        fi

        count=$(( $count + 1 ))
    fi
done

chown -R pi:pi /home/pi/GameBoy-pi/UserInterface/newRoms/

if [[ "$romsadded" -gt "0" ]]
then
    export DISPLAY=:0
    /opt/vba-m/infoScreen.py
fi
