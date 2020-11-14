#!/usr/bin/env bash
source utils.sh

if is_mac; then
	if [[ $(command -v brew) == "" ]]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	fi
	brew update
	brew install bash
	brew install cmake
	brew install tmux
	brew install gnu-sed
	brew install findutils
	brew cask install rectangle
else
	sudo apt-get install cmake python3-dev build-essential
fi
