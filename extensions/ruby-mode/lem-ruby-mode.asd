(defsystem "lem-ruby-mode"
  :depends-on (
               "lem"
               "lem-lsp-mode"
               "lem-js-mode"
               #+#.(cl:if (asdf:find-system :async-process cl:nil) '(and) '(or)) "lem-process")
  :serial t
  :components ((:file "ruby-mode")
               (:file "lsp-config")))
