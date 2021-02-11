(use-package projectile
  :bind-keymap ("\C-c p" . projectile-command-map)
  :config
  (projectile-mode t)
  (setq projectile-completion-system 'ivy)
  (setq projectile-enable-caching t)
  (use-package counsel-projectile
    :after projectile
    :commands (counsel-projectile-find-file counsel-projectile-find-dir counsel-projectile-switch-to-buffer
                                            counsel-projectile-grep counsel-projectile-ag counsel-projectile-switch-project)
    :init
    :bind
    (([remap projectile-find-file]        . counsel-projectile-find-file)
    ([remap projectile-find-dir]         . counsel-projectile-find-dir)
    ([remap projectile-switch-to-buffer] . counsel-projectile-switch-to-buffer)
    ([remap projectile-grep]             . counsel-projectile-grep)
    ([remap projectile-ag]               . counsel-projectile-ag)
    ([remap projectile-switch-project]   . counsel-projectile-switch-project)))
  )
(use-package ag)

(provide 'init-projectile)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-projectile.el ends here
