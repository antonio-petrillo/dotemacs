;; nto-writing.el -*- lexical-binding: t; -*-

(use-package expand-region
  :ensure t
  :defer t
  :bind
  (("C-=" . #'er/expand-region)))

;; Use only in case of trolling
(use-package selectric-mode
  :ensure t)

(use-package olivetti
  :ensure t
  :defer t
  :bind
  (("<leader> tw" . #'olivetti-mode)
   :map olivetti-mode-map
   ("C-c [" . #'olivetti-shrink)
   ("C-c ]" . #'olivetti-expand)
   ("C-c \\" . #'olivetti-set-width)
   ("C-c |" . #'olivetti-set-width)))

(use-package rotate-text
  :ensure (:host github :repo "debug-ito/rotate-text.el")
  :after evil
  :config
  (evil-define-key 'normal 'global
    (kbd "]r") #'rotate-text
    (kbd "[r") #'rotate-text-backward))

(with-eval-after-load 'rotate-text
  (dolist (rotate-words '(("false" "true")
                          ("nord" "ovest" "sud" "east")
                          ("up" "down" "left" "right")
                          ("previous" "next")
                          ("width" "height")
                          ("top" "bottom")))
    (cl-pushnew rotate-words rotate-text-words))
  (dolist (rotate-symbols '(("var" "const")
                            ("and" "or")
                            ("&&" "||")))
    (cl-pushnew rotate-symbols rotate-text-symbols)))

(use-package jinx
  :ensure t
  :defer t
  :hook ((org-mode . jinx-mode)
         (markdown-mode . jinx-mode)
         (text-mode . jinx-mode))
  :bind
  (([remap ispell-word] . #'jinx-correct)
   ("<leader> lc" . #'jinx-correct))
  :custom
  (jinx-languages "en_US en_GB it_IT"))

(use-package google-translate
  :ensure t
  :defer t
  :custom
  (google-translate-translation-directions-alist
   '(("it" . "en") ("en" . "it")))
  (google-translate-default-source-language "it")
  (google-translate-default-target-language "en")
  (google-translate-translation-to-kill-ring t)
  :bind
  (("<leader> lt" . #'google-translate-at-point)
   ("<leader> lT" . #'google-translate-at-point-reverse))
  :init
  (add-to-list 'display-buffer-alist
	       '("\\*Google Translate\\*"
		 (display-buffer-reuse-window
		  display-buffer-below-selected)
		 (dedicated . t)
		 (window-height . fit-window-to-buffer)
		 (body-function . (lambda (window) (select-window window))))))

(use-package powerthesaurus
  :ensure t
  :defer t
  :bind
  ("<leader> lp" . #'powerthesaurus-transient))

(use-package hl-todo
  :ensure t
  :defer t
  :config
  (add-hook 'markdown-mode-hook #'hl-todo-mode)
  (add-hook 'org-mode-hook #'hl-todo-mode)
  (add-hook 'prog-mode-hook #'hl-todo-mode)
  :bind
  (:map hl-todo-mode-map
        ("C-c t p" . #'hl-todo-previous)
        ("C-c t n" . #'hl-todo-next)
        ("C-c t o" . #'hl-todo-occur)
        ("C-c t i" . #'hl-todo-insert)))

(use-package focus
  :ensure t
  :defer t)

(provide 'nto-writing)
