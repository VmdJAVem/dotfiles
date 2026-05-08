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

PS1=' [\[$(theme_color)\]\u\[\e[0m\]@\H] $(git_prompt)[\w]\n ~> '

FZF_THEME_FILE="$HOME/.config/fzf/themes/$(cat ~/.config/theme_switcher/.current 2>/dev/null)"
if [[ -f "$FZF_THEME_FILE" ]]; then
	export FZF_DEFAULT_OPTS="$(tr '\n' ' ' < "$FZF_THEME_FILE")"
fi

# Interactive shell greeting
# if (( RANDOM % 2 == 0 )); then
# 	fastfetch
# else
# 	hyfetch
# fi

theme="$(< ~/.config/theme_switcher/.current)"
case "$theme" in
	everforest)
		FG1='\x1b[38;2;230;126;128m'; FG2='\x1b[38;2;163;190;140m'; FG3='\x1b[38;2;127;187;179m'
		BG='\x1b[48;2;55;66;57m'; R='\033[0m'
		echo -e "\n${FG1}${BG} it's $(date '+%-I:%M%P') ${FG2}${BG} up: $(uptime -p | cut -c 4-) ${FG3}${BG} $(uname -r) ${R}"
		;;
	catppuccin)
		FG1='\x1b[38;2;238;153;160m'; FG2='\x1b[38;2;198;160;246m'; FG3='\x1b[38;2;125;196;228m'
		BG='\x1b[48;2;54;58;79m'; R='\033[0m'
		echo -e "\n${FG1}${BG} it's $(date '+%-I:%M%P') ${FG2}${BG} up: $(uptime -p | cut -c 4-) ${FG3}${BG} $(uname -r) ${R}"
		;;
	gruvbox)
		FG1='\x1b[38;2;204;143;143m'; FG2='\x1b[38;2;168;153;132m'; FG3='\x1b[38;2;131;165;152m'
		BG='\x1b[48;2;60;56;54m'; R='\033[0m'
		echo -e "\n${FG1}${BG} it's $(date '+%-I:%M%P') ${FG2}${BG} up: $(uptime -p | cut -c 4-) ${FG3}${BG} $(uname -r) ${R}"
		;;
esac
