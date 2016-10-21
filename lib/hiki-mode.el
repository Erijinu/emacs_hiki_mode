(defvar hiki-constants
  '("reservedword1"
    "reservedword2"))

(defvar hiki-keywords
  '("toc" "attach_anchor"))

;; I'd probably put in a default that you want, as opposed to nil
(defvar hiki-tab-width 2 "Width of a tab for HIKI mode")

;; Two small edits.
;; First is to put an extra set of parens () around the list
;; which is the format that font-lock-defaults wants
;; Second, you used ' (quote) at the outermost level where you wanted ` (backquote)
;; you were very close
(defvar hiki-font-lock-defaults
  `((
     ;; stuff between double quotes
;;     ("\"\\.\\*\\?" . font-lock-string-face) ;; doesn't work
     ;; ; : , ; { } =>  @ $ = are all special elements
     (":\\|,\\|;\\|{\\|}\\|=>\\|@\\|$\\|=" . font-lock-keyword-face)
     ( ,(regexp-opt hiki-keywords 'words) . font-lock-builtin-face)
     ( ,(regexp-opt hiki-constants 'words) . font-lock-constant-face)
     )))

(define-derived-mode hiki-mode fundamental-mode "HIKI script"
  "HIKI mode is a major mode for editing HIKI files"
  ;; you again used quote when you had '((hiki-hilite))
  ;; I just updated the variable to have the proper nesting (as noted above)
  ;; and use the value directly here
  (setq font-lock-defaults hiki-font-lock-defaults)

  ;; when there's an override, use it
  ;; otherwise it gets the default value
  (when hiki-tab-width
    (setq tab-width hiki-tab-width))

  ;; for comments
  ;; overriding these vars gets you what (I think) you want
  ;; they're made buffer local when you set them
;;  (setq comment-start "#") ;; doesn't work
;;  (setq comment-end "") ;; doesn't work

  (modify-syntax-entry ?# "< b" hiki-mode-syntax-table) ;;it works
  (modify-syntax-entry ?\n "> b" hiki-mode-syntax-table) ;;it works

  ;; Note that there's no need to manually call `hiki-mode-hook'; `define-derived-mode'
  ;; will define `hiki-mode' to call it properly right before it exits
  )

(provide 'hiki-mode)

