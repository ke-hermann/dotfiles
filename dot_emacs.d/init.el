;;; package --- personal emacs configuration files
;;; Commentary:
;;; Code:

;; which operating system are we using?
(defvar os-windows? (string= system-type "windows-nt"))

;; MELPA setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; always treat themes as safe.
(setq custom-safe-themes t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load-file custom-file))

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

(defvar display-line-numbers-type)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)
;; enable history
(recentf-mode 1)

;; automatically load changed files
(defvar global-auto-revert-non-file-buffers)
(defvar auto-revert-verbose)

(global-auto-revert-mode +1)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(show-paren-mode +1)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Packages

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package ef-themes)

(use-package emacs
  :bind (("C-x m" . menu-bar-mode)))

(use-package diminish
  :config
  (diminish 'eldoc-mode))

;; This package implements support for mapping a pair of simultaneously pressed keys .
(use-package key-chord
  :config (key-chord-mode 1))

;; super-save auto-saves your buffers
(use-package super-save
  :diminish super-save-mode
  :config
  (super-save-mode +1))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package magit)

(use-package whole-line-or-region
  :diminish (whole-line-or-region-global-mode whole-line-or-region-local-mode)
  :config (whole-line-or-region-global-mode +1))

(use-package company
  :diminish company-mode
  :config (global-company-mode +1))


(use-package flycheck
  :config (global-flycheck-mode))

(use-package which-key
  :diminish which-key-mode
  :config (which-key-mode +1))

(use-package ace-window
  :bind (("M-o" . ace-window)))

(use-package cider
  :config
  (add-hook 'cider-repl-mode-hook (lambda () (display-line-numbers-mode -1)))
  (add-hook 'cider-repl-mode-hook #'enable-paredit-mode))

(use-package paredit
  :diminish paredit-mode
  :config
  (add-hook 'clojure-mode-hook #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))

(use-package nerd-icons)

(use-package doom-modeline
  :after (nerd-icons)
  :config
  (setq column-number-mode +1)
  (setq doom-modeline-icon nil)
  (doom-modeline-mode +1))

(use-package doom-themes)
(use-package ef-themes)
(use-package solarized-theme)
(use-package tao-theme)

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package pyvenv)

(use-package rust-mode)

(use-package lua-mode)

(use-package go-mode)

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook ((go-mode . lsp)
	 (python-mode . lsp)
	 (lua-mode . lsp)
         ;; want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
;; optionally
(use-package lsp-ui :commands lsp-ui-mode)

(use-package dap-mode
  :config
  (require 'dap-python)
  (defvar dap-python-debugger)
  (setq dap-python-debugger 'debugpy))

;; formatting
(use-package format-all
  :config
  (add-hook 'prog-mode-hook 'format-all-mode)
  (add-hook 'prog-mode-hook 'format-all-ensure-formatter))

(use-package tree-sitter-langs
  :config
  (tree-sitter-require 'python)
  (tree-sitter-require 'clojure)
  (tree-sitter-require 'elisp)
  (tree-sitter-require 'rust)
  (global-tree-sitter-mode))

(use-package elfeed
  :config
  (setq elfeed-feeds
	'("https://krebsonsecurity.com/feed/"
	  "https://www.twz.com/feed"
	  "http://feeds.nightvalepresents.com/welcometonightvalepodcast")))

(load-file "~/.emacs.d/elisp/utils.el")

;; machine specific settings
(load-file "~/.emacs.d/elisp/local.el")

;; COMPLETION
(load-file "~/.emacs.d/elisp/completion-config.el")

;; Evil Setup
;; (load-file "~/.emacs.d/elisp/evil-config.el")

;; KEYMAPS
(global-set-key (kbd "<f6>") (lambda () (interactive) (consult-theme 'ef-bio)))
(global-set-key (kbd "<f7>") (lambda () (interactive) (consult-theme 'ef-kassio)))
(global-set-key (kbd "<f2>") 'menu-bar-mode)
(global-set-key (kbd "M-n") 'scroll-up)
(global-set-key (kbd "M-p") 'scroll-down)
(global-set-key (kbd "M-f") 'forward-to-word)
(global-set-key (kbd "C-x C-n") 'company-complete)
(global-set-key [remap dabbrev-expand] 'hippie-expand)
(global-set-key [remap list-buffers] 'ibuffer)

(provide 'init)
;;; init.el ends here
