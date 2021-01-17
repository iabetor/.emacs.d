;;; init-lsp.el --- core lsp  -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

(use-package lsp-mode
  :ensure t
  ;; 延时加载：仅当 (lsp) 函数被调用时再 (require)
  :commands (lsp lsp-deferred)
  :config (progn
    ;; use flycheck, not flymake
    (setq lsp-prefer-flymake nil)
    (advice-add 'lsp--suggest-project-root
                        :around (lambda (oldfun &rest r)
                                  (custom/lsp-default-dir (apply oldfun r)))))
  ;; 在哪些语言 major mode 下启用 LSP
  :hook (((go-mode
           ;;php-mode
           ;; ......
           ) . lsp-deferred))
  :init ;; 在 (reuqire) 之前执行
  (setq lsp-auto-configure t ;; 尝试自动配置自己
        lsp-auto-guess-root t ;; 尝试自动猜测项目根文件夹
        lsp-idle-delay 0.500) ;; 多少时间idle后向服务器刷新信息

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

        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil)  
  )
(defun custom/lsp-default-dir (suggestion)
  (if (eq major-mode 'go-mode) (custom/find-go-dir default-directory suggestion) suggestion))
(defun custom/find-go-dir (dir limit) 
  (if (or (string-empty-p dir) (equal dir limit)) limit
    (if (member "go.mod" (directory-files dir)) dir
      (custom/find-go-dir (file-name-directory dir) limit))))
;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; 内容呈现
(use-package lsp-ui
  :ensure t
  ;; 仅在某软件包被加载后再加载
  :after (lsp-mode)
  ;; 延时加载
  :commands (lsp-ui-mode)
  ;;:config (progn
  ;;          ;; disable inline documentation
  ;;          (setq lsp-ui-sideline-enable nil)
  ;;          ;; disable showing docs on hover at the top of the window
  ;;          (setq lsp-ui-doc-enable nil))
  :bind
  (:map lsp-ui-mode-map
        ;; 查询符号定义：使用 LSP 来查询。通常是 M-.
        ([remap xref-find-references] . lsp-ui-peek-find-references)
        ;; 查询符号引用：使用 LSP 来查询。通常是 M-?
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ;; 该文件里的符号列表：类、方法、变量等。前提是语言服务支持本功能。
        ("C-c u" . lsp-ui-imenu))
  ;; 当 lsp 被激活时自动激活 lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :init
  ;; lsp-ui 有相当细致的功能开关。具体参考：
  ;; https://github.com/emacs-lsp/lsp-mode/blob/master/docs/tutorials/how-to-turn-off.md
  (setq lsp-enable-symbol-highlighting t
        lsp-ui-doc-enable t
        lsp-lens-enable t))

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
  :ensure t
  :config (progn
            ;; don't add any dely before trying to complete thing being typed
            ;; the call/response to gopls is asynchronous so this should have little
            ;; to no affect on edit latency
            (setq company-idle-delay 0)
            ;; start completing after a single character instead of 3
            (setq company-minimum-prefix-length 1)
            ;; align fields in completions
            (setq company-tooltip-align-annotations t)
            )
  )

(use-package company-lsp
  :ensure t
  :commands company-lsp)

;; Optional - provides snippet support.
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

(provide 'init-lsp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-lsp.el ends here