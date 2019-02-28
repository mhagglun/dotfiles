                                                 ╺┳┓ ┏━┓ ╺┳╸ ┏━┓
                                                  ┃┃ ┃ ┃  ┃  ┗━┓
                                                 ╺┻┛ ┗━┛  ╹  ┗━┛

> These are my dotfiles for Manjaro i3. There are many more like it, but this one is mine.

## Screenshots
![fetch](screenshots/clean.png?raw=true "Clean")
![fetch](screenshots/fakebusy.png?raw=true "Fake busy")


## Setup




| Package                                                                   | Description                                                                       |
|---------------------------------------------------------------------------|-----------------------------------------------------------------------------------|
| [Manjaro](https://manjaro.org/)                                           | My current distro of choice                                                       |
| [Zsh](https://github.com/zsh-users/zsh)                                   | The most powerful shell out there!                                                |
| [i3-gaps](https://github.com/Airblader/i3)                                | i3 window manager with more features                                              |
| [polybar](https://github.com/jaagr/polybar)                               | Highly customizable status bar                                                    |
| [kitty](https://sw.kovidgoyal.net/kitty/)                                 | A GPU based terminal emulator                                                     |
| [ranger](https://github.com/ranger/ranger)                                | Ranger is a minimalistic console file manager                                     |
| [Rofi](https://github.com/DaveDavenport/rofi)                             | A window switcher, application launcher and dmenu replacement                     |
| [Compton](https://github.com/chjj/compton)                                | A compositor for X, to get window transparency and avoid tearing and vsync issues |
| [dunst](https://github.com/dunst-project/dunst)                           | Dunst is a highly configurable and lightweight notification daemon                |
| [neofetch](https://github.com/dylanaraps/neofetch)                        | A fast and highly customizable system info script                                 |
| [pywal](https://github.com/dylanaraps/pywal)                              | A tool that generates a color palette from the dominant colors in an image        |



Pywal is used to generate a color scheme from a wallpaper.
This color scheme is then automatically applied to the terminal, polybar, ranger, dunst, vim and i3 making it extremely easy and fun to generate a new fresh setup on the go.



#### zsh

I use the Z shell with [Oh-my-zsh](https://ohmyz.sh/) and the zsh prompt [spaceship](https://github.com/denysdovhan/spaceship-prompt).\
ZSH can be set by entering the command below in the terminal.

```
chsh -s $(which zsh)
```



#### TODO

+ Add an install script
