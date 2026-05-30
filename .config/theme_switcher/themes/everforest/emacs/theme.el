(defun my/apply-theme ()
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'base16-everforest-dark-hard t)


  (set-face-attribute 'org-level-1 nil :foreground "#A7C080")
   (with-eval-after-load 'orderless
     (set-face-attribute 'orderless-match-face-0 nil
                         :foreground "#A7C080"
                         :weight 'bold)

     (set-face-attribute 'orderless-match-face-1 nil
                         :foreground "#7FBBB3"
                         :weight 'bold)

     (set-face-attribute 'orderless-match-face-2 nil
                         :foreground "#DBBC7F"
                         :weight 'bold)

     (set-face-attribute 'orderless-match-face-3 nil
                         :foreground "#D699B6"
                         :weight 'bold))

   (set-face-attribute 'completions-common-part nil
                       :foreground "#a7c080"
                       :weight 'bold)

   (set-face-attribute 'completions-first-difference nil
                       :foreground "#dbbc7f"
                       :weight 'bold)

  (setq dashboard-img
        (expand-file-name "~/.config/emacs/images/everforest.png")))
