#!/bin/bash
CURRENT_USER_DIR=`pwd`
cd "$(dirname "$0")" # cd to script dir

source ./script/print_result.sh

simple-load() {
    APP_NAME=$1
    DESTINATION_DIR=$2
    if [ -d "./config/" ]; then 
        if [ -d "$DESTINATION_DIR" ]; then
            cp -rf ./config/$APP_NAME/* $DESTINATION_DIR
            print_result $APP_NAME $?
        else
            print_result "Trying to find $DESTINATION dir" 1
        fi
    else
        print_result "Trying to find ./config dir" 1
    fi
}

# some configs need to specify links to them
make_links() {
    ZSHRC=$HOME/.config/zsh/zshrc 

    if [ -f $ZSHRC ]; then
        ln -fs $ZSHRC $HOME/.zshrc    
    fi
}

load-gnome-terminal-config() {
    dconf load /org/gnome/terminal/ < ./config/gnome/gterminal.preferences
    print_result gnome-terminal $?
}

# MAIN
echo "--------------- LOAD_CONFIG SCRIPT ----------------"
if [ "$#" -eq 0 ]; then
    echo "To load ${green}all${textreset} configs from this folder. All configs:"
    echo "      * zsh"
    echo "      * alacritty"
    #echo "      * tmux"
    #echo "      * i3"
    #echo "      * i3status"
    echo "  + SPECIAL:"
    echo "      * gnome-terminal"
    echo
    echo "USE:"
    echo "        ./load_config.sh all"
    echo
    echo "---------------------------------------------------"
    echo "To load ${yellow}only one${textreset} config"
    echo
    echo "USE:"
    echo "        ./load_config.sh app /path/to/config/folder"
    echo
    echo "  app - the name of the app (which config is for)"
    echo
elif [ "$1" = "all" ]; then
    simple-load zsh $HOME/.config/zsh
    simple-load alacritty $HOME/.config/alacritty

    make_links

    # SPECIAL 
    # gnome-terminal
    load-gnome-terminal-config

elif [ "$#" -eq 1 ]; then
    simple-load $1 $2
else
    echo "${red}ERROR${textreset}... Wrong script usage. Type './load_local.sh without args to see help'"
fi

cd $CURRENT_USER_DIR # cd back to the place user was before
