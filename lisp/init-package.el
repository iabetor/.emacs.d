;; init-package.el --- Initialize package configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; package configurations.
;;

;;; Code:

(setq package-archives
      '(("gnu"    . "http://elpa.emacs-china.org/gnu/")
        ("melpa"  . "http://elpa.emacs-china.org/melpa/")))

;; Initialize packages
(unless (bound-and-true-p package--initialized) ;; To avoid warnings in 27
  (setq package-enable-at-startup nil)          ;; To prevent initializing twice
  (package-initialize));; 刷新软件源索引

;; Setup use-package
(unless (package-installed-p 'use-package)  ;; 如果更改了use-package就在这里加个注释执行一下，不然不会加载package
  (package-refresh-contents)
  (package-install 'use-package))

(use-package doom-themes)

(load-theme 'doom-Iosvkem t)

(eval-and-compile 
    (setq use-package-always-ensure t) ;; 不用每个包都手动添加:ensure t关键字 
    (setq use-package-always-defer t) ;; 默认都是延迟加载，不用每个包都手动添加:defer t 
    (setq use-package-always-demand nil) 
    (setq use-package-expand-minimally t) 
    (setq use-package-verbose t))

(eval-when-compile
  (require 'use-package)) ;; 初始化包管理器

(use-package diminish)  ;; 去掉modeline不必要的信息
(use-package bind-key)  

;; Auto update packages
(use-package auto-package-update
  :init
  (setq auto-package-update-delete-old-versions t
        auto-package-update-hide-results t)
  (defalias 'upgrade-packages #'auto-package-update-now))

(provide 'init-package)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-package.el ends here
