if status is-interactive
    # Commands to run in interactive sessions can go here

    # disable XON/XOFF flow control
    stty -ixon
    # disable sending of start/stop characters
    stty -ixoff

    # share goto database with bash
    set -g -x GOTO_DB $HOME/.config/goto
    # colored man pages
    set -g -x MANPAGER "sh -c 'col -bx | bat -l man --theme Monokai\ Extended --plain'"
    set -g -x MANROFFOPT "-c"
    # set preferred shell to fish
    set -g -x SHELL "$(status fish-path)"

    # ps
    abbr -a psvim 'ps aux | grep -v grep | grep vim'
    function psbg
        ps aux | grep "pts/[0-9]\+ \+T" | grep -v grep
    end
    function psfg
        ps aux | grep pts | grep -v "[/-]fish\$" | grep "+" | grep -v tmux | grep -v grep | grep -v "ps aux"
    end
    abbr -a psall 'echo "--- BG ---"; psbg; echo "--- FG ---"; psfg'
    # cofig edit
    abbr -a vibash      "\$EDITOR \$HOME/.bashrc"
    abbr -a vii3        "cd \$HOME/.config/i3 && \$EDITOR config"
    abbr -a vitmux      "\$EDITOR \$HOME/.tmux.conf"
    abbr -a vialacritty "\$EDITOR \$HOME/.config/alacritty/alacritty.toml"
    abbr -a vimutt      "cd \$HOME/.config/mutt && \$EDITOR muttrc"
    abbr -a vivim       "cd \$HOME/.config/nvim && \$EDITOR init.lua"
    # ls
    abbr -a ll 'exa -lg'
    abbr -a la 'exa -a'
    abbr -a lt 'exa --tree'
    # git
    abbr -a gcm  'git commit'
    abbr -a gdf  'git diff'
    abbr -a gdm  'git diff master'
    abbr -a glm  'git log master..'
    abbr -a gdo  'git diff origin/$(git rev-parse --abbrev-ref HEAD)'
    abbr -a gds  'git diff --staged'
    abbr -a gst  'git status'
    abbr -a gbv  'git branch -vv'
    abbr -a gpf  'git push --force-with-lease'
    abbr -a gun  'git add -A && git commit -m "Update notes"'
    abbr -a gad  'git status | fpp -c "git add"'
    abbr -a grh  'git status | fpp -c "git reset HEAD"'
    abbr -a gco  'git status | fpp -c "git checkout"'
    abbr -a gadp 'git status | fpp -c "git add -p"'
    abbr -a grs  'git status | fpp -c "git restore"'
    # general
    abbr -a bat "bat -n"
    abbr -a dpss 'docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"'
    abbr -a yt 'YTFZF_PLAYER=/usr/bin/mpv YTFZF_PLAYER_FORMAT="/usr/bin/mpv --ytdl-format=" ytfzf -f'

    if test -f "$HOME/.config/fish/local.fish"
        source "$HOME/.config/fish/local.fish"
    end

    # vim-like cursors
    # set -g fish_key_bindings fish_vi_key_bindings
    # set -g fish_cursor_default block blink
    # set -g fish_cursor_insert line blink
    # set -g fish_cursor_replace_one underscore blink
    # set -g fish_cursor_visual block blink

    complete -c up -fa "(_up)"
    # source $HOME/lib/up/up.fish
    fzf --fish | source
    starship init fish | source
    direnv hook fish | source
    atuin init fish | source
    # atuin init fish --disable-up-arrow | source
end
