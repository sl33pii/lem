(defsystem "lem-lsp-mode-deprecated"
  :depends-on ("jsonrpc" "quri" "lem-core" #|"lem-process"|#
               "jsonrpc/transport/tcp")
  :serial t
  :components ((:file "package")
               (:file "util")
               (:file "jsonrpc-util")
               ;(:file "jsonrpc-transport")
               (:file "lsp-mode")))