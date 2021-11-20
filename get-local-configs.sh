#!/bin/bash

# COLOURIZED TERMINAL OUTPUT
textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

get_environment_from_current_os()
{
  # NEOVIM
  if [ -d ~/.config/nvim ]; then
    rm -rf nvim/* &> /dev/null
    files_to_copy=$(find ~/.config/nvim -type d -name 'autoload' -prune -o -type f -print)
    for file in ${files_to_copy[*]}
    do
      cp -r $file ./nvim/;
    done
    echo "Neovim... ${green}OK${textreset}"
  else
    echo "Neovim...     ${yellow}CONFIG IS NOT FOUND, OLD VERSION LEFT${textreset}"
  fi

  # ALACRITTY
  if [ -d ~/.config/alacritty ]; then
    rm -rf alacritty &> /dev/null;
    cp -r ~/.config/alacritty ./alacritty;
    echo "Alacritty... ${green}OK${textreset}"
  else
    echo "Alacritty...     ${yellow}CONFIG IS NOT FOUND, OLD VERSION LEFT${textreset}"
  fi

  # ZSH
  if [ -f ~/.zshrc ]; then
    rm -f zshrc &> /dev/null;
    cp ~/.zshrc ./zshrc;
    echo "ZSH... ${green}OK${textreset}"
  else
    echo "ZSH...     ${yellow}CONFIG IS NOT FOUND, OLD VERSION LEFT${textreset}"
  fi

  # MY SCRIPTS
  if [ -d ~/bin ]; then
    rm -rf scripts/* &> /dev/null;
    cp ~/bin/*.sh ./scripts;
    echo "My scripts... ${green}OK${textreset}"
  else
    echo "My scripts... ${yellow}IS NOT FOUND, OLD VERSION LEFT${textreset}"
  fi

  # ATOM
  if ! command -v atom &> /dev/null; then
    echo "Atom... ${yellow}IS NOT FOUND, OLD VERSION LEFT${textreset}"
  else
    rm -f atom/atom-package-list.txt
    apm list --installed --bare > atom/atom-package-list.txt
    echo "Atom... ${green}OK${textreset}"
  fi

  # README
  rm -f README.md &> /dev/null;
  echo "SageCat-Environment <br/>  Version for: $(date)" >> README.md

  cd - &> /dev/null;
}

if [ -d ~/Git/sagecat-environment ]; then
  cd ~/Git/sagecat-environment
  get_environment_from_current_os
else
  echo "Git repository is ${red}NOT FOUND${textreset}"
fi
