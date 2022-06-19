# My environment

```bash
chmod -R a+x *.sh
```
## Environment setup

### Dependencies

#### Fedora
```bash
sudo dnf install g++ gcc gcc-c++ libtool cargo freetype-devel glib2-devel cairo-devel meson pkgconfig gtk-doc lcms2-devel cmake fontconfig-devel libxcb-devel libxkbcommon-devel
```

#### Debian-based
```bash
sudo apt-get install g++ gcc gcc-c++ libtool cargo freetype-devel glib2-devel cairo-devel meson pkgconfig gtk-doc lcms2-devel cmake fontconfig-devel libxcb-devel libxkbcommon-devel
```

### Shell

#### Fedora
```bash
sudo dnf install zsh && chsh -s /usr/bin/zsh
```

git config --global core.editor nvim
#### Debian-based
```bash
sudo apt-get install zsh && chsh -s /usr/bin/zsh
```

### Flatpak apps

#### Fedora
pre-installed

#### Debian-based
```bash 
sudo apt-get install flatpak gnome-software-plugin-flatpak
```

#### [optional] adding flathub

```bash 
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

#### Apps to install with flatpak - search for those you need in google :3
- vlc
- telegram
- kdenlive

### Default apps to install (using dnf, yum or apt-get)
- vs code

### Manual apps installation

_Don't pass arguments to the scripts if you want to see the help (some customization is availiable)_

#### Terminal emulator (Alacritty)

```bash
./apps/alacritty.sh install 

# make alacritty default terminal emulator in Gnome
# may not help :(
gsettings set org.gnome.desktop.default-applications.terminal exec alacritty 
```
#### Text editor (NeoVim)

```bash
./apps/neovim.sh install 

# make it default git editor
git config --global core.editor nvim
```

## Configs setup


- `load_config.sh` - to load configs **to** your local system
- `save_config.sh` - to copy configs **from** your local system to this folder


