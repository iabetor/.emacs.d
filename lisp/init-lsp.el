(use-package lsp-mode
     :diminish
     :commands (lsp-enable-which-key-integration
                lsp-format-buffer
                lsp-organize-imports
                lsp-install-server)
     :custom-face
     (lsp-headerline-breadcrumb-path-error-face
      ((t :underline (:style wave :color ,(face-foreground 'error))
          :inherit lsp-headerline-breadcrumb-path-face)))
     (lsp-headerline-breadcrumb-path-warning-face
      ((t :underline (:style wave :color ,(face-foreground 'warning))
          :inherit lsp-headerline-breadcrumb-path-face)))
     (lsp-headerline-breadcrumb-path-info-face
      ((t :underline (:style wave :color ,(face-foreground 'success))
          :inherit lsp-headerline-breadcrumb-path-face)))
     (lsp-headerline-breadcrumb-path-hint-face
      ((t :underline (:style wave :color ,(face-foreground 'success))
          :inherit lsp-headerline-breadcrumb-path-face)))

     (lsp-headerline-breadcrumb-symbols-error-face
      ((t :inherit lsp-headerline-breadcrumb-symbols-face
          :underline (:style wave :color ,(face-foreground 'error)))))
     (lsp-headerline-breadcrumb-symbols-warning-face
      ((t :inherit lsp-headerline-breadcrumb-symbols-face
          :underline (:style wave :color ,(face-foreground 'warning)))))
     (lsp-headerline-breadcrumb-symbols-info-face
      ((t :inherit lsp-headerline-breadcrumb-symbols-face
          :underline (:style wave :color ,(face-foreground 'success)))))
     (lsp-headerline-breadcrumb-symbols-hint-face
      ((t :inherit lsp-headerline-breadcrumb-symbols-face
          :underline (:style wave :color ,(face-foreground 'success)))))

     :hook ((prog-mode . (lambda ()
                           (unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode)
                             (lsp-deferred))))
            (lsp-mode . (lambda ()
                          ;; Integrate `which-key'
                          (lsp-enable-which-key-integration)

                          ;; Format and organize imports
                         
                            (add-hook 'before-save-hook #'lsp-format-buffer t t)
                            (add-hook 'before-save-hook #'lsp-organize-imports t t))))
     :bind (:map lsp-mode-map
            ("C-c C-d" . lsp-describe-thing-at-point)
            ([remap xref-find-definitions] . lsp-find-definition)
            ([remap xref-find-references] . lsp-find-references))
     :init
     ;; @see https://emacs-lsp.github.io/lsp-mode/page/performance
     (setq read-process-output-max (* 1024 1024)) ;; 1MB

     (setq lsp-keymap-prefix "C-c l"
           lsp-keep-workspace-alive nil
           lsp-signature-auto-activate nil
           lsp-modeline-code-actions-enable nil
           lsp-modeline-diagnostics-enable nil
           lsp-modeline-workspace-status-enable nil

           lsp-enable-file-watchers nil
           lsp-enable-folding nil
           lsp-enable-symbol-highlighting nil
           lsp-enable-text-document-color nil

           lsp-auto-guess-root t

           lsp-enable-indentation nil
           lsp-enable-on-type-formatting nil)

     :config
     (with-no-warnings
       (defun my-lsp--init-if-visible (func &rest args)
         "Not enabling lsp in `git-timemachine-mode'."
         (unless (bound-and-true-p git-timemachine-mode)
           (apply func args)))
       (advice-add #'lsp--init-if-visible :around #'my-lsp--init-if-visible))

     (defun lsp-update-server ()
       "Update LSP server."
       (interactive)
       ;; Equals to `C-u M-x lsp-install-server'
       (lsp-install-server t)))

;; optionally
(use-package lsp-ui 
  :commands lsp-ui-mode)

(use-package company
  :config
  ;; Optionally enable completion-as-you-type behavior.
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))


(provide 'init-lsp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-lsp.el ends here