#!/usr/bin/env bash

source 'scripts/colors.sh'

STATUS=${ORANGE}
SUCCESS=${LGREEN}
WARN=${LCYAN}

INSTALL_VUNDLE=${INSTALL_VUNDLE:-0}

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
if [ ! -z ${VIM_PATH} ]; then
	echo -e ${STATUS}'Detected an installed vim instance at ${VIM_PATH}'${NC}
	read -p "Do you want to install the plugins (y/n)?" -n 1 -r
	echo -e
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo -e ${STATUS}'Intalling vundle'${NC}
		if [ -d ~/.vim/bundle/Vundle.vim ]; then
			if [ "${INSTALL_VUNDLE}" -eq "1" ]; then
				echo -e ${STATUS}'Removing existing Vundle'${NC}
				rm -rf ~/.vim/bundle/Vundle.vim
			else
				echo -e ${WARN}'Vundle already exists ...'${NC}
				echo -e ${WARN}'Run: INSTALL_VUNDLE=1 ./install.sh to re-install'${NC}
			fi
		fi
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
		echo -e ${STATUS}'Copyting .vimrc to ~/.vimrc'${NC}
		cp -r .vimrc ~/.vimrc
		echo -e ${SUCCESS}'Copying completed.'${NC}
		echo -e ${STATUS}'Installing plugins'${NC}
		vim +PluginInstall +qall
		echo -e ${SUCCESS}'Plugin installation completed'${NC}
	fi
fi
