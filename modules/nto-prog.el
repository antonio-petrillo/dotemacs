;; nto-prog.el -*- lexical-binding: t; -*-

(require 'treesit)
(add-to-list 'treesit-language-source-alist
             '(typst "https://github.com/uben0/tree-sitter-typst.git"))

(add-to-list 'load-path (expand-file-name "modules/lang" user-emacs-directory))

(add-hook 'java-mode-hook 'subword-mode)
(add-hook 'prog-mode-hook (lambda ()
                            (display-line-numbers-mode 1)
			    (toggle-truncate-lines 1)
                            (setq-local display-line-numbers 'relative)))
(use-package emacs
  :ensure nil
  :bind
  ("<leader> cc" . #'compile))

(use-package eglot
  :ensure nil
  :config
  (evil-define-key 'normal 'eglot-mode-map
    (kbd "<leader>cr") #'eglot-rename
    (kbd "<leader>ci") #'eglot-code-action-inline
    (kbd "<leader>cf") #'eglot-code-format
    (kbd "<leader>gd") #'eglot-find-declaration
    (kbd "<leader>gi") #'eglot-find-implementation
    (kbd "<leader>gr") #'eglot-code-action-rewrite))

(defmacro nto--with-tab-with (n)
  `(lambda () (setq-local tab-width ,n)))

(use-package devdocs
  :ensure t
  :custom
  (devdocs-data-dir (expand-file-name "devdocs" nto--cache))
  :bind
  (("<leader> hd" . #'devdocs-lookup)))

(use-package dotenv-mode
  :defer t
  :ensure t)

(use-package editorconfig
  :ensure nil
  :custom
  (editorconfig-trim-whitespaces-mode #'ws-butler-mode)
  :config
  (setq editorconfig-get-properties-function #'editorconfig-get-properties)
  (editorconfig-mode 1))

(use-package ws-butler
  :ensure t
  :hook (prog-mode . ws-butler-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package dockerfile-mode
  :ensure t)


(require 'nto-lua)
(require 'nto-odin)
(require 'nto-elixir)
(require 'nto-go)
(require 'nto-data)

(provide 'nto-prog)
