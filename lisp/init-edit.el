;; init-edit.el --- Initialize edit configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; edit configurations.
;;

;;; Code:

(use-package hideshow
  :ensure nil
  :diminish hs-minor-mode
  :bind (:map hs-minor-mode-map
         ("C-`" . hs-toggle-hiding)))

(provide 'init-edit)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-edit.el ends here