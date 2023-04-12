;;; package --- personal emacs configuration files
;;; Commentary:

;;; Code:
;; separate custom file location


(defconst CFG-PATH "~/.config/emacs-custom.el")

(unless (file-exists-p CFG-PATH)
  (write-region "" nil CFG-PATH))

(setq custom-file CFG-PATH)
(load custom-file)

;; Straight and use-package bootstrapping

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq package-enable-at-startup nil)
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)


;; load completion stack: Vertico, Marginalia, Embark, Consult
(load-file "~/.emacs.d/elisp/completion.el")

;; General settings that don't fit anywhere else
(use-package emacs
  :config
  (setq make-backup-files nil)
  (setq auto-save-default nil)
  (setq vc-follow-symlinks t)
  (setq ring-bell-function 'ignore)
  (setq custom-safe-themes t)
  (electric-pair-mode +1)
  ;; Hide unnecessary UI elements
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (menu-bar-mode -1)
  ;; show line numbers and currently selected line
  (global-hl-line-mode +1)
  (global-display-line-numbers-mode +1)
  ;; enable history
  (recentf-mode 1)
  (show-paren-mode +1)
  (set-frame-font "JetBrains Mono 12"))


;; Packages
(use-package undo-fu)

;; This package implements support for mapping a pair of simultaneously pressed keys to a command
;; and for mapping the same key being pressed twice in quick succession to a command.
(use-package key-chord
  :config (key-chord-mode +1))

;; super-save auto-saves your buffers, when certain events happen - e.g.
;; you switch between buffers, an Emacs frame loses focus, etc.
;;You can think of it as both something that augments and replaces the standard auto-save-mode.
(use-package super-save
  :ensure t
  :config
  (super-save-mode +1))

;;; Vim Bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  (setq evil-want-C-u-scroll t)
  :config
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (evil-mode 1))

;; tpope's vim bindings that enable wrapping easily.
(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

(use-package exec-path-from-shell
  :disabled (string= system-type "windows-nt")
  :config (exec-path-from-shell-initialize))

(use-package magit)

(use-package aggressive-indent
  :config
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'clojure-mode-hook #'aggressive-indent-mode))

(use-package whole-line-or-region
  :config (whole-line-or-region-global-mode +1))

(use-package company
  :config (add-hook 'after-init-hook 'global-company-mode))

(use-package tree-sitter
  :config
  (global-tree-sitter-mode +1)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :after tree-sitter)

(use-package flycheck
  :config (global-flycheck-mode))

(use-package which-key
  :config (which-key-mode +1))

(use-package ace-window
  :bind (("M-o" . ace-window)))

(use-package cider)

(use-package paredit
  :config
  (add-hook 'clojure-mode-hook #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))

(use-package eglot)

(use-package doom-themes
  :config (load-theme 'doom-solarized-light))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

(use-package all-the-icons
  :disabled (string= system-type "windows-nt")
  :after doom-modeline)

(use-package key-chord
  :config (key-chord-mode +1))

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

;; Package to manage keybindings, useful because it can sanely handle evil-mode bindings
(use-package general
  :config
  ;; Clojure/Cider bindings
  (general-define-key
   :states '(normal visual)
   :keymaps '(cider-repl-mode-map)
   "g y" 'cider-switch-to-last-clojure-buffer)
  (general-define-key
   :states '(normal visual)
   :keymaps '(cider-mode-map clojure-mode-map)
   "g y" 'cider-switch-to-repl-buffer)
  ;; theme switching
  (general-define-key "<f8>" (lambda () (interactive) (consult-theme 'doom-solarized-dark)))
  (general-define-key "<f9>" (lambda () (interactive) (consult-theme 'doom-solarized-light))))

(provide 'init)
;;; init.el ends here
