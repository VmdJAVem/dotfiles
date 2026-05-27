(mapc #'disable-theme custom-enabled-themes)
(load-theme 'everforest-hard-dark t)
(with-eval-after-load 'dired
(set-face-attribute 'dired-symlink nil
		    :foreground "#A7C080")
  )

(with-eval-after-load 'corfu

  (set-face-attribute 'corfu-default nil
                      :background "#2d353b"
                      :foreground "#d3c6aa")

  (set-face-attribute 'corfu-current nil
                      :background "#475258"
                      :foreground "#a7c080"
                      :weight 'bold)
;;; Orderless (Everforest match colors)

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

;(set-face-attribute 'completions-first-difference nil
;                    :foreground "#DBBC7F"
;                    :weight 'bold)


  (set-face-attribute 'corfu-border nil
                      :background "#475258")

  ;; popupinfo faces only if available
  (when (facep 'corfu-popupinfo)
    (set-face-attribute 'corfu-popupinfo nil
                        :background "#343f44"
                        :foreground "#d3c6aa"))

  (when (facep 'corfu-popupinfo-border)
    (set-face-attribute 'corfu-popupinfo-border nil
                        :background "#475258")))

(set-face-attribute 'completions-common-part nil
                    :foreground "#a7c080"
                    :weight 'bold)

(set-face-attribute 'completions-first-difference nil
                    :foreground "#dbbc7f"
                    :weight 'bold)
