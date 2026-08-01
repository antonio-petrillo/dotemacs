;; nto-go.el -*- lexical-binding: t; -*-

(use-package go-mode
  :ensure t
  :hook (go-mode . (nto--with-tab-with 2)))

(provide 'nto-go)
