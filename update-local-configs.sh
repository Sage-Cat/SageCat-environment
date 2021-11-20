#!/bin/bash

# COLOURIZED TERMINAL OUTPUT
textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)
green=$(tput setaf 2)

# --- update_environment_in_current_os ---
if [ -d ~/Git/sagecat-environment ]; then
  cd ~/Git/sagecat-environment

  # NEOVIM
  cp -rf ./nvim ~/.config/nvim
  if [ $? -eq 0 ]; then
    echo "Neovim... ${green}OK${textreset}"
  else
    echo "Neovim...  ${red}ERROR${textreset}"
  fi

  # ALACRITTY
  cp -r ./alacritty ~/.config/alacritty
  if [ $? -eq 0 ]; then
    echo "Alacritty... ${green}OK${textreset}"
  else
    echo "Alacritty...  ${red}ERROR${textreset}"
  fi

  # ZSH
  cp ./zshrc ~/.zshrc
  if [ $? -eq 0 ]; then
    echo "ZSH... ${green}OK${textreset}"
  else
    echo "ZSH...  ${red}ERROR${textreset}"
  fi

  # MY SCRIPTS
  cp ./scripts/* ~/bin
  if [ $? -eq 0 ]; then
    echo "My scripts... ${green}OK${textreset}"
  else
    echo "My scripts...  ${red}ERROR${textreset}"
  fi

  # ATOM
  if ! command -v atom &> /dev/null; then
    echo "Atom... ${red}IS NOT FOUND${textreset}"
  else
    apm install --packages-file atom/atom-package-list.txt
    echo "Atom... ${green}OK${textreset}"
  fi

  cd - &> /dev/null;
fi
