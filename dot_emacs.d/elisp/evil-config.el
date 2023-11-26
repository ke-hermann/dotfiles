;;; Evil Configuration

;; Evil Setup
(use-package evil
  :ensure t
  :after (key-chord)
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-insert-state-cursor 'box)
  (setq evil-undo-sytem 'undo-fu)
  :config (evil-mode 1))

(use-package evil-escape
  :ensure t
  :diminish evil-escape-mode
  :config
  (setq-default evil-escape-key-sequence "jk")
  (evil-escape-mode +1))


;; easy wrapping of text objects
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :ensure t
  :diminish evil-collection-unimpaired-mode
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))
