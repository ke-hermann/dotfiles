(defun org-insert-file-task-list (directory)
  "Insert an Org-mode task list of all files in DIRECTORY into the current buffer."
  (interactive "DDirectory: ")
  (let ((files (directory-files directory t "^[^.].*")))
    (dolist (file files)
      (when (file-regular-p file)
        (insert (format "- [ ] %s\n" (file-name-nondirectory file)))))))

(defun org-insert-formatted-link (url)
  "Insert an Org-mode link for URL with the webpage title as description."
  (interactive "sURL: ")
  (let* ((title (org-insert-formatted-link--get-title url))
         (org-link (format "[[%s][%s]]" url (or title url))))
    (insert org-link)))

(defun org-insert-formatted-link--get-title (url)
  "Helper function to extract title from URL."
  (require 'url)
  (require 'dom)
  (with-temp-buffer
    (url-insert-file-contents url)
    (let ((dom (libxml-parse-html-region (point-min) (point-max))))
      (dom-text (dom-by-tag dom 'title)))))

(defun org-insert-code-block ()
  "Prompt for a programming LANGUAGE and insert an empty org-mode source code block."
  (interactive)
  (let ((lang (read-string "what language is the code written in? ")))
    (insert (format "#+BEGIN_SRC %s\n\n#+END_SRC" lang)))
  (forward-line 2))


(provide 'utilities)
