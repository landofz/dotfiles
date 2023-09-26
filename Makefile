default:
	@echo Please specify target
.PHONY: default

bash:
	mkdir -p $(HOME)/.config
	stow -t $(HOME) bash
.PHONY: bash

fzf:
	mkdir -p $(HOME)/.config/fzf
	stow -t $(HOME) fzf
.PHONY: fzf

xdg:
	mkdir -p $(HOME)/.config
	stow -t $(HOME) xdg
.PHONY: xdg

urxvt:
	mkdir -p $(HOME)/.local/share/applications
	stow -t $(HOME) urxvt
.PHONY: urxvt
