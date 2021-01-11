;; init-basic.el --- Initialize basic configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; basic configurations.
;;

;;; Code:

(setq enable-recursive-minibuffers t)

(setq-default major-mode 'text-mode
  fill-column 80
  tab-width 4
  indent-tabs-mode nil)

(if (fboundp 'display-line-numbers-mode)
(use-package display-line-numbers
      :ensure nil
      :hook (prog-mode . display-line-numbers-mode))
  (use-package linum-off
    :ensure t
    :demand
    :defines linum-format
    :hook (after-init . global-linum-mode)
    :init (setq linum-format "%4d ")
    :config
    ;; Highlight current line number
    (use-package hlinum
      :defines linum-highlight-in-all-buffersp
      :custom-face (linum-highlight-face ((t (:inherit default :background nil :foreground nil))))
      :hook (global-linum-mode . hlinum-activate)
      :init (setq linum-highlight-in-all-buffersp t))))

(provide 'init-basic)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-basic.el ends here