                                                 ╺┳┓ ┏━┓ ╺┳╸ ┏━┓
                                                  ┃┃ ┃ ┃  ┃  ┗━┓
                                                 ╺┻┛ ┗━┛  ╹  ┗━┛

> These are my dotfiles for laptop running Ubuntu 18.04 with i3wm.


## Setup

| Package                                                                   | Description                                                                       |
|---------------------------------------------------------------------------|-----------------------------------------------------------------------------------|
| [Manjaro](https://manjaro.org/)                                           | My current distro of choice                                                       |
| [zsh](https://github.com/zsh-users/zsh)                                   | A powerful shell                                               |
| [i3-gaps](https://github.com/Airblader/i3)                                | i3 window manager with more features                                              |
| [ranger](https://github.com/ranger/ranger)                                | Ranger is a minimalistic console file manager                                     |
| [rofi](https://github.com/DaveDavenport/rofi)                             | A window switcher, application launcher and dmenu replacement                     |
| [compton](https://github.com/chjj/compton)                                | Compositor for X, to get window transparency and avoid tearing and vsync issues   |
| [dunst](https://github.com/dunst-project/dunst)                           | dunst is a highly configurable and lightweight notification daemon                |
| [neofetch](https://github.com/dylanaraps/neofetch)                        | Fast and highly customizable system info script                                   |
| [pywal](https://github.com/dylanaraps/pywal)                              | Tool that generates a color palette from the dominant colors in an image          |
| [betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen)       | A simple and minimal lockscreen                                                   |



Pywal is used to generate a color scheme from a wallpaper which is then also set as the lockscreen background.
This color scheme is then automatically applied to the terminal, ranger, dunst, vim and i3 making it quick and easy to generate a fresh setup.


#### zsh

I use the Z shell with [Oh-my-zsh](https://ohmyz.sh/) and the zsh prompt [spaceship](https://github.com/denysdovhan/spaceship-prompt).\
ZSH can be set by entering the command below in the terminal.

```
chsh -s $(which zsh)
```


#### TODO

+ Add an install script
