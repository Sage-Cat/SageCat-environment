#!/bin/bash

# COLOURIZED TERMINAL OUTPUT
textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

setup-one() {
  DIR_NAME=$1
  GIT_URL=$2
  
  mkdir -p ~/config/$DIR_NAME
  cd ~/config/$DIR_NAME
  if [ $? -eq 0 ]; then
    rm -rf *

    git init
    git remote add origin $GIT_URL
    git fetch
    git reset origin/master  # if git already inited
    git checkout -t origin/master
  fi
}

# MAIN
if [ "$#" -eq 0 ]; then
  echo "To stage, commit and push ${green}all${textreset} configs, use:"
  echo "        ./setup.sh all"
  echo
  echo "To stage, commit and push ${yellow}only one${textreset} config, use:"
  echo "        ./setup.sh name GIT_URL"
  echo "  where 'name' is the future name of the directory in ~/.config folder"
  echo
elif [ "$1" = "all" ]; then
  setup-one i3 https://github.com/Sage-Cat/i3-config.git
  setup-one nvim https://github.com/Sage-Cat/nvim-config.git
  setup-one zsh https://github.com/Sage-Cat/zsh-config.git
  setup-one alacritty https://github.com/Sage-Cat/alacritty-config.git
  setup-one i3status https://github.com/Sage-Cat/i3status-config.git 
elif [ "$#" -eq 1 ]; then
  commit-one $1
else
  echo "${red}ERROR${textreset}... Wrong script usage. Type './commit.sh without args to see help'"
fi

