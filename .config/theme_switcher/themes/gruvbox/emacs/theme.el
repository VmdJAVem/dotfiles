(mapc #'disable-theme custom-enabled-themes)

(load-theme 'gruvbox-dark-medium t)

(set-face-attribute 'org-level-1 nil
                    :foreground "#b8bb26"
                    :weight 'bold)

(set-face-attribute 'line-number-current-line nil
                    :foreground "#b8bb26"
                    :weight 'bold)
(with-eval-after-load 'orderless

  (set-face-attribute 'orderless-match-face-0 nil
                      :foreground "#b8bb26"
                      :weight 'bold)

  (set-face-attribute 'orderless-match-face-1 nil
                      :foreground "#b8bb26"
                      :weight 'bold)

  (set-face-attribute 'orderless-match-face-2 nil
                      :foreground "#b8bb26"
                      :weight 'bold)

  (set-face-attribute 'orderless-match-face-3 nil
                      :foreground "#b8bb26"
                      :weight 'bold))
