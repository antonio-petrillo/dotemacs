;; nto-notes.el -*- lexical-binding: t; -*-

(use-package denote
  :ensure t
  :commands (denote-directory)
  :hook
  ((text-mode . denote-fontify-links-mode-maybe)
   (dired-mode . denote-dired-mode))
  :bind
  (("<leader> na" . #'nto--intern-assets)
   ("<leader> nr" . #'denote-rename-file-using-front-matter)
   ("<leader> nu" . #'nto--unsorted-note)
   ("<leader> ni" . #'denote-insert-link)
   ("<leader> nb" . #'denote-backlinks)
   ("<leader> ng" . #'denote-grep)
   ("<leader> nd" . #'denote-dired))

  :config
  (defun nto--unsorted-note ()
    (interactive)
    (let* ((title (denote-title-prompt nil))
           (keywords (denote-keywords-prompt))
           (extension (concat "." (completing-read "Extension: " '("typ" "tex" "org" "md" "txt"))))
           (id (format-time-string denote-date-identifier-format))
           (filename (denote-format-file-name nto--notes-unsorted-dir id keywords title (if (string= extension ".")) "")))
      (find-file filename)))

  (defun nto--dired-rename-using-denote-filescheme (input-path output-path &optional move-if-non-nil)
    (interactive)
    (let* ((filename (file-name-nondirectory input-path))
           (extension (file-name-extension filename t))

           (title (denote-title-prompt nil))
           (keywords (denote-keywords-prompt))
           (id (format-time-string denote-date-identifier-format))

           (new-path (denote-format-file-name
                      output-path
                      id keywords title extension "")))

      (when (or (not input-path) (not (file-regular-p input-path)))
        (user-error "The file to intern into notes asset must be a regular file"))

      (if move-if-non-nil
          (dired-rename-file input-path new-path nil)
        (dired-copy-file input-path new-path nil))
      (message (format "%s: %s to %s" (if move-if-non-nil "Moved" "Copied") input-path new-path))))

  (defun nto--dired-intern-assets (&optional move-if-non-nil)
    (interactive "P")
    (let ((input-path (dired-get-file-for-visit))
          (nto--dired-rename-using-denote-filescheme input-path nto--notes-assets-dir move-if-non-nil))))

  (defun nto--intern-assets (&optional move-if-non-nil)
    (interactive "P")
    (let ((filename (read-file-name "Select: ")))
      (if (and filename (file-regular-p filename))
          (nto--dired-rename-using-denote-filescheme filename nto--notes-assets-dir move-if-non-nil)
        (user-error "The file to intern into asset must be a regular file"))))

  (setq denote-directory nto--notes-dir)
  (setq denote-file-type 'org)
  (setq denote-infer-keywords t)
  (setq denote-sort-keywords t)
  (setq denote-buffer-name-prefix "[Note]")
  (setq denote-rename-buffer-mode "%D")
  (denote-rename-buffer-mode 1))

(use-package denote-journal
    :ensure t
    :after denote
    :bind
    ("<leader> nj" . #'denote-journal-new-or-existing-entry)
    :custom
    (denote-journal-directory nto--journal-dir)
    (denote-journal-keyword "journal"))

(use-package consult-notes
  :ensure t
  :after (denote consult)
  :bind
  (("<leader> ncf" . #'consult-denote-find)
   ("<leader> ncg" . #'consult-denote-grep))
  :config
  (consult-denote-mode 1))

(use-package denote-org
  :ensure t
  :after denote
  :commands
  ( denote-org-convert-links-to-file-type
    denote-org-convert-links-to-denote-type
    denote-org-dblock-insert-files
    denote-org-dblock-insert-links
    denote-org-dblock-insert-backlinks
    denote-org-dblock-insert-missing-links ))

(use-package denote-markdown
  :ensure t
  :after (denote markdown-mode)
  :commands
  ( denote-markdown-convert-links-to-file-paths
    denote-markdown-convert-links-to-denote-type
    denote-markdown-convert-links-to-obsidian-type
    denote-markdown-convert-obsidian-links-to-denote-type ))

(use-package denote-sequence
  :ensure t
  :after denote
  :bind
  (("<leader> nss" . #'denote-sequence)
   ("<leader> nsf" . #'denote-sequence-find)
   ("<leader> nsi" . #'denote-sequence-link)
   ("<leader> nsd" . #'denote-sequence-dired)
   ("<leader> nsr" . #'denote-sequence-reparent)
   ("<leader> nsc" . #'denote-sequence-convert))
  :custom
  (denote-sequence-scheme 'numeric))

(use-package denote-agenda
  :ensure t
  :custom
  (denote-agenda-static-files nto--agenda-files)
  (denote-agenda-include-regexp "_\\(agenda\\|proj\\)\\(_.*\\)?\\.org\\'")
  (denote-agenda-include-journal nil)
  :config
  (denote-agenda-insinuate))

(use-package denote-solo
  :disabled t
  :ensure (:host github :repo "pavlo/denote-solo")
  :config
  (denote-solo-mode 1)
  :bind
  ("<leader> nw" . #'denote-solo-switch)
  :custom
  (denote-solo-directories
   '(("Denote" . nto--notes-dir))))

(provide 'nto-notes)
