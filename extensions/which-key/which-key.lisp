(defpackage :lem-extensions/which-key
  (:use :cl :lem-core :lem)
  )
(defvar which-key-idle-delay 1.0)
(defvar which-key-separator ":")

(defun describe-bindings-internal (s name keymap &optional first-p)
  (unless first-p
    (princ #\page s)
    (terpri s))
  (let ((column-width 16))
    (loop :while keymap
          :do (lem-core:traverse-keymap keymap
                               (lambda (kseq command)
                                 (unless (equal "UNDEFINED-KEY" (symbol-name command))
                                   (format s "~va~(~a~)~a"
                                           column-width
                                           (lem-core:keyseq-to-string kseq)
                                           (symbol-name command)
                                           column-width))))
              (setf keymap (lem-core:keymap-parent keymap))
              (terpri s))))


(lem-core:define-command describe-possible-bindings () ()
  "Describe the bindings with their function"
  (let ((buffer (lem-core:current-buffer))
        (firstp t))
    (lem-core:with-pop-up-typeout-window (s (lem-core:make-buffer "*bindings*") :erase t)
      (describe-bindings-internal s
                                  (lem-core:mode-name (lem-core:buffer-major-mode buffer))
                                  (setf firstp (lem-core:mode-keymap (lem-core:buffer-major-mode buffer)))
                                  t)
      (setf firstp (not firstp))
      (dolist (mode (lem-core:buffer-minor-modes buffer))
        (describe-bindings-internal s
                                    (lem-core:mode-name mode)
                                    (lem-core:mode-keymap mode)
                                    firstp)
        (when (lem-core:mode-keymap mode)
          (setf firstp t)))
      (describe-bindings-internal s
                                  "Global"
                                  lem-core:*global-keymap*
                                  firstp))))
