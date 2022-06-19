#!/bin/bash
CURRENT_USER_DIR=`pwd`
cd "$(dirname "$0")" # cd to script dir

source ./script/print_result.sh

simple-save() {
  APP_NAME=$1
  SOURCE_DIR=$2
  if [ -d "./config/" ]; then 
      cp -rf $SOURCE_DIR ./config
      print_result $APP_NAME $?
  else
      print_result "Trying to find ./config dir" 1
  fi
}

save-gnome-terminal-config() {
    mkdir -p ./config/gnome && rm -rf ./config/gnome/*
    dconf dump /org/gnome/terminal/ > ./config/gnome/gterminal.preferences
    print_result gnome-terminal $?
}

# MAIN
echo "--------------- SAVE_CONFIG SCRIPT ----------------"
if [ "$#" -eq 0 ]; then
    echo "To save from local system ${green}all${textreset} this configs:"
    echo "      * zsh"
    echo "      * alacritty"
    #echo "      * tmux"
    #echo "      * i3"
    #echo "      * i3status"
    echo "  + SPECIAL:"
    echo "      * gnome-terminal"
    echo
    echo "USE:"
    echo "        ./save_config.sh all"
    echo
    echo "---------------------------------------------------"
    echo "To save ${yellow}only one${textreset} config"
    echo
    echo "USE:"
    echo "        ./save_config.sh app /path/to/config/folder"
    echo
    echo "  app - the name of the app (which config is for)"
    echo
elif [ "$1" = "all" ]; then
    simple-save zsh $HOME/.config/zsh
    simple-save alacritty $HOME/.config/alacritty

    # SPECIAL 
    # gnome-terminal
    save-gnome-terminal-config

elif [ "$#" -eq 1 ]; then
    simple-save $1 $2
else
    echo "${red}ERROR${textreset}... Wrong script usage. Type './load_local.sh without args to see help'"
fi

cd $CURRENT_USER_DIR # cd back to the place user was before
