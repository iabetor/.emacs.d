;; init-org.el --- Initialize org configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Projectile configurations.
;;

;;; Code:

(use-package org
  :ensure nil
  :init
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  :bind (("C-c a" . org-agenda)
         ("C-c b" . org-switchb))
  :config
  (setq truncate-lines nil
        org-todo-keywords
        '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "CANCEL")))
  )


(provide 'init-org)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-org.el ends here