export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
export GI_TYPELIB_PATH=/usr/local/lib/girepository-1.0
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.cargo/bin:$PATH"

# Only continue for interactive shells
[[ -o interactive ]] || return

# Aliases
alias cowsay='fortune | command cowsay -f stegosaurus'
alias dots='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias g++='g++ -std=c++23'
alias cbonsai='cbonsai -l 50 -i -m'
alias objdump='objdump -M intel'
alias hd='hexdump -C'
alias v='nvim'
alias ls='ls --color=always -l'
alias grep='grep --color=auto'

# Misc
TRAPUSR1() {
	source ~/.zshrc
}

export EDITOR=nvim
export VISUAL=nvim

# vi mode
bindkey -v

function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
	   [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q' # block cursor
	else
		echo -ne '\e[5 q' # beam cursor
	fi
}

zle -N zle-keymap-select

function zle-line-init {
	echo -ne '\e[5 q'
}

zle -N zle-line-init

echo -ne '\e[5 q'

if [[ -z $SSH_AUTH_SOCK ]]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

git_prompt() {
	git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

	local branch
	local gitstatus=""

	branch="$(git branch --show-current 2>/dev/null)"

	if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
		gitstatus="*"
	else
		gitstatus=""
	fi

	printf '[%s%s] ' "$branch" "$gitstatus"
}

theme_color() {
	local theme
	theme="$(< ~/.config/theme_switcher/.current)"

	case "$theme" in
		gruvbox)
			printf '\e[0;32m'
			;;
		everforest)
			printf '\e[1;32m'
			;;
		catppuccin)
			printf '\e[38;2;245;194;231m'
			;;
		*)
			printf '\e[0m'
			;;
	esac
}

setopt PROMPT_SUBST

PROMPT=' [$(theme_color)%n%f@%m] $(git_prompt)[%~]
 λ '

FZF_THEME_FILE="$HOME/.config/fzf/themes/$(cat ~/.config/theme_switcher/.current 2>/dev/null)"

if [[ -f "$FZF_THEME_FILE" ]]; then
	export FZF_DEFAULT_OPTS="$(tr '\n' ' ' < "$FZF_THEME_FILE")"
fi
cowsay
