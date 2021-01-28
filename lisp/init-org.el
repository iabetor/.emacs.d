;; init-org.el --- Initialize org configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Projectile configurations.
;;

;;; Code:

(use-package org
  :ensure nil
  :mode ("\\.org\\'" . org-mode)
  :hook (org-mode . visual-line-mode)
  :bind (("C-c a" . org-agenda)
         ("C-c b" . org-switchb))
  :config
  (setq truncate-lines nil
        org-log-done 'time
        org-todo-keywords
        '((sequence "TODO(t)" "DOING(i)" "HANGUP(h)" "|" "DONE(d)" "CANCEL(c)")
          (sequence "⚑(T)" "🏴(I)" "❓(H)" "|" "✔(D)" "✘(C)"))
        org-todo-keyword-faces '(("HANGUP" . warning)
                                 ("❓" . warning))
        org-priority-faces '((?A . error)
                             (?B . warning)
                             (?C . success))
        )
  :custom
  (org-directory "~/.org/")
  (org-default-notes-file (expand-file-name "notes.org" org-directory))
)

(use-package org-superstar
      :ensure t
      :after (org)
      :hook (org-mode . org-superstar-mode)
      :init (setq org-superstar-headline-bullets-list '("☰" "☷" "☯" "☭")))

(use-package org-agenda
  :ensure nil
  :after org
  :hook (org-agenda-finalize . org-agenda-to-appt)
  :config
  ;; update appt list every 5 minutes
  (run-at-time t 300 #'org-agenda-to-appt)
  (advice-add #'org-agenda-to-appt :around #'my/suppress-message)
  :custom
  (org-agenda-files (list (expand-file-name "tasks.org" org-directory)))
  (org-agenda-diary-file (expand-file-name "diary.org" org-directory))
)

(provide 'init-org)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-org.el ends here