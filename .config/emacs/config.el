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

      ;; remove old themes first
      (mapc #'disable-theme custom-enabled-themes)

      ;; reload config
      (load-file user-init-file)

      (my/apply-theme)

      ;; make cursor the color of text regardless of theme
      (set-face-attribute 'cursor nil
                  :background (face-foreground 'default nil t))
      (set-face-attribute 'cursor nil
                  :background (face-foreground 'default nil t)
                  :foreground (face-background 'default nil t))
      
      ;; reapply org styling AFTER theme
      (my/org-font-setup)


      ;; refresh existing org buffers
      (dolist (buf (buffer-list))
        (with-current-buffer buf
          (when (derived-mode-p 'org-mode)
            (font-lock-flush)
            (font-lock-ensure))))

      (redraw-display)

      (message "Reloaded config"))

(defun my/frame-setup (frame)
  (with-selected-frame frame

    (my/gui-setup frame)
    (my/apply-theme)
    (my/org-font-setup)

    ;; make cursor the color of text
      (set-face-attribute 'cursor nil
                  :background (face-foreground 'default nil t))
      (set-face-attribute 'cursor nil
                  :background (face-foreground 'default nil t)
                  :foreground (face-background 'default nil t))


    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (derived-mode-p 'org-mode)
          (font-lock-flush)
          (font-lock-ensure))))

    (redraw-display)))

  (if (daemonp)
    (add-hook 'after-make-frame-functions #'my/frame-setup)
  (my/frame-setup (selected-frame)))


  (use-package catppuccin-theme
    :ensure t
    :config
    (setq catppuccin-flavor 'macchiato))

(use-package base16-theme)
  
  (use-package gruvbox-theme
    :ensure t)

  (load (expand-file-name "theme.el" user-emacs-directory) t)
  (my/apply-theme)

  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)

  (global-display-line-numbers-mode 1)
  (global-visual-line-mode -1)


(fringe-mode 0)
(add-to-list 'default-frame-alist '(internal-border-width . 0))

  (setq-default cursor-type 'bar)
  (blink-cursor-mode 0)
  
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

    ;; line numbers
    (set-face-background 'line-number
                         (face-background 'default))

    (set-face-background 'line-number-current-line
                         (face-background 'default))

    (message "gui setup ran")))

(add-to-list 'default-frame-alist
             '(font . "Iosevka Nerd Font Mono-14"))

(if (daemonp)
    (add-hook 'after-make-frame-functions #'my/gui-setup)
  (my/gui-setup (selected-frame)))

  (use-package nerd-icons)

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package doom-modeline
  :straight t
  :init
  (doom-modeline-mode 1))

(use-package minimal-dashboard
:straight (minimal-dashboard
           :type git
           :host github
           :repo "dheerajshenoy/minimal-dashboard.el")
:init
(setq initial-buffer-choice #'minimal-dashboard)
:custom
(minimal-dashboard-buffer-name "dashboard")
(minimal-dashboard-text "Emacs is a LISP environment that has a pretty-okay text editor in it.")
(minimal-dashboard-enable-resize-handling t)
(minimal-dashboard-modeline-shown nil)
:config
(setq minimal-dashboard-image-path dashboard-img)
(add-hook 'minimal-dashboard-mode-hook
          (lambda ()
            (display-line-numbers-mode -1))))

(defun my/refresh-dashboard-image ()
  (when-let* ((buf (get-buffer (minimal-dashboard--refresh-buffer-name)))
              (win (get-buffer-window buf)))
    (with-selected-window win
      (let ((inhibit-read-only t))
        (erase-buffer)
        (minimal-dashboard--insert-centered-info)))))
(add-hook 'server-after-make-frame-hook #'my/refresh-dashboard-image)

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
  "SPC" '(execute-extended-command :wk "M-x")
"/" '(consult-line :wk "search buffer")
"pf" '(consult-ripgrep :wk "ripgrep project"))

(i/leader-keys
  "f" '(:ignore t :wk "files")
  "fr" '(consult-recent-file :wk "recent files")
  "fd" '((lambda ()
            (interactive)
            (find-file "~/.config/emacs/config.org"))
          :wk "edit config.org")
  "ff" '(find-file :wk "find files"))

(i/leader-keys
  "e"  '(:ignore t :wk "eval")
  "eb" '(eval-buffer :wk "eval buffer")
  "ed" '(eval-defun :wk "eval defun containing or after point")
  "ee" '(eval-expression :wk "eval expression")
  "er" '(eval-region :wk "eval region")
  "ec" '(my/reload-config :wk "eval init.el"))

(i/leader-keys
  "w"  '(:ignore t :wk "operate on windows")

  "wh" '(windmove-left  :wk "left")
  "wj" '(windmove-down  :wk "down")
  "wk" '(windmove-up    :wk "up")
  "wl" '(windmove-right :wk "right")

  "wv" '(split-window-right :wk "vertical split")
  "ws" '(split-window-below :wk "horizontal split")

  "wd" '(delete-window :wk "delete window")
  "wo" '(delete-other-windows :wk "only window"))

(i/leader-keys
  "b"  '(:ignore t :wk "buffer")
  "bb" '(consult-buffer :wk "switch buffer")
  "bk" '(kill-buffer :wk "kill buffer")
  "bn" '(next-buffer :wk "next buffer")
  "bp" '(previous-buffer :wk "previous buffer")
  "br" '(revert-buffer :wk "reload buffer"))

(i/leader-keys
  "h" '(:ignore t :wk "help")
  "hf" '(describe-function :wk "describe function")
  "hv" '(describe-variable :wk "describe variable"))

(i/leader-keys
  "t" '(:ignore t :wk "toggle")
  "tl" '(display-line-numbers-mode :wk "toggle line numbers")
  "tt" '(toggle-truncate-lines :wk "truncate lines")
  "tv" '(vterm-toggle :wk "toggle vterm"))

(i/leader-keys
  "m" '(:ignore t :wk "org")
  "ma" '(org-agenda :wk "agenda")
  "ms" '(org-time-stamp :wk "time stamp")
  "me" '(org-export-dispatch :wk "export dispatch")
  "mi" '(org-toggle-item :wk "toggle item")
  "mt" '(org-todo :wk "todo")
  "mb" '(org-babel-tangle :wk "tangle")
  "mT" '(org-todo-list :wk "todo list"))

(require 'org-tempo)

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

    ;; keywords
    (set-face-attribute 'org-document-info-keyword nil
                        :foreground ln-color
                        :inherit 'default)

    (set-face-attribute 'org-document-title nil
                        :height 1.4
                        :foreground (face-foreground 'default nil t)
                        :inherit 'default)

    ;; line numbers
    (set-face-attribute 'line-number nil
			:background (face-background 'default nil t))
    (set-face-attribute 'line-number-current-line nil
                  :background (face-background 'default nil t))

    ;; headings
    (set-face-attribute 'org-level-1 nil
                        :height 1.25)

    (set-face-attribute 'org-level-2 nil
                        :height 1.15)

    (set-face-attribute 'org-level-3 nil
                        :height 1.10)

    ;; monospace
    (set-face-attribute 'org-block nil
                        :inherit 'fixed-pitch)

    (set-face-attribute 'org-code nil
                        :inherit 'fixed-pitch)

    (set-face-attribute 'org-table nil
                        :inherit 'fixed-pitch)

    (set-face-attribute 'org-verbatim nil
                        :inherit 'fixed-pitch)))

(add-hook 'org-mode-hook #'my/org-font-setup)

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(use-package org-appear
  :straight t   ; or :ensure t if using package.el
  :hook (org-mode . org-appear-mode)
  :init
  (setq org-hide-emphasis-markers t  ; required for autoemphasis
        org-link-descriptive t        ; required for autolinks
        org-pretty-entities t))       ; required for autosubmarkers

(use-package toc-org
  :config
  (add-hook 'org-mode-hook #'toc-org-mode))

(setq org-directory "~/notes/agenda/")
(setq org-agenda-files (directory-files-recursively "~/notes/agenda" "\.org$"))
(setq org-log-done 'time)
(setq org-todo-keywords
	'((sequence "TODO" "DOING" "DONE")))

  (use-package vertico
  :init
  (vertico-mode 1))

(use-package savehist
  :init
  (savehist-mode 1))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles partial-completion)))))

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode 1))

(use-package consult
:custom
(consult-preview-key 'any))

(use-package embark
  :bind
  (("C-." . embark-act)
   ("M-." . embark-dwim)))

(use-package embark-consult
  :after (embark consult))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook
            #'nerd-icons-completion-marginalia-setup))

(pixel-scroll-precision-mode 1)
(save-place-mode 1)
(recentf-mode 1)
(setq recentf-exclude
    '("straight/build/"
      "eln-cache/"
      "autosaves/"
      "tmp/"
      ".cache/"))
(setq enable-recursive-minibuffers t)

(use-package corfu
  :ensure t

  :init
  (global-corfu-mode)

  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-auto-prefix 1)
  (corfu-cycle t))
  (use-package cape
    :ensure t

    :init
    (add-to-list 'completion-at-point-functions #'cape-dabbrev)
    (add-to-list 'completion-at-point-functions #'cape-file))

  (defun my/corfu-capf-setup ()
    (setq-local completion-at-point-functions
                (list
                 (cape-capf-super
                  #'eglot-completion-at-point
                  #'cape-dabbrev
                  #'cape-file))))

  (add-hook 'eglot-managed-mode-hook #'my/corfu-capf-setup)

(use-package projectile
  :ensure t

  :init
  (setq projectile-project-search-path '("~/Projects/"))

  :config
  (projectile-mode 1))

(use-package vterm)

(use-package vterm-toggle
  :after vterm

  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)

  (add-to-list
   'display-buffer-alist
   '((lambda (buffer-or-name _)
       (let ((buffer (get-buffer buffer-or-name)))
         (with-current-buffer buffer
           (or (equal major-mode 'vterm-mode)
               (string-prefix-p
                vterm-buffer-name
                (buffer-name buffer))))))
     (display-buffer-reuse-window display-buffer-at-bottom)
     (reusable-frames . visible)
     (window-height . 0.3))))

(use-package eglot
:hook ((c-ts-mode . eglot-ensure)
       (c++-ts-mode . eglot-ensure)
       (lua-ts-mode . eglot-ensure))

:config
(setq eglot-server-programs
      '((c-ts-mode . ("clangd"))
        (c++-ts-mode . ("clangd"))
        (lua-ts-mode . ("lua-language-server"))))

(setq read-process-output-max (* 1024 1024)))


(setq treesit-language-source-alist
      '((c "https://github.com/tree-sitter/tree-sitter-c")
        (cpp "https://github.com/tree-sitter/tree-sitter-cpp")))

  (setq major-mode-remap-alist
        '((c-mode . c-ts-mode)
          (c++-mode . c++-ts-mode)))
  (setq treesit-font-lock-level 4)

(add-to-list 'exec-path
             (expand-file-name "~/.luarocks/bin"))

(setenv "PATH"
        (concat (expand-file-name "~/.luarocks/bin")
                path-separator
                (getenv "PATH")))

(use-package flycheck
  :defer t

  :init
  (global-flycheck-mode)

  :config
  ;; C/C++
  (setq flycheck-gcc-language-standard "c99"
        flycheck-clang-language-standard "c99"

        flycheck-gcc-warnings '("all" "extra")
        flycheck-clang-warnings '("all" "extra"))

  ;; Lua
  (setq flycheck-luacheck-args '("--lua-version" "5.4")

        flycheck-lua-luacheck-executable
        (expand-file-name "~/.luarocks/bin/luacheck")))

  (use-package lua-mode)
  ;; i'm learning, so i will not install to much stuff.
(use-package geiser
  :config
  (setq geiser-default-implementation 'guile))

(use-package geiser-guile)

(use-package paredit
  :hook (scheme-mode . paredit-mode))

  (setq-default indent-tabs-mode t)
  (setq-default tab-width 8)
  (setq-default c-basic-offset 8)

(add-hook 'c-ts-mode-hook
          (lambda ()
            (c-ts-mode-set-style 'linux)
            (setq indent-tabs-mode t
                  tab-width 8
                  c-ts-mode-indent-offset 8)))

(add-hook 'c++-ts-mode-hook
          (lambda ()
            (c-ts-mode-set-style 'linux)
            (setq indent-tabs-mode t
                  tab-width 8
                  c-ts-mode-indent-offset 8)))
  

(setq-default lua-indent-level 8)

(add-hook 'lua-mode-hook
          (lambda ()
            (setq indent-tabs-mode t
                  tab-width 8
                  lua-indent-level 8)))

(save-place-mode 1)

(setq backup-directory-alist
      `(("." . "~/.config/emacs/backups")))

(setq auto-save-file-name-transforms
      `((".*" "~/.config/emacs/autosaves/" t)))

(setq create-lockfiles nil)

(setq-default tab-width 8)
(setq-default indent-tabs-mode t)
(setq-default tab-stop-list
              (number-sequence 8 120 8))

(setq-default standard-indent 8)
(setq-default c-basic-offset 8)
(setq-default lua-indent-level 8)
(setq-default indent-tabs-mode t)

(use-package simple-httpd
  :ensure t)
