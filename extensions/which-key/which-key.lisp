(defpackage :lem-extensions/which-key
  (:use :cl :lem-core :lem)
  )
(defvar which-key-idle-delay 1.0)
(defvar which-key-separator ":")

(defun describe-bindings-internal (s keymap &optional first-p)
  (unless first-p
    (princ #\page s)
    (terpri s))
  )

(lem-core:define-command describe-possible-bindings () ()
  "Describe the bindings with their function"
  (let ((buffer (lem-core:current-buffer))
        (firstp t))
    (lem-core:with-pop-up-typeout-window (s (lem-core:make-buffer "*which-key*") :erase t)
      (describe-bindings-internal s
                                  '()
                                  t)
      (setf firstp (not firstp))
      (dolist (mode (lem-core:buffer-minor-modes buffer))
        (describe-bindings-internal s
                                    (lem-core:mode-keymap mode)
                                    firstp)
        (when (lem-core:mode-keymap mode)
          (setf firstp t)))
      (describe-bindings-internal s
                                  lem-core:*global-keymap*
                                  firstp))))

(lem-core:define-key lem-vi-mode:*motion-keymap* "C-c t" 'describe-possible-bindings)
