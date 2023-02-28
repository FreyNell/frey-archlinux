loadkeys la-latin1
timedatectl set-timezone America/Bogota

echo "Configure lsbkl disks"
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

pacman -Syu
pacstrap -K /mnt base linux-zen linux-firmware \
grub efibootmgr os-prober amd-ucode acpi \
xorg xorg-xinit xorg-apps xorg-server libxkbcommon libxkbcommon-x11 \
xf86-video-nouveau \
networkmanager networkmanager-openvpn \
neovim zsh sudo bitwarden reflector htop xdg-user-dirs \
bspwm sxhkd polybar firefox openssh git wget dmenu autorandr \
mesa-utils vi kitty imagemagick pipewire pipewire-alsa pipewire-pulse pamixer \
xbindkeys ufw gufw hdparm ranger feh \
lynis clamav clamtk rkhunter xclip picom \
mpv flameshot xorg-xclipboard copyq libreoffice \
easyeffects pavucontrol qpwgraph powertop \
fd ripgrep notification-daemon dunst

genfstab -U /mnt >> /mnt/etc/fstab

cp frey-archlinux-install* /mnt/root

