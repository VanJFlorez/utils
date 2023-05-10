Debian Setup
============
See at the end of this document for useful software and commands.

## sudo
If sudo is not installed on the system simply issue ```apt install sudo```
1. Note that ```su -``` is different from ```su -i```
2. ```su -```
3. Once you are the root go to ```/etc/sudoers``` file.
4. Then look for the root permissions line ```root ALL=(ALL:ALL) ALL```
5. Add a new line but now instead of ```root``` put your ```username```
6. Finally type ```:``` and then throw a ```w!```
7. Now your user can throw ```sudo commands```

## apt 
1. Comment out the ```cdrom://``` url line on ```sudo nano /etc/apt/sources.list```
2. Check the [documentation](https://wiki.debian.org/SourcesList#Example_sources.list) for examples on the official repositories.
3. Add this entry to ```sources.list```:     
    ```deb http://deb.debian.org/debian bullseye main```
4. ```sudo apt update```

## mount
```/etc/fstab``` file (filesystem table) can help to automate the mounting tasks by defining
common mount points and the objective devices.
1. ```mkdir /media/usb```
2. ```fdisk -l```
3. Locate your drive. ```sd?``` will point to your drive, ```sd?n``` will point to your drive instance.
4. ```mount /dev/sd?n /media/usb```. Where ? is a letter (a, b, c) and ```n``` a number.
5. Check you mount points:
	```lsblk````

## fstab file
Edit this file to mount drives at startup
1. Open ```fstab``` file:
	```sudo vim /etc/fstab```
2. Get the drive's UUID:
	```sudo blkid```
3. Get the drive location
	```fdisk -l```
4. Add the following line. Note that this line follows the patter of the current defined mounting points.
	```UUID=109F14D1584B8AF4 /media/data ntfs-3g defaults      0       0```

If your files system is formated with NTFS, remember that the backend implementation was done with ```ntfs-3g```. If you launch your Windows OS you can get a detached state error since hibernation data can be stored in your system.

## openssh-server
0. ```apt update```
1. ```apt install openssh-server```
2. ```systemctl status ssh```
You can ```systemctl start|stop enable|disable```. The ```start|stop``` will work for current process, the another couple will enable or disable the process on system startup.

## Usage conventions
Put new software in ```/opt``` folder.


Installing Software
===================
1. Download binaries
2. Extract them into ```/opt```: 
    ```
    sudo mkdir -p /opt/app
    sudo tar -xJvf node-$VERSION-$DISTRO.tar.xz -C /opt/app
    ```
3. Then add this entry to your path in ```~/.profile``` file:
    ```
    export PATH=/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH
    


Windows 11 dual boot
====================
## GRUB fix
For Win11 the disk partition scheme must be UEFI-GPT. For this there is a dedicated partition that handles the boot. If you launch Windows when you already installed Debian, this can override your GRUB bootloader. To fix this, is only a matter to configure boot process from WinOS:
1. List your Win bootloaders: ```bcdedit```
2. Mount the ```EFI``` partition: ```mountvol X: \S```
3. Navigate ```X:``` volume and search for your debian boot files, in particular ```grubx64.efi```
4. Then, change the boot file:
    ```bcdedit {bootmgr} path \EFI\debian\grubx64.efi```
    
### Share data
1. Install the ntfs-3g driver. NTFS is from Microsoft this is a driver for linux.
2. Install GParted
3. Create a NTFS partition.
4. Point Downloads there and link your user folders there.
5. Add this drive to ```/etc/fstab``` to mount this drive on each start up automatically.

#### Mount on 


Effortless system usage
=======================
### Software
- htop
- tree
- sudo
- network-manager
    * nmcli: ```nmcli dev wifi connect ESSID password PASSWORD```
### Commands
- w
- hostname -I
- ip a
- modprobe
* Extract
    ```tar -xvf filename```
* Shutdown your system    
    ```sudo shutdown -h now```
* Search for ```pattern``` inside of your files    
    ```grep -rn 'folder' -e 'pattern'```
* Retrieve the libraries instaled on your current sytem   
    ```ldconfig -p | grep libname```
* GPU (```radeontop```) and CPU usage (```lm-sensors```)
    ```radeontop -c```
    ```sensors```

### Shortcuts
#### KDE
- ```Ctrl Q```: Close

## Software management
- ```dpkg -l``` list packages
- ```dmesg``` system logs



Troubleshooting
===============
Mouse speed
-----------
1. ```sudo apt install xinput```
2. ```xinput --list```: list input devices
3. ```xinput --list-props <devid>```
4. ```xinput --set-prop <devid> <prop> <newval>```


Per display scaling
-------------------
1. List your monitors ```xrandr --listmonitors```
2. Scale your screen ```xrandr --output eDP --scale 1.0x1.0```
3. Scale your screen ```xrandr --output eDP --scale 0.5x0.5```

Network is slow on wifi
-----------------------
Slow page load may be experienced this may be related to a driver issue since pages load fastly through cable, a simple restart could solve this issue.

1. Install ```speedtest-cli```
2. ```speedtest-cli --secure```

1. ```ip a```
2. ```ip link set enp4s0 down```
3. ```ip link set enp4s0 up```

1. ```nmcli dev show```
2. ```nmcli dev disconnect wlp3s0```
3. ```nmcli dev wifi```

1. ```systemctl restart NetworkManager```

Missing firmware
----------------
In general, the process involves to look at Debian package repositories for the hardware brand and the kind of firmware do you need. This issues happens because most of this drivers are not _open source_.
While we are talking about firmware here, is important to note that a command that could help is ```sudo lspci -v```.

### Check
- ```lsmod``` List kernel modules
- ```lspci -v``` List drivers
- ```rmmod``` remove module
- ```modprobe``` load kernel module

### Download
#### Realtek drivers (wifi, ethernet, bluetooth)
The network drivers for both _Lenovo H520s_ and _HP G8 245_ can be found [here](https://packages.debian.org/bullseye/firmware-realtek)
#### Amd drivers (Radeon graphics)
The graphics drivers for both _Lenovo H520s_ and _HP G8 245_ can be found [here](https://packages.debian.org/bullseye/firmware-amd-graphics)

1. mount your drive with the ```.deb``` firmware packages
2. ```apt install firmware-????-????```
