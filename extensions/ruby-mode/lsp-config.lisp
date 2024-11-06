(defpackage :lem-ruby-mode/lsp-config
  (:use :cl :lem-lsp-mode :lem-lsp-base/type))

(in-package :lem-ruby-mode/lsp-config)

(define-language-spec (ruby-spec lem-ruby-mode:ruby-mode)
  :language-id "ruby"
  :root-uri-patterns '("Gemfile" "gemfile" "Gemfile.lock")
  :command '("bash" "-c" "ruby-lsp 2> /dev/null")
  :install-command '("gem" "install" "ruby-lsp")
  :readme-url "https://github.com/Shopify/ruby-lsp"
  :connection-mode :stdio)
