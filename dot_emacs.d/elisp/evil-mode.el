;;; package --- Evil Mode
;;; Commentary: evil and supporting packages
;;; Code:

(use-package evil
  :after (key-chord)
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-fu)
  (setq evil-insert-state-cursor 'box)
  :config (evil-mode 1))

(use-package evil-escape
  :diminish evil-escape-mode
  :config
  (setq-default evil-escape-key-sequence "jk")
  (evil-escape-mode +1))


;; easy wrapping of text objects
(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :diminish evil-collection-unimpaired-mode
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

(provide 'evil-mode)
;;; evil-mode.el ends here
