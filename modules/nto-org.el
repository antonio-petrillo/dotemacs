;; nto-org.el -*- lexical-binding: t; -*-

;; I love org-mode but it bind to much stuff
(use-package org
  :ensure nil
  :defer t
  :hook (org-mode . org-indent-mode)
  :bind
  (("<leader> oa" . #'org-agenda)
   (:map org-mode-map
         ("C-'" . nil)
         ("C-," . nil)
         ("M-;" . nil)
         ("M-l" . nil)
         ("C-c ;" . nil)
         ("<localleader> c" . #'org-toggle-checkbox)
         ("<localleader> st" . #'org-time-stamp)
         ("<localleader> ss" . #'org-schedule)
         ("<localleader> sd" . #'org-deadline)
         ("<localleader> t" . #'org-agenda-todo)
         ("<localleader> f" . #'org-footnote-new)))
  :custom
  (org-directory nto--org-directory)
  (org-M-RET-may-split-line '((default . nil)))
  (org-insert-heading-respect-content t)
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-ellipsis "⮧")
  (org-adapt-indentation nil)
  (org-special-ctrl-a/e nil)
  (org-special-ctrl-k nil)
  (org-confirm-babel-evaluate nil)
  (org-src-window-setup 'current-window)
  (org-edit-src-persistent-message nil)
  (org-src-fontify-natively t)
  (org-src-preserve-indentation t)
  (org-src-tab-acts-natively t)
  (org-hide-emphasis-markers t)
  (org-edit-src-content-indentation 0)
  (org-export-with-toc t)
  (org-cycle-emulate-tab t)
  (org-export-headline-levels 8)
  (org-default-notes-file (make-temp-file "shadow-realm-org-file"))

  (org-agenda-files nto--agenda-files)
  (org-agenda-span 'week)
  (org-agenda-confirm-kill t)
  (org-agenda-show-all-dates t)
  (org-agenda-show-outline-path 'title)
  (org-agenda-start-on-weekday 1)
  (org-agenda-block-separator ?-)
  (org-agenda-bulk-mark-char "#")
  (org-agenda-persistent-marks nil)
  (org-agenda-dim-blocked-tasks t)
  (org-agenda-todo-list-sublevels t)
  (org-agenda-skip-scheduled-if-deadline-is-shown t)
  (org-agenda-skip-timestamp-if-deadline-is-shown t)
  (org-agenda-skip-deadline-if-done nil)
  (org-agenda-skip-timestamp-if-done nil)
  (org-agenda-search-headline-for-time nil)
  (org-scheduled-past-days 365)
  (org-deadline-past-days 365)
  (org-agenda-move-date-from-past-immediately-to-today t)
  (org-agenda-show-future-repeats t)
  (org-agenda-prefer-last-repeat nil)
  (org-agenda-timerange-leaders
   '("" "(%d/%d): "))
  (org-agenda-scheduled-leaders
   '("Scheduled: " "Sched.%2dx: "))
  (org-agenda-inactive-leader "[")
  (org-agenda-deadline-leaders
   '("Deadline:  " "In %3d d.: " "%2d d. ago: "))
  (org-agenda-time-leading-zero t)
  (org-agenda-timegrid-use-ampm nil)
  (org-agenda-use-time-grid t)
  (org-agenda-show-current-time-in-grid t)
  (org-agenda-current-time-string (concat "Now " (make-string 70 ?.)))
  (org-agenda-time-grid
   '((daily today require-timed)
     ( 0700 0800 0900 1000 1100 1200
       1300 1400 1500 1600 1700 1800
       1900 2000 2100 2200 2300 )
     "" ""))
  (org-agenda-default-appointment-duration nil)

  :config
  (add-hook 'org-mode-hook #'visual-line-mode)
  (plist-put org-format-latex-options :scale 2.0))

(use-package org-mode
  :after org-mode
  :bind
  (:map org-agenda-mode-map
        ("n" . #'org-agenda-next-item)
        ("p" . #'org-agenda-previous-item)
        ("j" . #'org-agenda-next-item)
        ("k" . #'org-agenda-previous-item)))

(use-package org-modern
  :ensure t
  :defer t
  :after org
  :hook
  ((org-mode . org-modern-mode)
   (org-agenda-finalize . org-modern-agenda))
  :custom
  (org-modern-table nil)
  (org-modern-star nil)
  (org-modern-block-fringe nil))

(use-package org-appear
  :ensure t
  :defer t
  :hook
  ((org-mode . (lambda ()
                 (add-hook 'evil-insert-state-entry-hook
                           #'org-appear-manual-start nil t)
                 (add-hook 'evil-insert-state-exit-hook
                           #'org-appear-manual-stop nil t)))
   (org-mode . org-appear-mode)))

(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(provide 'nto-org)
