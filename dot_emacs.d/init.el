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

(defvar use-package-always-ensure)
(setq use-package-always-ensure t)

(load-theme 'ef-bio t)
(set-frame-font "Ubuntu Mono 15")

;; Packages

(use-package emacs
  :bind (("C-x m" . menu-bar-mode)))

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
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

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
  :ensure t
  :config
  (add-hook 'cider-repl-mode-hook (lambda () (display-line-numbers-mode -1)))
  (add-hook 'cider-repl-mode-hook #'enable-paredit-mode))

(use-package paredit
  :ensure t
  :diminish paredit-mode
  :config
  (add-hook 'clojure-mode-hook #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))

(use-package nerd-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :after (nerd-icons)
  :config
  (setq column-number-mode +1)
  (setq doom-modeline-icon nil)
  (doom-modeline-mode +1))

(use-package doom-themes
  :ensure t)
(use-package ef-themes
  :ensure t)
(use-package solarized-theme
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package pyvenv
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package lua-mode
  :ensure t)

(use-package go-mode
  :ensure t)

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (XXX-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
;; optionally
(use-package lsp-ui :commands lsp-ui-mode)

;; Language extensions
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))  ; or lsp-deferred

(use-package dap-mode
  :ensure t
  :config
  (require 'dap-python)
  (defvar dap-python-debugger)
  (setq dap-python-debugger 'debugpy))

;; formatting
(use-package format-all
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'format-all-mode)
  (add-hook 'prog-mode-hook 'format-all-ensure-formatter))

(use-package tree-sitter-langs
  :ensure t
  :config
  (tree-sitter-require 'python)
  (tree-sitter-require 'clojure)
  (tree-sitter-require 'elisp)
  (tree-sitter-require 'rust)
  (global-tree-sitter-mode))

;; COMPLETION
(load-file "~/.emacs.d/elisp/completion-config.el")

;; Evil Setup
(load-file "~/.emacs.d/elisp/evil-config.el")

;; KEYMAPS
(global-set-key (kbd "<f6>") (lambda () (interactive) (consult-theme 'doom-gruvbox-light)))
(global-set-key (kbd "<f7>") (lambda () (interactive) (consult-theme 'doom-gruvbox)))
(global-set-key (kbd "<f2>") 'menu-bar-mode)
(global-set-key (kbd "M-n") 'scroll-up)
(global-set-key (kbd "M-p") 'scroll-down)
(global-set-key (kbd "M-f") 'forward-to-word)
(global-set-key (kbd "C-x C-n") 'company-complete)
(global-set-key [remap dabbrev-expand] 'hippie-expand)

(provide 'init)
;;; init.el ends here
