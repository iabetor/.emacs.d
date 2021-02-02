;;; init-ui.el --- core ui  -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

;; 全局显示行
(global-display-line-numbers-mode)

;; 高亮显示当前行
(global-hl-line-mode t)
;; 当前行背景
(set-face-background 'hl-line "#BEBEBE")
;; 当前行前景
(set-face-foreground 'hl-line "#000000")

;; 选中区域背景
(set-face-background 'region "#F2939F")

(provide 'init-ui)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ui.el ends here