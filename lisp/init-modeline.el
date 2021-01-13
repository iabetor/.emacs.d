;;; init-modeline.el --- core modeline  -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

(use-package diminish
  :ensure t
  :demand t
  :diminish hs-minor-mode
  :diminish abbrev-mode
  :diminish auto-revert-mode
  :diminish auto-fill-function
  :diminish mail-abbrevs-mode
  :diminish highlight-indentation-mode
  :diminish subword-mode)

;;; Stolen From https://github.com/hrs/dotfiles/blob/master/emacs.d/configuration.org
(defmacro diminish-minor-mode (filename mode &optional abbrev)
  "Macro for diminish minor mode with FILENAME MODE and ABBREV."
  `(eval-after-load (symbol-name ,filename)
     '(diminish ,mode ,abbrev)))

(defmacro diminish-major-mode (mode-hook abbrev)
  "Macro for diminish major mode with MODE-HOOK and ABBREV."
  `(add-hook ,mode-hook
             (lambda () (setq mode-name ,abbrev))))
(diminish-minor-mode 'highlight-indentation 'highlight-indentation-mode )
(diminish-minor-mode 'mail-abbrevs 'mail-abbrevs-mode )
(diminish-minor-mode 'auto-revert 'auto-revert-mode)
(diminish-minor-mode 'simple 'auto-fill-function )
(diminish-minor-mode 'eldoc 'eldoc-mode)

;;;Move evil tag to beginning of mode line
(setq evil-mode-line-format '(before . mode-line-front-space))
;;; modify evil-state-tag
(setq evil-normal-state-tag   (propertize "[Normal]")
      evil-emacs-state-tag    (propertize "[Emacs]")
      evil-insert-state-tag   (propertize "[Insert]")
      evil-motion-state-tag   (propertize "[Motion]")
      evil-visual-state-tag   (propertize "[Visual]")
      evil-operator-state-tag (propertize "[Operator]"))


(defun samray/set-mode-line-width ()
  "Set mode line width, it is so cool."
  (set-face-attribute 'mode-line nil
		      :box '(:line-height 0)))
(defvar after-load-theme-hook nil
  "Hook run after a color theme is loaded using `load-theme'.")
(defadvice load-theme (after run-after-load-theme-hook activate)
  "Run `after-load-theme-hook'."
  (run-hooks 'after-load-theme-hook))
(add-hook 'after-load-theme-hook #'samray/set-mode-line-width)

;;; customize mode line
(setq-default mode-line-format '("["
				 "%e"
				 (:eval
				  (window-numbering-get-number-string))
				 "]"
				 mode-line-front-space
				 mode-line-mule-info
				 ;; mode-line-client
				 mode-line-modified -- show buffer change or not
				 ;; mode-line-remote -- no need to indicate this specially
				 mode-line-frame-identification -- this is for text-mode emacs only
				 "["
				 mode-name
				 ":"
				 mode-line-buffer-identification
				 "]"
				 " "
				 mode-line-position
				 (vc-mode vc-mode)
				 " "
				 ;; mode-line-modes -- move major-name above
				 "["
				 minor-mode-alist
				 "]"
				 mode-line-misc-info
				 ;; mode-line-end-spaces
				 ))

(provide 'init-modeline)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-modeline.el ends here