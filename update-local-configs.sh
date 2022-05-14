#!/bin/bash

SOURCE_DIR=~/Documents/Git/sagecat-environment

# COLOURIZED TERMINAL OUTPUT
textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)
green=$(tput setaf 2)

# --- update_environment_in_current_os ---
if [ -d $SOURCE_DIR ]; then
  # TMUX
  cp -r $SOURCE_DIR/tmux/.tmux.conf ~/
  if [ $? -eq 0 ]; then
    echo "Tmux... ${green}OK${textreset}"
  else
    echo "Tmux...  ${red}ERROR${textreset}"
  fi

  # NEOVIM
  cp -rf $SOURCE_DIR/nvim ~/.config/nvim
  if [ $? -eq 0 ]; then
    echo "Neovim... ${green}OK${textreset}"
  else
    echo "Neovim...  ${red}ERROR${textreset}"
  fi

  # ALACRITTY
  cp -r $SOURCE_DIR/alacritty ~/.config
  if [ $? -eq 0 ]; then
    echo "Alacritty... ${green}OK${textreset}"
  else
    echo "Alacritty...  ${red}ERROR${textreset}"
  fi

  # ZSH
  cp $SOURCE_DIR/zshrc ~/.zshrc
  if [ $? -eq 0 ]; then
    echo "ZSH... ${green}OK${textreset}"
  else
    echo "ZSH...  ${red}ERROR${textreset}"
  fi

  # MY SCRIPTS
  cp $SOURCE_DIR/scripts/* ~/bin
  if [ $? -eq 0 ]; then
    echo "My scripts... ${green}OK${textreset}"
  else
    echo "My scripts...  ${red}ERROR${textreset}"
  fi
fi
