;; init-basic.el --- Initialize basic configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; basic configurations.
;;

;;; Code:

;;(setq enable-recursive-minibuffers t)

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

(setq kill-ring-max 200)
(setq kill-do-not-save-duplicates t);不向kill-ring中加入重复内容
(setq kill-read-only-ok t)

(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no     

;; 记住上次打开的位置
(require 'saveplace)
(setq-default save-place t)
(save-place-mode 1)

;;Display Keybind
(use-package which-key
  :ensure t
  :config
  (progn
    (which-key-mode)
    (which-key-setup-side-window-bottom)))

;;Auto Pair Bracket
(use-package autopair
  :ensure t
  :config (autopair-global-mode))

(provide 'init-basic)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-basic.el ends here