loadkeys la-latin1
timedatectl set-timezone America/Bogota


echo "Configure your LSBLK disks partitions"
exit 1;

EFIPART= #/dev/sda2 300M
SWAPPART= #/dev/sda3 4GB
ARCHPART= #/dev/sda4 495GB
GRUB_ENTRY=ARCHFREY


mkfs.fat -F 32 $EFIPART
mkswap $SWAPPART
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
alsa-utils alsa-plugins sof-firmware alsa-ucm-conf \
nvidia-prime mesa-utils vi kitty

genfstab -U /mnt >> /mnt/etc/fstab

cp frey-archlinux-install* /mnt/root

