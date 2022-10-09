# Enable aur
sudo sed -Ei '/EnableAUR/s/^#//' /etc/pamac.conf

# Install paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# Install wm and additional packages
sudo pacman -S awesome rofi betterlockscreen lxappearance arc-gtk-theme papirus-icons-theme lightdm nautilus pasystray alacritty

# Install lightdm theme
paru lightdm-webkit-theme-aether

# Enable lightdm
sudo systemctl enable lightdm.service
