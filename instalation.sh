#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as sudo"
   exit 1
fi

apt update
apt install libsdl2-dev libgtkmm-3.0-dev libportaudio2 python3-gi libopenjp2-7 git ninja-build xorg python3-pip meson libjpeg-dev zlib1g-dev cmake extra-cmake-modules qttools5-dev qttools5-dev-tools libqt5x11extras5-dev libsdl2-dev libxi-dev libxtst-dev libx11-dev itstool gettext fbi -y

pip3 install pillow
pip3 install screeninfo

cp configFiles/gamepadmouse.gamecontroller.amgp /home/$SUDO_USER/gamepadmouse.gamecontroller.amgp

mkdir -p /opt/vba-m

cp configFiles/start.sh /home/$SUDO_USER

cp configFiles/romsCopy.sh /opt/vba-m

cp configFiles/infoScreen.py /opt/vba-m

cp configFiles/newGame.glade /opt/vba-m

cp configFiles/splash.service /etc/systemd/system/

mkdir -p /usr/share/plymouth/themes/pix/

mkdir UserInterface/newRoms

cp configFiles/splashscreen.jpg /usr/share/plymouth/themes/pix/

cp configFiles/splashscreen.jpg /opt/vba-m

chmod 755 /opt/retro/romsCopy.sh

chmod 755 /opt/retro/infoScreen.py

mkdir -p /home/$SUDO_USER/.config/visualboyadvance-m

mkdir -p /home/$SUDO_USER/.config/antimicrox

cp configFiles/vbam.ini /home/$SUDO_USER/.config/visualboyadvance-m/

cp configFiles/antimicrox_settings.ini /home/$SUDO_USER/.config/antimicrox/antimicrox_settings.ini

chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/

cd /home/$SUDO_USER

git clone https://github.com/visualboyadvance-m/visualboyadvance-m.git
cd visualboyadvance-m

./installdeps
mkdir build && cd build
cmake .. -G Ninja
ninja

mv ./visualboyadvance-m /home/$SUDO_USER/vba-m
rm -rf /home/$SUDO_USER/visualboyadvance-m/

echo KERNEL=="sd*[!0-9]|sr*", ENV{ID_SERIAL}!="?*", SUBSYSTEMS=="usb", RUN+="/opt/vba-m/romsCopy.sh" | sudo tee --append /etc/udev/rules.d/10-usb.rules

cd /home/$SUDO_USER

git clone https://github.com/AntiMicroX/antimicrox.git

cd antimicrox
mkdir -p build && cd build
cmake ..
cmake --build .

sed -i "s/PrivateMounts=yes/PrivateMounts=no/" /lib/systemd/system/systemd-udevd.service

echo "/home/pi/start.sh 2>/dev/null" >> /home/$SUDO_USER/.bashrc

sed -i "s/console=tty1/console=serial0/" /boot/cmdline.txt

systemctl disable getty@tty1

systemctl enable splash

reboot
