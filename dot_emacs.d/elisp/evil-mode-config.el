;;; package --- evil Mode

;;; Commentary:
;;; evil and supporting packages

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
  :after (evil)
  :diminish evil-escape-mode
  :config
  (setq-default evil-escape-key-sequence "jk")
  (evil-escape-mode +1))


;; easy wrapping of text objects
(use-package evil-surround
  :after (evil)
  :config
  (global-evil-surround-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after (evil)
  :diminish evil-collection-unimpaired-mode
  :after evil
  :init (setq evil-want-keybinding nil)
  :config
  (evil-collection-init))

(provide 'evil-mode-config)
;;; evil-mode-config.el ends here
