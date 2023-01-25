loadkeys la-latin1
timedatectl set-timezone America/Bogota

exit 1; # prevent runing

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
pacstrap -K /mnt base linux linux-firmware \
grub efibootmgr os-prober amd-ucode acpi \
xorg xorg-xinit xorg-apps xorg-server libxkbcommon libxkbcommon-x11 \
xf86-video-nouveau xf86-video-amdgpu \
networkmanager networkmanager-openvpn \
neovim zsh sudo bitwarden-cli reflector htop xdg-user-dirs \
bspwm sxhkd polybar firefox openssh git wget dmenu autorandr \
alsa-utils alsa-plugins sof-firmware alsa-ucm-conf

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot

systemctl enable NetworkManager

ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
hwclock --systohc

sed -i 's/#es_CO/es_CO/' /etc/locale.gen

locale-gen

echo "LANG=es_CO.UTF-8" >> /etc/locale.conf
echo "KEYMAP=la-latin1" >> /etc/vconsole.conf
echo "ARCHFREY" >> /etc/hostname

echo "Please create your ROOT user password"
passwd

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=$GRUB_ENTRY

sed -i 's/#GRUB_DISABLE_OS_PROBE/GRUB_DISABLE_OS_PROBE/' /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg

useradd -m -s /bin/zsh freynell

echo "Add password for freynell"
passwd freynell

sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

su freynell
cd ~
xdg-user-dirs-update
mkdir -p /home/freynell/.config/bspwm
mkdir -p /home/freynell/.config/sxhkd
install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc /home/freynell/.config/bspwm/bspwmrc
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc /home/freynell/.config/sxhkd/sxhkdrc

localectl set-x11-keymap latam

echo "Edit /home/freynell/.xinitrc"
wget https://raw.githubusercontent.com/FreyNell/frey-archlinux/main/.xinitrc

echo "Edit sxhkdrc configuration"
wget https://raw.githubusercontent.com/FreyNell/frey-archlinux/main/.config/sxhkd/sxhkdrc -O /home/freynell/.config/sxhkd/sxhkdrc

echo "Edit bspwmrc"
wget https://raw.githubusercontent.com/FreyNell/frey-archlinux/main/.config/bspwm/bspwmrc -O /home/freynell/.config/bspwm/bspwmrc

echo "Zprofile file is for run kitty and bspwm as soon as I log in."
wget https://raw.githubusercontent.com/FreyNell/frey-archlinux/main/.zprofile

echo "Install Oh My Zsh!"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

