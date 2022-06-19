#!/bin/bash
CURRENT_USER_DIR=`pwd`
cd "$(dirname "$0")" # cd to script dir

SOURCE_DIR=./alacritty

# colors
textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)

# removes alacritty from local system
remove() {
    sudo rm /usr/local/bin/alacritty
    sudo rm /usr/share/pixmaps/Alacritty.svg
    sudo rm /usr/share/applications/Alacritty.desktop
    sudo update-desktop-database
}

install() {
    git clone https://github.com/alacritty/alacritty.git $SOURCE_DIR
    if [ -d "$SOURCE_DIR" ]; then 
        cd $SOURCE_DIR

        if [ "$1" = "x11" ]; then
            cargo build --release --no-default-features --features=x11
        elif [ "$1" = "wayland" ]; then
            cargo build --release --no-default-features --features=wayland
        else
            cargo build --release
        fi

        infocmp alacritty
        if [ ! $? -eq 0 ]; then # if infocmp failed
            sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
            echo "Some ${red}errors${textreset} appeared during 'infocmp alacritty' command."
        fi

        # Desktop Entry
        sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
        sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
        sudo desktop-file-install extra/linux/Alacritty.desktop
        sudo update-desktop-database
        
        # zsh complections
        mkdir -p ${ZDOTDIR:-~}/.zsh_functions
        echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
        cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

        cd ..
        sudo rm -rf $SOURCE_DIR
    fi
}


if [ "$1" = "reinstall" ]; then
    remove
    install $2
elif [ "$1" = "install" ]; then
    install $2
else
    echo "To install or reinstall do: "
    echo "           ./alacritty.sh (install|reinstall) [x11|wayland]"
fi

cd $CURRENT_USER_DIR # cd back to the place user was before