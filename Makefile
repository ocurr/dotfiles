
vim_install: vim/vimrc vim/install_vimplug.sh
	ln -f vim/vimrc ~/.vimrc
	./vim/install_vimplug.sh

hammerspoon_install: hammerspoon/init.lua hammerspoon/watcher.lua
	ln -f hammerspoon/init.lua ~/.hammerspoon/init.lua
	ln -f hammerspoon/watcher.lua ~/.hammerspoon/watcher.lua

tmux_install: tmux/tmux.conf
	ln -f tmux/tmux.conf ~/.tmux.conf

macos: vim_install tmux_install homebrew_install
	echo source $(shell pwd)/bash/macos_profile >> ~/.bash_profile

linux: vim_install tmux_install
	echo source $(shell pwd)/bash/linux_profile >> ~/.bash_aliases
