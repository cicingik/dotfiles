#!/usr/bin/env bash

omz() {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}


homebrew() {
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}


kubectl() {
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl"
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl.sha256"

	echo "$(cat kubectl.sha256)  kubectl" | shasum -a 256 --check
	chmod +x ./kubectl

	sudo mv ./kubectl ~/bin/kubectl
	sudo chown root: ~/bin/kubectl

	curl -LO https://rawgit.com/kubermatic/fubectl/master/fubectl.source
}


krew() {
	(
	set -x; cd "$(mktemp -d)" &&
	OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
	ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
	KREW="krew-${OS}_${ARCH}" &&
	curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
	tar zxvf "${KREW}.tar.gz" &&
	./"${KREW}" install krew
	)
}


nvm() {
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
}


diff_so_fancy() {
	mkdir -p ~/bin
	cd ~/bin

	git clone https://github.com/so-fancy/diff-so-fancy diffsofancy
	chmod +x diffsofancy/diff-so-fancy
	ln -s ~/bin/diffsofancy/diff-so-fancy ~/bin/diff-so-fancy
}
