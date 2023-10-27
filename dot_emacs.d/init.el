;;; package --- personal emacs configuration files
;;; Commentary:
;;; Code:

;; figure out what OS we're on
(defvar os-windows? (string= system-type "windows-nt"))

;; MELPA setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; always treat themes as safe, load before custom file
(setq custom-safe-themes t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; custom file
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load-file custom-file))

;; no backup or custom file
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq vc-follow-symlinks t)
;; shut the annoying alarm sound up
(setq ring-bell-function 'ignore)
(electric-pair-mode +1)
;; Hide unnecessary UI elements
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; (global-hl-line-mode +1)
(defvar display-line-numbers-type)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)
;; enable history
(recentf-mode 1)
;; automatically load changed files
(global-auto-revert-mode +1)
(show-paren-mode +1)

;; Packages

(use-package diminish
  :ensure t
  :config
  (diminish 'eldoc-mode))

;; This package implements suppor for mapping a pair of simultaneously pressed keys .
(use-package key-chord
  :ensure t
  :config (key-chord-mode 1))

;; super-save auto-saves your buffers
(use-package super-save
  :ensure t
  :diminish super-save-mode
  :config
  (super-save-mode +1))

(use-package exec-path-from-shell
  :ensure t
  :disabled os-windows?
  :config (exec-path-from-shell-initialize))

(use-package magit
  :ensure t)

(use-package whole-line-or-region
  :ensure t
  :diminish (whole-line-or-region-global-mode whole-line-or-region-local-mode)
  :config (whole-line-or-region-global-mode +1))


(use-package company
  :ensure t
  :diminish company-mode
  :config (global-company-mode +1))

(use-package tree-sitter
  :ensure t
  :config
  (global-tree-sitter-mode +1)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)

(use-package flycheck
  :ensure t
  :config (global-flycheck-mode))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config (which-key-mode +1))

(use-package ace-window
  :ensure t
  :bind (("M-o" . ace-window)))

(use-package cider
  :ensure t)

(use-package paredit
  :ensure t
  :diminish paredit-mode
  :config
  (add-hook 'clojure-mode-hook #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))

(use-package nerd-icons
  :ensure t)

(use-package doom-modeline
  :after (nerd-icons)
  :ensure t
  :config
  (setq doom-modeline-icon nil)
  (doom-modeline-mode +1))

(use-package doom-themes
  :ensure t)

(use-package ef-themes
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package poetry
  :ensure t
  :config (poetry-tracking-mode +1))

(use-package pyvenv
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package lua-mode
  :ensure t)

(use-package go-mode
  :ensure t)

(use-package eglot
  :ensure t
  :config
  (add-hook 'rust-mode-hook 'eglot-ensure)
  (add-hook 'lua-mode-hook 'eglot-ensure))

(use-package dap-mode
  :ensure t)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; formatting
(use-package format-all
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'format-all-mode)
  (add-hook 'prog-mode-hook 'format-all-ensure-formatter))

;; COMPLETION
(load-file "~/.emacs.d/elisp/completion-config.el")

;; KEYMAPS
(global-set-key (kbd "<f6>") (lambda () (interactive) (consult-theme 'ef-kassio)))
(global-set-key (kbd "<f7>") (lambda () (interactive) (consult-theme 'ef-bio)))
(global-set-key (kbd "<f8>") 'menu-bar-mode)
(global-set-key (kbd "M-n") 'scroll-up)
(global-set-key (kbd "M-p") 'scroll-down)
(global-set-key (kbd "C-x C-n") 'company-complete)
(global-set-key [remap dabbrev-expand] 'hippie-expand)

(provide 'init)
;;; init.el ends here
