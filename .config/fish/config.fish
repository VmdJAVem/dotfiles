# ~/.config/fish/config.fish

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias clock='tty-clock -c -s -b -f "%H:%M:%S" -C 3 -B "#6a2c8d" -t'
alias cowsay='fortune | command cowsay -f stegosaurus'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias cd='z'
alias vim='nvim'
alias pdf='zpdf $(fzf)'
alias g++="g++ -std=c++23"
alias cbonsai="cbonsai -l 50 -i -m "
alias xmrig="sudo xmrig -c .config/xmrig.json"
alias objdump='objdump -M intel'
alias hd="hexdump -C"
set EDITOR = nvim
function fish_greeting
    fortune -s
end
# Prompt customization
function fish_prompt
    echo -n " λ "
    if test (pwd) = $HOME
        echo -n "~"
        echo -n " "
    else
        echo -n (basename (pwd))
        set_color normal
        echo -n " "
    end
end

# fzf key bindings and fuzzy completion
fzf --fish | source

# PATH configuration
set -gx PATH $PATH $HOME/.local/bin
# pdfs
function zpdf
    for file in $argv
        nohup sioyek "$file" >/dev/null 2>&1 &
    end
end
function catfetch
    set stamp (date +%s)
    kitget --square -o "/tmp/kitget-$stamp"
    clear
    fastfetch --kitty "/tmp/kitget-$stamp" $argv
    rm -f "/tmp/kitget-$stamp"
end
#zoxide
zoxide init fish | source

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
#command Prompt
#fetch
hyfetch
if not set -q SSH_AUTH_SOCK
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end
fish_vi_key_bindings
set -g fish_cursor_insert line

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin $PATH /home/arkar/.ghcup/bin # ghcup-env
