;;; openwith.el --- Open files with system's default program from Dired

;;; Commentary:
;; This package provides a command to open files in Dired using the system's
;; default application. Bind it to a key in Dired mode for quick access.

;;; Code:

(defun openwith-open-file (file)
  "Open FILE with the system's default program."
  (cond
   ((eq system-type 'windows-nt)
    (shell-command (concat "start \"\" \"" (convert-standard-filename file) "\"")))
   ((eq system-type 'darwin)
    (shell-command (concat "open " (shell-quote-argument file))))
   ((eq system-type 'gnu/linux)
    (shell-command (concat "xdg-open " (shell-quote-argument file))))
   (t
    (message "Unsupported system type for opening files"))))

(defun dired-openwith ()
  "Open the file at point in Dired with the system's default program."
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (if (file-exists-p file)
        (openwith-open-file file)
      (message "No file at point"))))

;;; Keybinding suggestion (uncomment to enable):
;; (with-eval-after-load 'dired
;;   (define-key dired-mode-map (kbd "C-c o") 'dired-openwith))

(provide 'openwith)

;;; openwith.el ends here