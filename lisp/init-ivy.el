;;; init-ivy.el --- core ivy  -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:
(use-package ivy
  :ensure t
  :diminish (ivy-mode . "")
  :config
  (ivy-mode 1)
  (setq ivy-use-virutal-buffers t)
  ;;(setq enable-recursive-minibuffers t)
  (setq ivy-height 10)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format "%d/%d")
  (setq ivy-re-builders-alist
        `((t . ivy--regex-ignore-order)))
  )

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         :map counsel-find-file-map
         ("C-h" . counsel-up-directory))
  :hook ((after-init . ivy-mode)
         (ivy-mode . counsel-mode))
  :init 
  ;;(setq enable-recursive-minibuffers t)
  (setq ivy-use-selectable-prompt t
        ivy-use-virtual-buffers t    ; Enable bookmarks and recentf
        ivy-height 10
        ivy-fixed-height-minibuffer t
        ivy-count-format "(%d/%d) "
        ivy-on-del-error-function nil
        ivy-initial-inputs-alist nil))

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)
         ;;("C-r" . swiper-backward)
         )
  )

(provide 'init-ivy)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ivy.el ends here