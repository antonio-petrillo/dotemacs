;; nto-odin.el -*- lexical-binding: t; -*-

(defun nto--run-odinfmt ()
  "Run `odinfmt' on current buffer without save, if called in a mode different than `odin-mode' it does absolute nothing."
  (interactive)
  (when (eq major-mode 'odin-mode)
    (call-process-region
     (point-min) (point-max)
     "odinfmt" t t nil "-stdin")
    (message "Formatted: %s"
             (file-name-directory (or (buffer-file-name) (buffer-name))))))

(use-package odin-mode
  :ensure (:host github :repo "antonio-petrillo/odin-mode")
  :defer t
  :bind
  (:map odin-mode-map
        ("<localleader> f" . #'nto--run-odinfmt)))

(provide 'nto-odin)
