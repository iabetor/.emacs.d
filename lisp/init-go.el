;; init-go.el --- Initialize Golang configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Golang configurations.
;;

;;; Code:

;; Golang
(use-package go-mode
  :ensure t
  :bind (
         ;; If you want to switch existing go-mode bindings to use lsp-mode/gopls instead
         ;; uncomment the following lines
         ;; ("C-c C-j" . lsp-find-definition)
         ;; ("C-c C-d" . lsp-describe-thing-at-point)
         )
  :hook ((go-mode . lsp-deferred)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports)))

 ;; Install: See https://github.com/golangci/golangci-lint#install
(use-package flycheck-golangci-lint
  :ensure t
  :if (executable-find "golangci-lint")
  :after flycheck
  :defines flycheck-disabled-checkers
  :hook (go-mode . (lambda ()
                     "Enable golangci-lint."
                     (setq flycheck-disabled-checkers '(go-gofmt
                                                        go-golint
                                                        go-vet
                                                        go-build
                                                        go-test
                                                        go-errcheck))
                     (flycheck-golangci-lint-setup))))

 (use-package go-tag
  :ensure t
  :bind (:map go-mode-map
         ("C-c t t" . go-tag-add)
         ("C-c t T" . go-tag-remove))
  :init (setq go-tag-args (list "-transform" "camelcase")))

 (use-package go-gen-test
  :ensure t
  :bind (:map go-mode-map
         ("C-c t g" . go-gen-test-dwim)))

 (use-package gotest
  :ensure t
  :bind (:map go-mode-map
         ("C-c t a" . go-test-current-project)
         ("C-c t m" . go-test-current-file)
         ("C-c t ." . go-test-current-test)
         ("C-c t b" . go-test-current-benchmark)
         ("C-c t x" . go-run)))



(provide 'init-go)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-go.el ends here
