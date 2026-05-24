(mapc #'disable-theme custom-enabled-themes)
(load-theme 'gruvbox-dark-medium t)

(with-eval-after-load 'org
  (set-face-attribute 'org-level-1 nil
                      :foreground "#b8bb26"
                      :weight 'bold))

(with-eval-after-load 'display-line-numbers
  (set-face-attribute 'line-number-current-line nil
		      :foreground "#b8bb26"
		      :weight 'bold))
