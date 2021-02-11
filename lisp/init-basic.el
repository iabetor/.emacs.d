;; init-basic.el --- Initialize basic configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; basic configurations.
;;

;;; Code:

;; No backup files
(setq make-backup-files nil
      auto-save-default nil)

;; 记住上次打开的位置
(require 'saveplace) ;; emacs内置的包可以直接使用require不需要使用use-package
(setq-default save-place t)
(save-place-mode 1)

;; 隐藏菜单栏 工具栏 滚动条
(menu-bar-mode 0)
(tool-bar-mode 0)
(require 'scroll-bar)
(scroll-bar-mode 0)

;; 关闭出错时的提示声
(setq visible-bell t)
(setq  ring-bell-function 'ignore)

;;Auto Pair Bracket
(use-package autopair
  :defer nil
  :config (autopair-global-mode))

;; auto refresh buffer 文件被外部修改时可以自动刷新到buffer
(global-auto-revert-mode t)

(setq-default lexical-binding t)

(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no
(setq-default major-mode 'text-mode
  fill-column 80
  tab-width 4
  indent-tabs-mode nil)

;; 显示括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;Display Keybind
(use-package which-key
  :defer nil
  :config
  (progn
    (which-key-mode)
    (which-key-setup-side-window-bottom)))
    
(provide 'init-basic)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-basic.el ends here
