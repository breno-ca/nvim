install-cmake:
	sudo apt install cmake -y

install-xsel:
	sudo apt install xsel -y

install-ripgrep:
	sudo apt install ripgrep -y

install-curl:
	sudo apt install curl -y

install-hurl:
	curl --location --remote-name https://github.com/Orange-OpenSource/hurl/releases/download/$(VERSION)/hurl_$(VERSION)_amd64.deb; \
	sudo apt update && sudo apt install ./hurl_$(VERSION)_amd64.deb

install-lazygit:
	LAZYGIT_VERSION=$(shell curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*'); \
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_$${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"; \
	tar xf lazygit.tar.gz lazygit; \
	sudo install lazygit /usr/local/bin; \
	rm lazygit.tar.gz lazygit

install-nvim:
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz; \
	sudo rm -rf /opt/nvim; \
	sudo tar -C /opt -xzf nvim-linux64.tar.gz; \
	rm nvim-linux64.tar.gz; \
	if ! grep -q "/opt/nvim-linux64/bin" ~/.bashrc; then \
		sed -i '$$a\\n# Neovim PATH' ~/.bashrc; \
		sed -i '$$a\export PATH="$$PATH:/opt/nvim-linux64/bin"' ~/.bashrc; \
	fi

install-node:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash; \
	nvm install 22; \
	node -v; \
	npm -v

install-go-1.20:
	curl -Lo go.tar.gz https://go.dev/dl/go1.20.14.linux-amd64.tar.gz; \
	sudo rm -rf /usr/local/go; \
	sudo tar -C /usr/local -xzf go.tar.gz; \
	rm go.tar.gz; \
	if ! grep -q "/usr/local/go/bin" ~/.bashrc; then \
		sed -i '$$a\\n# Go PATH' ~/.bashrc; \
		sed -i '$$a\export PATH="$$PATH:/usr/local/go/bin"' ~/.bashrc; \
	fi

install-docker-rootless:

devcontainer-ubuntu-20.04:
	docker build -t nvim:ubuntu-20.04 -f ubuntu_20-04.Dockerfile

devcontainer-ubuntu-latest:
	docker build -t nvim:ubuntu-latest -f ubuntu_latest.Dockerfile
