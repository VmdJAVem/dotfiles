(defun my/apply-theme ()
  (mapc #'disable-theme custom-enabled-themes)

  (load-theme 'catppuccin t)

  (setq dashboard-img
        (expand-file-name "~/.config/emacs/images/catppuccin.png")))
