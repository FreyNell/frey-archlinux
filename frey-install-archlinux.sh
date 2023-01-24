loadkeys la-latin1
timedatectl set-timezone America/Bogota

EFIPART= #/dev/sda2 300M
SWAPPART= #/dev/sad3 4GB
ARCHPART= #/dev/sda4 495GB
GRUB_ENTRY=ARCHFREY

mkfs.fat -F 32 $EFIPART
mkfs.swap $SWAPPART
mkfs.ext4 $ARCHPART

mount $ARCHPART /mnt
mount --mkdir $EFIPART /mnt/boot
swapon $SWAPPART


pacman -Sy
pacstrap -K /mnt base linux linux-firmware
pacstrap -K /mnt xorg xorg-xinit xorg-apps xorg-server nvidia nvidia-utils networkmanager networkmanager-openvpn vi vim
genfstab -U /mnt >> /mnt/etc/fstab


arch-chroot


ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
hwclock --systohc
sed -i 's/#es_CO/es_CO/' /etc/locale.gen
locale-gen
echo "LANG=es_CO.UTF-8" >> /etc/locale.conf
echo "KEYMAP=la-latin1" >> /etc/vconsole.conf
echo "ARCHFREY" >> /etc/hostname

echo "Please create your ROOT user password"
passwd
pacman -S grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=$GRUB_ENTRY
pacman -S os-prober

sed -i 's/#GRUB_DISABLE_OS_PROBE/GRUB_DISABLE_OS_PROBE/' /etc/default/grub
pacman -S amd-ucode
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S zsh
useradd -m -G freynell -s /bin/zsh freynell
echo "Add password for freynell"
passwd freynell
pacman -S sudo
pacman -S bitwarden-cli
sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
pacman -S reflector
pacman -S htop
pacman -S bspwm sxhkd

pacman -S polybar
pacman -S xdg-user-dirs
pacman -S firefox
pacman -S openssh

sudo -u freynell xdg-user-dirs-update
sudo -u freynell mkdir -p /home/freynell/.config/bspwm
sudo -u freynell mkdir -p /home/freynell/.config/sxhkd
sudo -u freynell install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc /home/freynell/.config/bspwm/bspwmrc
sudo -u freynell install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc /home/freynell/.config/sxhkd/sxhkdrc

pacman -S libxkbcommon libxkbcommon-x11
localectl set-x11-keymap latam

echo "Edit /home/freynell/.xinitrc"
echo "Edit sxhkdrc configuration"
echo "Use startx bspwm to start bspwm"
