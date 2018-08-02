#!/usr/bin/env bash

source 'scripts/colors.sh'

STATUS=${ORANGE}
SUCCESS=${LGREEN}

echo -e ${STATUS}'Running install.sh'${NC}

cp .bash_profile ~/.bash_profile
echo -e ${STATUS}'Profile Installed.'${NC}

echo -e ${STATUS}'Copying scripts to ~/bin'${NC}
mkdir -p ~/bin
for file in scripts/*; do
	if [[ -f $file ]]; then
		cp --verbose $file ~/bin/
	fi
done
echo -e ${STATUS}'Copying completed.'${NC}
echo -e ${SUCCESS}'Scripts Installation Complete.'${NC}

VIM_PATH=$(which vim)
if [ -n ${VIM_PATH} ]; then
	echo -e ${STATUS}'Detected an installed vim instance at ${VIM_PATH}'${NC}
	read -p "Do you want to install the plugins (y/n)?" -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo -e ${STATUS}'Intalling vundle'${NC}
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
		echo -e ${STATUS}'Copyting .vimrc to ~/.vimrc'${NC}
		cp -r .vimrc ~/.vimrc
		echo -e ${SUCCESS}'Copying completed.'${NC}
		echo -e ${STATUS}'Installing plugins'${NC}
		vim +PluginInstall +qall
		echo -e ${SUCCESS}'Plugin installation completed'${NC}
	fi
fi
