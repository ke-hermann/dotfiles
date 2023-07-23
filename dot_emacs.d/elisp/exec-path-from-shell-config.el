;; figure out what OS we're on
(defvar os-windows? (string= system-type "windows-nt"))

(use-package exec-path-from-shell
  :disabled os-windows?
  :config (exec-path-from-shell-initialize))
