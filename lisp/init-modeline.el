;;; init-modeline.el --- core modeline  -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

(setq-default mode-line-format
  (list "-"
    'mode-line-mule-info
    'mode-line-modified
    'mode-line-frame-identification
    ":"
    'default-directory
    '(:eval (propertize "%b " 'face nil
        'help-echo (buffer-file-name)))
    " ["
    '(:eval (propertize "%m" 'face nil
              'help-echo buffer-file-coding-system))
    '(:eval (when (buffer-modified-p)
              (concat ", "  (propertize "Modify"
                             'face nil
                             'help-echo "Buffer has been modified"))))
    ;; is this buffer read-only?
    '(:eval (when buffer-read-only
              (concat ","  (propertize "Read-Only"
                             'face nil
                             'help-echo "Buffer is read-only"))))
    "]"
    (propertize "%M" 'face nil)
    ))


(provide 'init-modeline)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-modeline.el ends here