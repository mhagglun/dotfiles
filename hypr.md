# Install

## Nvidia
```bash
yay -S linux-headers nvidia-open-dkms nvidia-utils
```

Edit /etc/mkinitcpio.conf

Remove kms 
Add (nvidia nvidia_modeset nvidia_uvm nvidia_drm) to MODULES

Regenerate initramfs 
> sudo mkinitcpio -P

## Hyprland setup
```bash
yay -S hyprland \
  hyprpaper \
  hyprlock \
  hypridle \
  hyprpicker \
  hyprsunset \
  hyprshot \
  waybar \
  ghostty \
  rofi \
  xdg-desktop-portal-hyprland \
  blueman \
  pavucontrol \
  nwg-look \
  nwg-displays \


