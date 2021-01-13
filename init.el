;;; init.el --- The main entry for emacs -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; A big contributor to startup times is garbage collection. We up the gc
;; threshold to temporarily prevent it from running, and then reset it later
;; using a hook.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Keep a ref to the actual file-name-handler
(defvar default-file-name-handler-alist file-name-handler-alist)

;; Set the file-name-handler to nil (because regexing is cpu intensive)
(setq file-name-handler-alist nil)

;; Reset file-name-handler-alist after initialization
(add-hook 'emacs-startup-hook
  (lambda ()
    (setq gc-cons-threshold 16777216
          gc-cons-percentage 0.1
          file-name-handler-alist default-file-name-handler-alist)))

;; Increase the amount of data from the process
;; `lsp-mode' gains
(setq read-process-output-max (* 1024 1024))

(require 'package)
(setq package-archives
      '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure nil)
  (setq use-package-always-defer nil)
  (setq use-package-always-demand nil)
  (setq use-package-expand-minimally nil)
  (setq use-package-enable-imenu-support t))
(eval-when-compile
  (require 'use-package))
  

;; Auto update packages
(use-package auto-package-update
  :init
  (setq auto-package-update-delete-old-versions t
        auto-package-update-hide-results t)
  (defalias 'upgrade-packages #'auto-package-update-now))  

;;(setq debug-on-error t)
(setq-default lexical-binding t)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'init-basic)
(require 'init-dired)
(require 'init-modeline)
(require 'init-ivy)
(require 'init-projectile)
;;(require 'init-kill-ring)
(require 'init-lsp)

(require 'init-go)



(when (file-exists-p custom-file)
  (load custom-file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init.el ends here