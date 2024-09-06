#!/usr/bin/env bash

fix_gpg() {
	brew install gpg1
	brew upgrade gnupg  # This has a make step which takes a while
	brew link --overwrite gnupg
	brew install pinentry-mac
	echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent
}
