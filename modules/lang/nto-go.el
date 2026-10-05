;; nto-go.el -*- lexical-binding: t; -*-

(use-package go-mode
  :ensure t
  :config
  (add-hook 'go-mode-hook (nto--with-tab-with 2)))

(provide 'nto-go)
