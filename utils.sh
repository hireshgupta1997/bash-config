#!/usr/env/bash

# A collection of useful functions

function is_mac() {
	if [[ "$OSTYPE" == "darwin"* ]]; then
		return true
	else
		return false
	fi
}
