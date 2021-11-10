#!/bin/bash
CUR_DIR=`pwd`
FILES=( ".gitconfig" ".doom.d" ".spacemacs" ".tmux.conf" ".vimrc" ".nvimrc")
#echo $CUR_DIR
echo "Installing dot files to home directory..."
cd ~
for f in "${FILES[@]}"
do
  link="$CUR_DIR/$f"
  ln -sf $link
done
echo "Done."
