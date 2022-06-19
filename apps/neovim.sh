#!/bin/bash
CURRENT_USER_DIR=`pwd`
cd "$(dirname "$0")" # cd to script dir
 
SOURCE_DIR=./neovim

# removes neovim from local system
remove() {
    sudo rm /usr/local/bin/nvim
    sudo rm -r /usr/local/share/nvim/
}

install() {
    git clone https://github.com/neovim/neovim.git $SOURCE_DIR
    if [ -d "$SOURCE_DIR" ]; then 
        cd $SOURCE_DIR
        make CMAKE_BUILD_TYPE=Release
        sudo make install
        cd ..
        sudo rm -rf $SOURCE_DIR
    fi
}


if [ "$1" = "reinstall" ]; then
    remove
    install
elif [ "$1" = "install" ]; then
    install
else
    echo "To install or reinstall do `./neovim.sh (install|reinstall)`"
fi

cd $CURRENT_USER_DIR # cd back to the place user was before