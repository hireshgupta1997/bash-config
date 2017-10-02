#!/usr/bin/env bash

source 'scripts/colors.sh'

echo -e ${ORANGE}'Running install.sh'${NC}

mkdir -p ~/bin
echo -e ${LBLUE}'Copying scripts to ~/bin'${NC}
for file in scripts/*.sh ; do
    cp $file ~/bin/ && echo -e "Copied $file"
done

cp .bash_profile ~/.bash_profile
echo -e ${LGREEN}'Scripts Installation Complete.'${NC}
