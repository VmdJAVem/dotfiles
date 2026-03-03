function fish_prompt --description 'Write out the prompt'
    set -l color_cwd
    set -l suffix
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix λ
    end

    # Determine the mode indicator and its color
    set -l mode_string
    set -l mode_color
    switch fish_default_mode_prompt
        case default
            set mode_color red --bold
            set mode_string N
        case insert
            set mode_color green --bold
            set mode_string I
        case replace_one
            set mode_color green --bold
            set mode_string R
        case replace
            set mode_color bryellow --bold
            set mode_string R
        case visual
            set mode_color brmagenta --bold
            set mode_string V
        case '*'
            set mode_color red --bold
            set mode_string '?'
    end

    # Print user@host and the current directory
    echo -n -s (set_color brgreen) "$USER" (set_color normal) @ (set_color blue) (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd)
    # Print the suffix (with its own color and a trailing space)
    echo -n -s "$suffix "
    set_color normal
end
