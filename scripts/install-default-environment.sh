#!/bin/bash

# COLOURIZED TERMINAL OUTPUT
textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)
green=$(tput setaf 2)

install_app() # requires argument
{
  if [ -n $1 ]; then
    echo "-------------------------------------------------------------------------------"
    sudo dnf install $1
  fi
}

# --- Dev tools ---
apps_to_install=(cmake cppcheck atom neovim git)

for app_name in ${apps_to_install[*]}
do
  install_app $app_name
done
