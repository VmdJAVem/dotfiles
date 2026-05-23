(defvar bootstrap-version)

(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        user-emacs-directory))
      (bootstrap-version 6))

  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent
         'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))

  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(setq straight-use-package-by-default t)

(use-package base16-theme
  :straight t)

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-vsplit-window-right t
        evil-split-window-below t)

  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil

  :config
  (setq evil-collection-mode-list '(dired ibuffer))
  (evil-collection-init))

(defun my/reload-config ()
(interactive)
(load-file user-init-file))

(defun my/org-babel-tangle-config ()
  (when (string-equal
         (file-truename (buffer-file-name))
         (file-truename "~/.config/emacs/config.org"))

    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'after-save-hook
                      #'my/org-babel-tangle-config
                      nil
                      t)))

(use-package which-key
  :init
  (which-key-mode 1)

  :config
  (setq which-key-idle-delay 0.5))

(use-package general
  :config
  (general-evil-setup)

  (general-create-definer i/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")

  (i/leader-keys
    "e"  '(:ignore t :which-key "eval")
    "eb" '(eval-buffer :which-key "eval buffer")
    "ed" '(eval-defun :which-key "eval defun containing or after point")
    "ee" '(eval-expression :which-key "eval expression")
    "er" '(eval-region :which-key "eval region")
    "ec" '(my/reload-config :which-key "eval init.el")
    
    "b"  '(:ignore t :which-key "buffer")
    "bb" '(switch-to-buffer :which-key "switch buffer")
    "bk" '(kill-buffer-and-window :which-key "kill buffer")
    "bn" '(next-buffer :which-key "next buffer")
    "bp" '(previous-buffer :which-key "previous buffer")
    "br" '(revert-buffer :which-key "reload buffer")
    ))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode 1)

(defun my/gui-setup (frame)
  (with-selected-frame frame

    ;; theme
    (load (expand-file-name "theme.el"
                            user-emacs-directory)
          t)

    ;; fonts
    (set-face-attribute 'default nil
                        :font "Iosevka Nerd Font Mono"
                        :height 175)

    (set-face-attribute 'variable-pitch nil
                        :font "Iosevka Nerd Font Propo"
                        :height 175)

    (set-face-attribute 'fixed-pitch nil
                        :font "Iosevka Nerd Font Mono"
                        :height 175)

    ;; italics
    (set-face-attribute 'font-lock-comment-face nil
                        :slant 'italic)

    (set-face-attribute 'font-lock-keyword-face nil
                        :slant 'italic)

    ;; line number background
    (set-face-background 'line-number
                         (face-background 'default))

    (set-face-background 'line-number-current-line
                         (face-background 'default))))
;; daemon support
(if (daemonp)
    (add-hook 'after-make-frame-functions #'my/gui-setup)
  (my/gui-setup (selected-frame)))

;; emacsclient default font
(add-to-list 'default-frame-alist
             '(font . "Iosevka Nerd Font Mono-14"))

(defun my/org-font-setup ()
  ;; document metadata
  (set-face-attribute 'org-document-title nil
                      :height 1.0
                      :weight 'normal)

  ;; #+TITLE: #+AUTHOR: etc
  (set-face-attribute 'org-meta-line nil
                      :height 0.9
                      :weight 'normal
                      :inherit 'fixed-pitch)

  ;; headings
  (set-face-attribute 'org-level-1 nil
                      :height 1.25
                      :weight 'bold)

  (set-face-attribute 'org-level-2 nil
                      :height 1.15
                      :weight 'bold)

  (set-face-attribute 'org-level-3 nil
                      :height 1.10
                      :weight 'bold)

  (set-face-attribute 'org-level-4 nil
                      :height 1.5
                      :weight 'bold)

  (set-face-attribute 'org-level-5 nil
                      :height 1
                      :weight 'bold)

  (set-face-attribute 'org-level-6 nil
                      :height 1
                      :weight 'bold)

  ;; keep code blocks/tables monospace
  (set-face-attribute 'org-block nil
                      :inherit 'fixed-pitch)

  (set-face-attribute 'org-code nil
                      :inherit 'fixed-pitch)

  (set-face-attribute 'org-table nil
                      :inherit 'fixed-pitch)

  (set-face-attribute 'org-verbatim nil
                      :inherit 'fixed-pitch))

(add-hook 'org-mode-hook #'my/org-font-setup)
