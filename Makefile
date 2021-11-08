
vim_install: vim/vimrc vim/install_vimplug.sh
	ln -f vim/vimrc ~/.vimrc
	./vim/install_vimplug.sh

tmux_install: tmux/tmux.conf
	ln -f tmux/tmux.conf ~/.tmux.conf

macos: vim_install tmux_install
	defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

linux: vim_install tmux_install
