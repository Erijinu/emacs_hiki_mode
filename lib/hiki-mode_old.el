;;; font-lock-modeを有効に
(global-font-lock-mode t)

;; コメント
(set-face-foreground 'font-lock-comment-face "#008000")

;; 文字列
(set-face-foreground 'font-lock-string-face "#A31515")

;; キーワード(Cのforやifのように構文的に重要な名前に使われる)
(set-face-foreground 'font-lock-keyword-face "#1518FF")

(defvar hiki-mode-syntax-table nil "Syntax table for `hiki-mode'.")

(setq hiki-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; pre-formatted style comment “<<< … >>>”
        (modify-syntax-entry ?< ". 123" synTable)
        (modify-syntax-entry ?> ". 456" synTable)
        synTable))

;;(define-derived-mode hiki-mode prog-mode "hiki"
(define-derived-mode hiki-mode nil "hiki"
  "hiki-mode is a major mode for editing language hiki."
  (setq font-lock-defaults (list nil))
  (require 'generic-x))


(defun hiki-mode ()
  "Hiki Mode "
  (interactive)
  (kill-all-local-variables)
  (setq mode-name "Hiki")
  (setq major-mode 'hiki-mode)
 
  (run-hooks 'hiki-mode-hook))
 
(provide 'hiki-mode)

(font-lock-add-keywords 'hiki-mode
  '(("!$$" . font-lock-keyword-face)))

