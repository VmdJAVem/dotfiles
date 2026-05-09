#
# ~/.bashrc
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
export GI_TYPELIB_PATH=/usr/local/lib/girepository-1.0
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.cargo/bin:$PATH"

[[ $- != *i* ]] && return
# Alias
alias cowsay="fortune | command cowsay -f stegosaurus"
alias dots="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
alias g++="g++ -std=c++23"
alias cbonsai="cbonsai -l 50 -i -m "
alias objdump="objdump -M intel"
alias hd="hexdump -C"
alias v="nvim"
alias ls='ls --color=auto -l'
alias grep='grep --color=auto'
alias sudo='doas'

# misc
trap 'source ~/.bashrc' USR1
export EDITOR=nvim
export VISUAL=nvim
set -o vi

if [[ -z $SSH_AUTH_SOCK ]]; then
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi

git_prompt() {
	git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

	local branch status

	branch="$(git branch --show-current 2>/dev/null)"

	if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
		status="*"
	else
		status=""
	fi

	printf '[%s%s] ' "$branch" "$status"
}
theme_color() {
	local theme
	theme="$(< ~/.config/theme_switcher/.current)"

	case "$theme" in
		everforest|gruvbox)
			printf '\e[0;32m'
			;;
		catppuccin)
			printf '\e[38;2;245;194;231m'
			;;
		*)
			printf '\e[0m'
			;;
	esac
}

PS1=' [\[$(theme_color)\]\u\[\e[0m\]@\H] $(git_prompt)[\w]\n λ '

FZF_THEME_FILE="$HOME/.config/fzf/themes/$(cat ~/.config/theme_switcher/.current 2>/dev/null)"
if [[ -f "$FZF_THEME_FILE" ]]; then
	export FZF_DEFAULT_OPTS="$(tr '\n' ' ' < "$FZF_THEME_FILE")"
fi

theme="$(< ~/.config/theme_switcher/.current)"

case "$theme" in
	catppuccin)
		# bg -> purple -> accent

		C1=$'\x1b[48;2;36;39;58m'
		C2=$'\x1b[48;2;198;160;246m'
		C3=$'\x1b[48;2;245;189;230m'

		FG1=$'\x1b[38;2;202;211;245m'
		FG2=$'\x1b[38;2;36;39;58m'
		FG3=$'\x1b[38;2;36;39;58m'

		R=$'\x1b[0m'
		;;

	everforest)
		# bg -> aqua -> green accent

		C1=$'\x1b[48;2;39;46;51m'
		C2=$'\x1b[48;2;127;187;179m'
		C3=$'\x1b[48;2;167;192;128m'

		FG1=$'\x1b[38;2;211;198;170m'
		FG2=$'\x1b[38;2;39;46;51m'
		FG3=$'\x1b[38;2;39;46;51m'

		R=$'\x1b[0m'
		;;

	gruvbox)
		# bg -> aqua -> green accent

		C1=$'\x1b[48;2;40;40;40m'
		C2=$'\x1b[48;2;104;157;106m'
		C3=$'\x1b[48;2;152;151;26m'

		FG1=$'\x1b[38;2;251;241;199m'
		FG2=$'\x1b[38;2;40;40;40m'
		FG3=$'\x1b[38;2;40;40;40m'

		R=$'\x1b[0m'
		;;
esac

echo -e "\n${C1}${FG1} it's $(date '+%-I:%M%P')  ${C2}${FG2} has been awake for: $(uptime -p | cut -c 4-) ${C3}${FG3} running: $(uname -r) ${R}"
printf "\n"
