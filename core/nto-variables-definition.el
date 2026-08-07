;; nto-variables-definition.el -*- lexical-binding: t; -*-

(setq user-mail-address "antonio.petrillo4@studenti.unina.it"
      user-full-name "Antonio Petrillo")

(defvar nto--selected-theme 'modus-operandi)

(defvar nto--user-config
  (file-name-concat (getenv "HOME") ".local" "emacs" "user-config.el"))

(defvar nto--notes-dir-parent
  (file-name-concat (getenv "HOME") "Documents" "Notes"))

(defvar nto--notes-dir
  (expand-file-name "denote/" nto--notes-dir-parent))

(defvar nto--journal-dir
  (expand-file-name "journal/" nto--notes-dir-parent))

(defvar nto--notes-unsorted-dir nto--notes-dir)

(defvar nto--notes-assets-dir
  (expand-file-name "assets/" nto--notes-dir-parent))

(defvar nto--org-directory
  (expand-file-name "org/" nto--notes-dir-parent))

(defvar nto--agenda-files
  `(,(expand-file-name "org/agenda.org" nto--notes-dir-parent)))

(provide 'nto-variables-definition)
