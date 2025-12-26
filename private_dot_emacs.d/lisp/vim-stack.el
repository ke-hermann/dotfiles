;;; evil-stack-use-package.el --- Evil mode configuration -*- lexical-binding: t; -*-

;; Requires: use-package, Emacs 28+

;;; --------------------
;;; Evil core
;;; --------------------

(use-package evil
  :ensure t
  :init
  ;; Must be set before evil loads
  (setq evil-want-keybinding nil      ; required for evil-collection
        evil-want-integration t
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil
        evil-respect-visual-line-mode t
        evil-undo-system 'undo-redo)  ; Emacs 28+

  :config
  (evil-mode 1)
  (evil-define-key* '(normal visual insert) 'global
    (kbd "C-.") #'embark-act))

  ;; Make ESC quit like Vim
  (define-key evil-normal-state-map [escape] #'keyboard-quit)
  (define-key evil-visual-state-map [escape] #'keyboard-quit)

  ;; Better motion in wrapped lines
  (setq evil-cross-lines t)

;;; --------------------
;;; jk escape from insert state
;;; --------------------

(defun my/evil-jk-exit ()
  "Exit insert state with 'jk'."
  (interactive)
  (let ((keys (this-command-keys)))
    (when (equal keys "jk")
      (evil-normal-state))))

;; Use key-chord for reliability and speed
(use-package key-chord
  :ensure t
  :after evil
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" #'evil-normal-state)
  (key-chord-define evil-replace-state-map "jk" #'evil-normal-state))

;;; --------------------
;;; Evil Collection
;;; --------------------

(use-package evil-collection
  :ensure t
  :after evil
  :config
  ;; Optional: limit what evil-collection enables
  ;; (setq evil-collection-mode-list '(magit dired ibuffer help))
  (evil-collection-init))

;;; --------------------
;;; Sensible defaults & compatibility
;;; --------------------

;; Use Vim-style search
(setq evil-search-module 'evil-search)

;; Make j/k respect visual lines when visual-line-mode is enabled
(setq evil-respect-visual-line-mode t)

;; Allow C-g to behave consistently
(define-key evil-insert-state-map (kbd "C-g") #'evil-normal-state)

(provide 'evil-stack-use-package)
;;; evil-stack-use-package.el ends here
