(setq package-enable-at-startup nil)

(setq straight-built-in-pseudo-packages
      '(emacs nadvice python image-mode project xref flymake))

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

;; IMPORTANT
(straight-use-package 'org)
(require 'org)

(setq straight-use-package-by-default t)

(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables ...
 )

(custom-set-faces
 ;; custom-set-faces ...
 )


(org-babel-load-file
  (expand-file-name
    "config.org"
    user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("27dac7a05a4dabd15ee4fec7c881b172cb8464a11afcf3de6ffad3c61f20247a"
     "9cda0155ffd0cddac60729f5e821ba7955e1623ec7bcb12ca8e7219c33747e0f"
     default))
 '(package-vc-selected-packages
   '((minimal-dashboard :url
			"https://github.com/dheerajshenoy/minimal-dashboard.el"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
