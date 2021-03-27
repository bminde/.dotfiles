DOTFILES := .vimrc .bashrc .tmux.conf .gitconfig

all: unlink link

unlink:
	@$(foreach file,$(DOTFILES),rm -f ~/$(file);)
	@echo "Removed symlinks"

link:
	@$(foreach file,$(DOTFILES),ln -s $(CURDIR)/$(file) ~/$(file);)
	@echo "Created symlinks"

.PHONY: all unlink link
