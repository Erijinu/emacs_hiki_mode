;;; hiki.el --- Hiki major mode

;; Copyright (C) 2001  Free Software Foundation, Inc.

;; Author: StefanMonnier
;; Keywords: extensions

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

(defvar hiki-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [foo] 'hiki-do-foo)
    map)
  "Keymap for `hiki-mode'.")

(defvar hiki-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?# "<" st)
    (modify-syntax-entry ?\n ">" st)
    st)
  "Syntax table for `hiki-mode'.")

(defvar hiki-font-lock-keywords
  '(("function \\(\\sw+\\)" (1 font-lock-function-name-face)))
  "Keyword highlighting specification for `hiki-mode'.")

(define-derived-mode hiki-mode fundamental-mode "Hiki"
  "A major mode for editing Hiki files."
  :syntax-table hiki-mode-syntax-table
;;  (setq-local comment-start "# ")
  (setq-local comment-start "!")
  (setq-local comment-start-skip "#+\\s-*")
  (setq-local font-lock-defaults
	      '(hiki-font-lock-keywords))
  )

;;tutorialにはこれを入れろとなっているが．．．
;;ここらあたりでおかしくなるので，外しましょう．
;;ではなくて，以下のがないと，default-modeが動いていたみたい...
(defun hiki-mode ()
  "Major mode for editing hiki files"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'hiki-mode)
  (setq mode-name "HIKI")
  (run-hooks 'hiki-mode-hook)
  )
(provide 'hiki-mode)

