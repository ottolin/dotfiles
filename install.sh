#!/bin/bash
CUR_DIR=`pwd`
FILES=( ".gitconfig" ".doom.d" ".spacemacs" ".tmux.conf" ".vimrc" ".nvimrc" ".wezterm.lua")
#echo $CUR_DIR
echo "Installing dot files to home directory..."
cd ~
for f in "${FILES[@]}"
do
  link="$CUR_DIR/$f"
  ln -sf $link
done

mkdir -p .config
cd .config
ln -sf $CUR_DIR/nvim
echo "Done."
