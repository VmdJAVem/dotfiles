# Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# --- Aliases ---
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias clock="tty-clock -c -s -b -f "%H:%M:%S" -C 3 -B "#6a2c8d" -t"
alias cowsay="fortune | command cowsay -f stegosaurus"
alias config="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
alias vim="nvim"
alias g++="g++ -std=c++23"
alias cbonsai="cbonsai -l 50 -i -m "
alias xmrig="sudo xmrig -c .config/xmrig.json"
alias objdump="objdump -M intel"
alias hd="hexdump -C"
alias ytdow='yt-dlp -x --audio-format mp3 \
  --add-metadata \
  --embed-thumbnail \
  --parse-metadata "%(artist)s - %(title)s:%(title)s"'
# plugins
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light zsh-users/zsh-completions
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

if [[ -z $SSH_AUTH_SOCK ]]; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi

if [[ -o interactive ]]; then
    if (( RANDOM % 2 == 0 )); then
        fastfetch
    else
        hyfetch
    fi
fi

eval "$(starship init zsh)"
FZF_THEME_FILE="$HOME/.config/fzf/themes/$(cat ~/.config/theme_switcher/.current 2>/dev/null)"

[ -f "$FZF_THEME_FILE" ] && \
export FZF_DEFAULT_OPTS="$(tr '\n' ' ' < "$FZF_THEME_FILE")"
# PATH
export PATH="$HOME/.npm-global/bin:$PATH"
export GI_TYPELIB_PATH=/usr/local/lib/girepository-1.0
[ -f "/home/arkar/.ghcup/env" ] && . "/home/arkar/.ghcup/env" # ghcup-env

# Created by `pipx` on 2026-03-20 01:51:31
export PATH="$PATH:/home/arkar/.local/bin"


export PATH="$HOME/.cargo/bin:$PATH"

# opencode
export PATH=/home/arkar/.opencode/bin:$PATH
