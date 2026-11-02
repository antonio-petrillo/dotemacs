;; nto-app.el -*- lexical-binding: t; -*-

(use-package pdf-tools
  :ensure t
  :after latex
  :defer t
  :config
  (pdf-tools-install)
  (add-hook 'pdf-view-mode-hook 'auto-revert-mode))

(use-package buffer-to-pdf
  :ensure (:type git :host github :repo "protesilaos/buffer-to-pdf")
  :defer t
  :config
  (setq buffer-to-pdf-directory (expand-file-name "~/Downloads/")))

(use-package speed-type
  :ensure t
  :defer t
  :custom
  (speed-type-directory (expand-file-name "speed-type/" nto--cache)))

(use-package ledger-mode
  :ensure t
  :custom
  ((ledger-binary-path "hledger")
   (ledger-mode-should-check-version nil)
   (ledger-report-auto-width nil)
   (ledger-report-links-in-register nil)
   (ledger-report-native-highlighting-arguments '("--color=always")))
  :mode ("\\.journal\\'" "\\.hledger\\'" "\\.ledger\\'"))

(provide 'nto-app)
