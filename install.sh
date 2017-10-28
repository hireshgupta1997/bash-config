#!/usr/bin/env bash

source 'scripts/colors.sh'

echo -e ${ORANGE}'Running install.sh'${NC}

cp .bash_profile ~/.bash_profile
echo -e ${ORANGE}'Profile Installed.'${NC}

echo -e ${ORANGE}'Copying scripts to ~/bin'${NC}
mkdir -p ~/bin
for file in scripts/*; do
	if [[ -f $file ]]; then
		cp --verbose $file ~/bin/
	fi
done
echo -e ${ORANGE}'Copying completed.'${NC}
echo -e ${LGREEN}'Scripts Installation Complete.'${NC}
