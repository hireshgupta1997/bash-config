#!/usr/bin/env bash

source 'scripts/colors.sh'
source 'utils.sh'

STATUS=${ORANGE}
SUCCESS=${LGREEN}
WARN=${LCYAN}

FORCE=${FORCE:-0}

echo -e ${STATUS}'Running install.sh'${NC}

cp .bash_profile ~/.bash_profile
echo -e ${STATUS}'Profile Installed.'${NC}

echo -e ${STATUS}'Copying scripts to ~/bin'${NC}
mkdir -p ~/bin
for file in scripts/*; do
	if [[ -f $file ]]; then
		cp $file ~/bin/
	fi
done
echo -e ${STATUS}'Copying completed.'${NC}
echo -e ${STATUS}'Adding rsub to bin folder.'${NC}
wget -O ~/bin/rsub https://raw.github.com/aurora/rmate/master/rmate && chmod a+x ~/bin/rsub
echo -e ${SUCCESS}'Scripts Installation Complete.'${NC}

VIM_PATH=$(which vim)
if [ ! -z ${VIM_PATH} ]; then
	echo -e ${STATUS}'Detected an installed vim instance at ${VIM_PATH}'${NC}
	read -p "Do you want to install the plugins (y/n)?" -n 1 -r
	if [ ! -t 1 ]; then
		REPLY=y
	fi
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo -e ${STATUS}'Intalling vundle'${NC}
		if [ -d ~/.vim/bundle/Vundle.vim ]; then
			if [ "${FORCE}" -eq "1" ]; then
				echo -e ${STATUS}'Removing existing Vundle'${NC}
				rm -rf ~/.vim/bundle/Vundle.vim
			else
				echo -e ${WARN}'Vundle already exists ...'${NC}
				echo -e ${WARN}'Run: FORCE=1 ./install.sh to re-install'${NC}
			fi
		fi
		git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
		echo -e ${STATUS}'Copying .vimrc to ~/.vimrc'${NC}
		cp -r .vimrc ~/.vimrc
		echo -e ${SUCCESS}'Copying completed.'${NC}
		echo -e ${STATUS}'Installing plugins'${NC}
		echo -e ${STATUS}'Installing YouCompleteMe'${NC}
		if [ -d ~/.vim/bundle/YouCompleteMe ]; then
			if [ "${FORCE}" -eq "1" ]; then
				echo -e ${STATUS}'Removing existing YouCompleteMe'${NC}
				rm -rf ~/.vim/bundle/YouCompleteMe
			else
				echo -e ${WARN}'YouCompleteMe  already exists ...'${NC}
				echo -e ${WARN}'Run: FORCE=1 ./install.sh to re-install'${NC}
			fi
		fi
		git clone --depth 1 --recurse-submodules https://github.com/ycm-core/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
		olddir=`pwd`
		cd ~/.vim/bundle/YouCompleteMe && python3 install.py --all
		cd $olddir
		vim +PluginInstall +qall
		echo -e ${SUCCESS}'Plugin installation completed'${NC}
	fi
fi

# Now install zsh related features
if [ -z $(which zsh) ]; then
	echo -e ${STATUS}Installing zsh ...${NC}
	if [[ is_mac ]]; then
		brew install zsh
	else
		sudo apt-get -y install zsh
	fi
	echo -e ${SUCCESS}Installed zsh. ${NC}
fi

echo -e ${STATUS}Installing oh-my-zsh ... ${NC}
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo -e ${SUCCESS}Installed oh-my-zsh. ${NC}

if [[ ! is_mac ]]; then
	echo -e ${STATUS}Installing powerline fonts ... ${NC}
	sudo apt-get -y install fonts-powerline
	echo -e ${SUCCESS}Installed powerline fonts. ${NC}
fi

echo -e ${STATUS}Installing zsh-autosuggestions ... ${NC}
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
cp customizations.zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
echo -e ${SUCCESS}Installed zsh-autosuggestions. ${NC}

echo -e ${STATUS}Installing z jump around ... ${NC}
git clone https://github.com/rupa/z.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/rupaz
echo -e ${SUCCESS}Installed z jump around. ${NC}

echo -e ${STATUS}Copying .zshrc ... ${NC}
cp .zshrc ~/.zshrc
echo -e ${SUCCESS}Copied .zshrc. ${NC}

if [[ ! is_mac ]]; then
	echo -e ${STATUS}Setting default shell to zsh... ${NC}
	chsh -s $(which zsh)
	echo -e ${SUCCESS}Completed. ${NC}
fi

echo -e ${STATUS}Configuring tmux ${NC}
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp .tmux.conf ~/.tmux.conf
echo -e ${STATUS}Configured tmux. ${NC}
