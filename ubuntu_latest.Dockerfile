# EXPERIMENTAL
# Execução do neovim em um container 
FROM ubuntu:latest

# Instala as seguintes dependências:
# git: 			para versionamento
# make:			para build de plugins 
# cmake:		para build de plugins
# ripgrep:		para live grep nos projetos
# curl:			para baixar o neovim e lazygit
# lazygit:		para dinamizar os processos git
RUN apt update; apt upgrade; \
	apt install git -y; \			
	apt install make -y; \		
	apt install cmake -y; \			
	apt install ripgrep -y; \		
	apt install curl -y; \			
	curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz; \
	rm -rf /opt/nvim; tar -C /opt -xzf nvim-linux64.tar.gz; \
	sed -i '$a\export PATH="$PATH:/opt/nvim-linux64/bin"' ~/.bashrc; \
	curl -LO https://go.dev/dl/go1.20.13.linux-amd64.tar.gz; \
	rm -rf /usr/local/go; tar -C /usr/local -xzf go1.20.13.linux-amd64.tar.gz; \
	sed -i '$a\export PATH="$PATH:/usr/local/go/bin"' ~/.bashrc; \
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*'); \
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"; \
	tar xf lazygit.tar.gz lazygit; \
	install lazygit /usr/local/bin

COPY . /root/.config/nvim/
