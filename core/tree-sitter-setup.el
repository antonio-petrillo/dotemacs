;; tree-sitter-setup.el -*- lexical-binding: t; -*-

(let ((nto--tree-sitter-install-path (file-name-concat nto--cache "tree-sitter")))
  (unless (file-exists-p nto--tree-sitter-install-path)
    (dired-create-directory nto--tree-sitter-install-path)))

(provide 'tree-sitter-setup)
