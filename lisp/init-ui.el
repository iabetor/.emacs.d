;;; init-ui.el --- core ui  -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

;; 全局显示行
(use-package display-line-numbers
  :ensure nil
  :hook(after-init . global-display-line-numbers-mode))

;; 高亮显示当前行
(use-package hl-line
  :ensure nil
  :hook (after-init . global-hl-line-mode)
  ;;:custom-face (hl-line-face ((t (:inherit default :background nil :foreground nil))))
  :config
  ;; 当前行背景
  (set-face-background hl-line-face "#BEBEBE")
  ;; 当前行前景
  (set-face-foreground hl-line-face "#000000"))


;; 选中区域背景
(set-face-background 'region "#BEBEB")

(provide 'init-ui)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ui.el ends here