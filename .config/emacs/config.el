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

(use-package catppuccin-theme
  :ensure t
  :config
  (setq catppuccin-flavor 'macchiato))  ; 'latte, 'frappe, 'macchiato, or 'mocha

(straight-use-package 
  '(everforest :type git :host github :repo "Theory-of-Everything/everforest-emacs"))

(use-package gruvbox-theme
  :ensure t)

(load (expand-file-name "theme.el" user-emacs-directory) t)

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
(defun my/reload-config ()
  (interactive)

  (org-babel-tangle-file
   (expand-file-name "config.org" user-emacs-directory))

  (load-file user-init-file)

  (load (expand-file-name "theme.el" user-emacs-directory) t)

  (my/gui-setup (selected-frame))
  (my/org-font-setup)

  (message "Reloaded config"))

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
    :global-prefix "M-SPC"))

(i/leader-keys
  "c" '(comment-line :wk "comment line")
  "SPC" '(counsel-M-x :wk "M-x"))

(i/leader-keys
  "f" '(:ignore t :wk "files")
  "fr" '(counsel-recentf :wk "recent files")
  "fd" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "edit config.org")
  "ff" '(find-file :wk "find files"))

(i/leader-keys
        "e"  '(:ignore t :wk "eval")
        "eb" '(eval-buffer :wk "eval buffer")
        "ed" '(eval-defun :wk "eval defun containing or after point")
        "ee" '(eval-expression :wk "eval expression")
        "er" '(eval-region :wk "eval region")
        "ec" '(my/reload-config :wk "eval init.el"))

(i/leader-keys
        ;; windows
        "w"  '(:ignore t :wk "operate on windows")

        ;; movement
        "wh" '(windmove-left  :wk "left")
        "wj" '(windmove-down  :wk "down")
        "wk" '(windmove-up    :wk "up")
        "wl" '(windmove-right :wk "right")

        ;; splits
        "wv" '(split-window-right  :wk "vertical split")
        "ws" '(split-window-below  :wk "horizontal split")

        ;; delete
        "wd" '(delete-window       :wk "delete window")
        "wo" '(delete-other-windows :wk "only window"))

(i/leader-keys
        "b"  '(:ignore t :wk "buffer")
        "bb" '(switch-to-buffer :wk "switch buffer")
        "bk" '(kill-buffer :wk "kill buffer")
        "bn" '(next-buffer :wk "next buffer")
        "bp" '(previous-buffer :wk "previous buffer")
        "br" '(revert-buffer :wk "reload buffer"))

(i/leader-keys
  "h" '(:ignore t :wk "help")
  "hf" '(describe-function :wk "describe function")
  "hv" '(describe-variable :wk "describe variable")
  )

(i/leader-keys
  "t" '(:ignore t :wk "toggle")
  "tl" '(display-line-numbers-mode :wk "toggle line numbers")
  "tt" '(toggle-truncate-lines :wk "truncate lines")
  "tv" '(vterm-toggle :wk "toggle vterm"))

(i/leader-keys
  "m" '(:ignore t :wk "org")
  "ma" '(org-agenda :wk "agenda")
  "me" '(org-export-dispatch :wk "export dispatch")
  "mi" '(org-toggle-item :wk "toggle item")
  "mt" '(org-todo :wk "todo")
  "mb" '(org-babel-tangle :wk "tangle")
  "mT" '(org-todo-list :wk "todo list")
)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
;; line truncation
(global-display-line-numbers-mode 1)
;; disable wrapping globally
(global-visual-line-mode -1)
(setq-default truncate-lines t)
(setq-default word-wrap nil)

(defun my/gui-setup (frame)
  (with-selected-frame frame
    ;; fonts
    (set-face-attribute 'default nil
                        :family "Iosevka Nerd Font Mono"
                        :height 140)

    (set-face-attribute 'variable-pitch nil
                        :family "Iosevka Nerd Font Propo"
                        :height 140)

    (set-face-attribute 'fixed-pitch nil
                        :family "Iosevka Nerd Font Mono"
                        :height 140)

    ;; italics
    (set-face-attribute 'font-lock-comment-face nil
                        :slant 'italic)

    (set-face-attribute 'font-lock-keyword-face nil
                        :slant 'italic)

    ;; line number background
    (set-face-background 'line-number
                         (face-background 'default))

    (set-face-background 'line-number-current-line
                         (face-background 'default))

(message "gui setup ran")))

;; frame defaults for daemon/emacsclient
(add-to-list 'default-frame-alist
             '(font . "Iosevka Nerd Font Mono-14"))

;; daemon support
(if (daemonp)
    (add-hook 'after-make-frame-functions #'my/gui-setup)
  (my/gui-setup (selected-frame)))

(require 'org-tempo)

;; stop weird indent
(electric-indent-mode -1)



(defun my/org-font-setup ()

  (let ((ln-color (face-foreground 'line-number nil t)))
    ;; title
    (set-face-attribute 'org-document-title nil
			:foreground ln-color
			:inherit 'default
			:height 1.0
			:weight 'normal)

    ;; author/date
    (set-face-attribute 'org-document-info nil
			:foreground ln-color
			:inherit 'default
			:weight 'normal)

    ;; #+TITLE: #+AUTHOR:
    (set-face-attribute 'org-document-info-keyword nil
			:foreground ln-color
			:inherit 'default)

    ;; #+begin_src etc
    (set-face-attribute 'org-meta-line nil
			:foreground ln-color
			:height 0.9
			:weight 'normal
			:inherit 'fixed-pitch))

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

  ;; monospace
  (set-face-attribute 'org-block nil
                      :inherit 'fixed-pitch)

  (set-face-attribute 'org-code nil
                      :inherit 'fixed-pitch)

  (set-face-attribute 'org-table nil
                      :inherit 'fixed-pitch)

  (set-face-attribute 'org-verbatim nil
                      :inherit 'fixed-pitch))

(add-hook 'org-mode-hook #'my/org-font-setup)

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package  org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package toc-org
  :config
  (add-hook 'org-mode-hook #'toc-org-mode))

;; backup files
(setq backup-directory-alist
      `(("." . "~/.config/emacs/backups")))

;; auto-save files
(setq auto-save-file-name-transforms
      `((".*" "~/.config/emacs/autosaves/" t)))

(setq create-lockfiles nil)

(setq-default tab-width 8)        ;; display width of TAB characters
(setq-default indent-tabs-mode t) ;; use real TAB characters
(setq-default tab-stop-list (number-sequence 8 120 8))

(setq-default standard-indent 8)
(setq-default c-basic-offset 8)
(setq-default lua-indent-level 8)
(setq-default indent-tabs-mode t)

(use-package ivy
  :ensure t
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  (enable-recursive-minibuffers t)
  :config
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :after ivy
  :config
  (counsel-mode 1))

(use-package ivy-rich
  :after ivy
  :config
  (setq ivy-virtual-abbreviate 'full
        ivy-rich-switch-buffer-align-virtual-buffer t
        ivy-rich-path-style 'abbrev)
  (ivy-rich-mode 1))

(use-package all-the-icons-ivy-rich
  :ensure t
  :after ivy-rich
  :config
  (all-the-icons-ivy-rich-mode 1))

(use-package all-the-icons
:if (display-graphic-p))
(use-package all-the-icons-dired
:hook (dired-mode . all-the-icons-dired-mode))

(use-package vterm)

(use-package vterm-toggle
:after vterm
:config
(setq vterm-toggle-fullscreen-p nil)
(setq vterm-toggle-scope 'project)
(add-to-list 'display-buffer-alist
             '((lambda (buffer-or-name _)
                   (let ((buffer (get-buffer buffer-or-name)))
                     (with-current-buffer buffer
                       (or (equal major-mode 'vterm-mode)
                           (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                (display-buffer-reuse-window display-buffer-at-bottom)
                ;;(display-buffer-reuse-window display-buffer-in-direction)
                ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                ;;(direction . bottom)
                ;;(dedicated . t) ;dedicated is supported in emacs27
                (reusable-frames . visible)
                (window-height . 0.3))))

(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '("~/Projects/"))
  :config
  (projectile-mode 1))

(use-package dashboard
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "hello.")
  (setq dashboard-center-content t)

  (setq dashboard-projects-backend 'projectile)

  (setq dashboard-items '((recents . 5)
                          (agenda . 5)
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))

  :config
  (dashboard-setup-startup-hook))

(require 'eglot)

(add-to-list 'eglot-server-programs
             '((c-mode c++-mode c-ts-mode c++-ts-mode)
               . ("clangd"
                  "--background-index"
                  "--clang-tidy"
                  "--completion-style=detailed"
                  "--header-insertion=never")))

(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)

(add-hook 'c-ts-mode-hook #'eglot-ensure)
(add-hook 'c++-ts-mode-hook #'eglot-ensure)
