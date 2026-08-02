# Akaso-V50X-Hacking
Reverse Engineering and modifying Akaso V50X camera

## Disclaimer
This is a hardware and a firmware modification. This means you loose you warranty and risk your camera to be bricked. Use this method for your own risk.
I am not responsible for your broken camera

## Features
- Full root access
- Connect to an existing WiFi network instead of AP mode
- Telnetd and ftpd
- Use the screen to show arbitrary texts
- Rtsp server (IP cam mode)
- Make screenshots of the menu

## Usage
You have to disassemble the device and solder a generic UART to the board:
- with a really thin pry tool, disassemble the device from the screen side
- Solder an UART - USB converter cable to the pinpoints on the board. the pins are labeled correctly. Use 115200 baud
- You have root access without password on the camera via UART
- write the following lines to the end of /app/bootapp :
```bash
mkdir -p /dev/pts
mount -t devpts devpts /dev/pts
telnetd
sleep 10
mount -o remount,exec /app/sd
/app/sd/autorun.sh
```
- With theese you can
    - Use telnet to connect (with AP mode)
    - Run arbitrary commands from your sdcard

## Connect to WiFi Network
- Use my provided wpa_supplicant binary or
- Compile your own
    - make sure you have arm-linux-gnueabihf-gcc cross-compiler on your computer
    - wget https://w1.fi/releases/wpa_supplicant-2.10.tar.gz
    - tar xzf wpa_supplicant-2.10.tar.gz -C /tmp/
    - tweak your .config until it works (sorry)
    - make CC=arm-linux-gnueabihf-gcc LDFLAGS="-static" and copy the binary to /app/sd/lib/wpa_supplicant
- copy the wpa_supplicant.conf to /app/sd/lib on the device
- set the desired IP address in autorun.sh
- After bootup, turn on AP mode immediatelly and quit it. It will initialize the WiFi and create the wlan0 interface

## Extra bootup message
- Use fbtext (source and bin provided)


## Screenshots
- copy the screenshot bin and the screenshot.sh wrapper. 
- Use the wrapper without args on the device.
- It makes the filename current date. it makes a .ppm format files but you can convert it to png anytime. 


## RTSP Stream
- I've reverse engineered the URLs:
- Use VLC With theese streams if you are on the same network:
rtsp://xx.xx.xx.xx:554/livestream/11
rtsp://xx.xx.xx.xx:554/livestream/12

## Happy hacking


![screenshot1](screen.png)

![screenshot2](screen2.png)


![text on screen](proof.jpg)