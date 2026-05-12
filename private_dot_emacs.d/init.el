(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)


(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1) ; Optional

(setq ring-bell-function 'ignore)
(recentf-mode 1)

;; automatically refresh files
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; history and place in file
(savehist-mode 1)
(save-place-mode 1)

(setq gc-cons-threshold 100000000) ; 100mb

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(set-face-attribute 'default nil :family "JetBrains Mono" :height 130)
(set-face-attribute 'fixed-pitch nil :family "JetBrains Mono" :height 1.0)
(set-face-attribute 'variable-pitch nil :family "Inter" :height 1.0)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(setq custom-safe-themes t)
(setq use-short-answers t)
(setq read-answer-short t)
(setq help-window-select t) ; also check `display-buffer-alist' below
(setq help-window-keep-selected t) ; Emacs 29
(setq find-library-include-other-files nil) ; Emacs 29
(setq window-combination-resize t)
(setq save-interprogram-paste-before-kill t)

(use-package solarized-theme
  :ensure t)

(use-package ef-themes
  :ensure t
  :config (load-theme 'ef-dream t))

(use-package dired
  :ensure nil
  :config
  ;; Most people I have talked to prefer a single Dired buffer.
  ;; Personally I like the many Dired buffers, but I understand why
  ;; this feels overwhelming.
  (setq dired-kill-when-opening-new-dired-buffer t)
  (setq dired-auto-revert-buffer #'dired-directory-changed-p) ; also see `dired-do-revert-buffer'
  (setq dired-clean-up-buffers-too t)
  (setq dired-clean-confirm-killing-deleted-buffers t)
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-create-destination-dirs 'ask)
  (setq dired-create-destination-dirs-on-trailing-dirsep t) ; Emacs 29
  (setq wdired-create-parent-directories t))


;;;; Completion Setup
(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

;;;; VERY USEFUL but not essential packages
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))

(use-package consult
  :ensure t
  ;; All commands have their utility, but those are commonly needed.
  :commands (consult-buffer consult-line consult-outline consult-find consult-grep))

(use-package embark
  :ensure t
  :bind
  ( :map minibuffer-local-map
    ("C-c C-c" . embark-collect)
    ("C-c C-e" . embark-export))
  :config
  ;; Needed for correct exporting while using Embark with Consult commands.
  (use-package embark-consult
    :ensure t
    :after consult))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode +1))

(use-package ace-window
  :ensure t
  :config (global-set-key (kbd "M-o") 'ace-window))

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode
          lisp-mode
          lisp-interaction-mode
          scheme-mode
          clojure-mode) . paredit-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package pulsar
  :ensure t
  :bind
  ( :map global-map
    ("C-x l" . pulsar-pulse-line) ; overrides `count-lines-page'
    ("C-x L" . pulsar-highlight-permanently-dwim)) ; or use `pulsar-highlight-temporarily-dwim'
  :init
  (pulsar-global-mode 1)
  :config
  (setq pulsar-delay 0.055)
  (setq pulsar-iterations 5)
  (setq pulsar-face 'pulsar-blue)
  (setq pulsar-region-face 'pulsar-yellow)
  (setq pulsar-highlight-face 'pulsar-blue))
