;;; package --- personal emacs configuration files
;;; Commentary:

;;; Code:
;; separate custom file location

(defconst CFG-PATH "~/.config/emacs-custom.el")

(unless (file-exists-p CFG-PATH)
  (write-region "" nil CFG-PATH))

(setq custom-file CFG-PATH)
(load custom-file)

;; figure out what OS we're on
(defvar os-windows? (string= system-type "windows-nt"))

;; MELPA setup
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; load completion stack: Vertico, Marginalia, Embark, Consult
;; (load-file "~/.emacs.d/elisp/completion.el")
;; for the time being just sticking to helm

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)
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
  (setq display-line-numbers 'relative)
  (global-display-line-numbers-mode +1)
  ;; enable history
  (recentf-mode 1)
  (show-paren-mode +1)
  (if os-windows?
      (set-frame-font "JetBrains Mono 11")
    (set-frame-font "Iosevka 14")))

(use-package diminish
  :init
  (diminish 'eldoc-mode))

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


;; Packages
(use-package undo-fu)

;; This package implements support for mapping a pair of simultaneously pressed keys .
(use-package key-chord
  :config (key-chord-mode 1))

;; super-save auto-saves your buffers
(use-package super-save
  :diminish super-save-mode
  :ensure t
  :config
  (super-save-mode +1))

;;; Vim Bindings
(use-package evil
  :after (key-chord)
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-fu)
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

(use-package exec-path-from-shell
  :disabled os-windows?
  :config (exec-path-from-shell-initialize))

(use-package magit)

(use-package whole-line-or-region
  :diminish (whole-line-or-region-global-mode whole-line-or-region-local-mode)
  :config (whole-line-or-region-global-mode +1))

(use-package company
  :diminish company-mode
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
  :diminish which-key-mode
  :config (which-key-mode +1))

(use-package ace-window
  :bind (("M-o" . ace-window)))

(use-package cider)

(use-package paredit
  :diminish paredit-mode
  :config
  (add-hook 'clojure-mode-hook #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))

(use-package eglot)

(use-package doom-themes
  :config (load-theme 'github-dark-vscode t))

(use-package nerd-icons)

(use-package doom-modeline
  :disabled t
  :hook (after-init . doom-modeline-mode)
  :config
  (doom-modeline-mode +1))

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))


(provide 'init)
;;; init.el ends here
