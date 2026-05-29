(defun my/apply-theme ()

  (load-theme 'gruvbox-dark-medium t)

  (set-face-attribute 'org-level-1 nil
                      :foreground "#b8bb26"
                      :weight 'bold)

  (set-face-attribute 'line-number-current-line nil
                      :foreground "#b8bb26"
                      :weight 'bold)

  (with-eval-after-load 'orderless
    (dolist (face '(orderless-match-face-0
                    orderless-match-face-1
                    orderless-match-face-2
                    orderless-match-face-3))
      (set-face-attribute face nil
                          :foreground "#b8bb26"
                          :weight 'bold)))

  (setq dashboard-img
        (expand-file-name "~/.config/emacs/images/gruvbox.png")))
