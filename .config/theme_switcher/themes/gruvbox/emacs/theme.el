(mapc #'disable-theme custom-enabled-themes)

(load-theme 'gruvbox-dark-medium t)

(set-face-attribute 'org-level-1 nil
                    :foreground "#b8bb26"
                    :weight 'bold)

(set-face-attribute 'line-number-current-line nil
                    :foreground "#b8bb26"
                    :weight 'bold)
