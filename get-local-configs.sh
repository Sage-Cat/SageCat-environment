#!/bin/bash

# COLOURIZED TERMINAL OUTPUT
textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

c_echo()
{
  if [ -n "$1" ] ; then
      echo "$@"
  fi
}

get_config()
{
  export CONFIG_NAME=$1
  export SOURCE=$2
  export IGNORE_DIR_NAME=$3

  echo "--- Copying $CONFIG_NAME config ---"

  # CREATE DIR
  echo "${yellow}Removing old dir!${textreset}"
  c_echo $(rm -rfI $CONFIG_NAME)
  c_echo $(mkdir $CONFIG_NAME 2>&1) 

  # COPY CONFIG
  if [ -d $SOURCE ]; then # if dir
    c_echo $(cp -r $SOURCE/* $CONFIG_NAME/ 2>&1)
  else
    c_echo $(cp $SOURCE $CONFIG_NAME/ 2>&1)
  fi

  # REMOVE IGNORED DIRECTORY
  if [ ! -z $IGNORE_DIR_NAME ]; then
    c_echo $(rm -rf "$CONFIG_NAME/$IGNORE_DIR_NAME" 2>&1)
  fi

  if [ -d $CONFIG_NAME ] && [ "$(ls -A $CONFIG_NAME)" ]; then
    echo "$CONFIG_NAME... ${green}SUCCESS${textreset}"
  else
    echo "$CONFIG_NAME... ${red}FAILED${textreset}"
  fi

  echo
}

# NVIM
get_config "nvim" ~/.config/nvim "autoload"

# ALACRITTY
get_config "alacritty" ~/.config/alacritty

# ZSH
get_config "zsh" ~/.zshrc

# TMUX
get_config "tmux" ~/.tmux.conf

# README
rm -f README.md &> /dev/null;
echo "SageCat-Environment <br/>  Version for: $(date)" >> README.md

