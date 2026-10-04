;; nto-markdown.el -*- lexical-binding: t; -*-

(use-package markdown-mode
  :ensure t
  :defer t
  :custom
  (markdown-fontify-code-blocks-natively t)
  :config
  (add-hook 'markdown-mode-hook #'visual-line-mode))

(use-package evil-markdown
  :ensure (:host github :repo "Somelauw/evil-markdown")
  :hook (markdown-mode . evil-markdown-mode)
  :defer t)


(provide 'nto-markdown)
