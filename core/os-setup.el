;; os-setup.el -*- lexical-binding: t; -*-

(defvar is-linux (eq system-type 'gnu/linux))
(defvar is-windows (eq system-type 'windows-nt))
(defvar is-wsl (and (eq system-type 'gnu/linux) (getenv "WSLENV")))

(when (and is-windows
	   (not (eq (pwd) "c:/Program Files/Emacs")))
  (cd (getenv "HOME"))
  (add-to-list 'exec-path "c:/msys64/ucrt64/bin"))

(use-package exec-path-from-shell
  :if (not is-windows)
  :ensure t
  :init
  (exec-path-from-shell-initialize))

;; from prelude emacs
(when is-wsl
  (let ((cmd-exe "/mnt/c/Windows/System32/cmd.exe")
        (cmd-args '("/c" "start")))
    (when (file-exists-p cmd-exe)
      (setq browse-url-generic-program  cmd-exe
            browse-url-generic-args     cmd-args
            browse-url-browser-function 'browse-url-generic
            search-web-default-browser 'browse-url-generic))))

(provide 'os-setup)
