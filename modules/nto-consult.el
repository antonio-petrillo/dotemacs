;; nto-consult.el -*- lexical-binding: t; -*-

(use-package consult
  :ensure t
  :after evil
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :bind
  (([remap Info-search] . #'consult-info)
   ([remap switch-to-buffer] . #'consult-buffer)
   ([remap bookmark-jump] . #'consult-bookmark)
   ([remap load-theme] . #'consult-theme)
   ([remap project-switch-to-buffer] . #'consult-project-buffer)
   ([remap recentf-open-files] . #'consult-recent-file)
   ([remap evil-paste-pop] . #'consult-yank-pop) ;; shadowed by evil -_-
   ([remap yank-pop] . #'consult-yank-pop) ;; shadowed by evil -_-
   ([remap imenu] . #'consult-imenu)
   ([remap locate] . #'consult-locate)
   ([remap goto-line] . #'consult-goto-line)

   ("M-y" . #'evil-paste-pop)
   ("M-X" . #'consult-mode-command)

   ("<leader> ht" . #'load-theme)
   ("<leader> hi" . #'consult-info)
   ("<leader> hm" . #'consult-man)

   ("<leader> ss" . #'consult-line)
   ("<leader> so" . #'consult-outline)
   ("<leader> si" . #'consult-imenu)
   ("<leader> jc" . #'consult-line)
   ("<leader> jC" . #'goto-line)
   ("<leader> fg" . #'consult-ripgrep)
   ("<leader> /" . #'consult-ripgrep)
   ("<leader> ff" . #'consult-find)
   ("<leader> fl" . #'consult-locate)
   ("<leader> RET" . #'bookmark-jump)
   ("<leader> bb" . #'switch-to-buffer)

   ("<leader> xr" . #'consult-register)

   :map minibuffer-local-map
   ("M-s" . #'consult-history)
   ("M-r" . #'consult-history))
  :config
  (setq xref-show-xrefs-function #'consult-xref
	xref-show-definitions-function #'consult-xref))

(use-package consult-dir
  :ensure t
  :defer t
  :bind
  (([remap list-directory] . #'consult-dir)
   ("<leader> fd" . #'consult-dir)
   (:map vertico-map
         ("C-x C-d" . #'consult-dir)
         ("C-x C-j" . #'consult-dir-jump-file))))

(use-package consult-todo
  :ensure t
  :bind
  (("<leader> st" . #'consult-todo)
   ("<leader> sT" . #'consult-todo-dir)))

(provide 'nto-consult)
