#!/bin/bash

# COLOURIZED TERMINAL OUTPUT
textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

commit-one() {
  GIT_DIR_NAME=$1
  cd ~/.config/$GIT_DIR_NAME
  echo "Last update: $(date)" > README.md
  git add *
  git commit
  git push
  cd -
}

# MAIN
if [ "$#" -eq 0 ]; then
  echo "To stage, commit and push ${green}all${textreset} configs, use:"
  echo "        ./commit.sh all"
  echo
  echo "To stage, commit and push ${yellow}only one${textreset} config, use:"
  echo "        ./commit.sh name"
  echo "  where 'name' is the name of the directory in ~/.config folder"
  echo
elif [ "$1" = "all" ]; then
  commit-one i3
  commit-one nvim
  commit-one zsh
  commit-one alacritty
  commit-one i3status
elif [ "$#" -eq 1 ]; then
  commit-one $1
else
  echo "${red}ERROR${textreset}... Wrong script usage. Type './commit.sh without args to see help'"
fi
