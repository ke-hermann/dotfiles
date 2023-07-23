;;; package --- helm-config
;;; Commentary: helm setup
;;; Code:

(use-package helm
  :diminish helm-mode
  :init
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (global-set-key (kbd "C-,") #'helm-apropos)
  (global-set-key (kbd "C-s") #'helm-occur)
  (global-set-key (kbd "C-x C-r") #'helm-recentf)
  (helm-mode +1))

(provide 'helm-config)
;;; helm-config.el ends here
