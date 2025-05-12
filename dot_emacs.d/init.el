(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GENERAL EMACS CONFIG ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; hide unecessary warnings when compiling packages
(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

;; general ui config
(setq ring-bell-function #'ignore)
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

(setq custom-file (make-temp-file "emacs-custom"))
(when (file-exists-p custom-file)
  (load custom-file))

;; set typeface
;; (add-to-list 'default-frame-alist '(font . "Cascadia Code 14"))
(set-frame-font "JetBrains Mono 13" nil t)
(setq use-package-always-ensure t)

;;;;;;;;;;;;;;
;; PACKAGES ;;
;;;;;;;;;;;;;;

(use-package modus-themes)
(use-package ef-themes)
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-tokyo-night :no-confirm-loading))

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-x m") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;; Install and configure Corfu
(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map
	      ("C-n" . corfu-next)
	      ("C-p" . corfu-previous))
  :config
  ("C-x C-n" . corfu-complete)
  (setq corfu-auto t)
  (setq tab-always-indent 'complete)
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20)

  (setq corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1) ; shows documentation after `corfu-popupinfo-delay'

  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

;; Optional: Corfu-terminal for terminal support
(use-package corfu-terminal
  :if (not (display-graphic-p))
  :config
  (corfu-terminal-mode +1))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

;; Optional: Cape for enhanced completion at point
(use-package cape
  :init
  ;; Add useful defaults completion sources from Cape
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

;; Optional: kind-icon for fancy icons in completion UI
(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; Optional: Make corfu popup come up in terminal overlay
(use-package popon
  :if (not (display-graphic-p)))

;; Save history for better suggestions
(use-package savehist
  :init
  (savehist-mode))


(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package eglot
  :hook ((python-mode go-mode) . eglot-ensure)
  :config
  (setq eglot-autoshutdown t))

(use-package which-key
  :ensure t
  :config
  (which-key-mode +1))

(use-package python
  :ensure nil ;; built-in
  :hook (python-mode . (lambda ()
                         (setq python-indent-offset 4)))
  :config
  (setq python-shell-interpreter "python3"))

(use-package pet
  :config
  (add-hook 'python-base-mode-hook 'pet-mode -10))

(use-package paredit
  :hook ((emacs-lisp-mode lisp-mode lisp-interaction-mode scheme-mode clojure-mode) . paredit-mode))

(use-package go-mode
  :mode "\\.go\\'"
  :hook ((go-mode . eglot-ensure)
         (before-save . gofmt-before-save))
  :config
  (setq gofmt-command "goimports")) ;; Automatically fix imports too

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :bind ("C-x g" . magit-status))

(use-package nov)

;; For better error/warning visualization
(use-package flycheck
  :diminish flycheck-mode
  :hook (eglot . flycheck-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Completion and Navigation ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Enable vertico
(use-package vertico
  :custom
  (enable-recursive-minibuffers t)
  (vertico-resize t)
  (vertico-cycle t)
  :init
  (vertico-mode +1))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

;; Example configuration for Consult
(use-package consult
  :bind (("C-c M-x" . consult-mode-command)
	 ("C-c h" . consult-history)
         ("C-x C-r" . consult-recent-file)
         ([remap Info-search] . consult-info)
         ("C-x b" . consult-buffer)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
	 ("C-x t c" . consult-theme)
         ("M-y" . consult-yank-pop)
         ("M-g M-g" . consult-goto-line)
         ("M-s d" . consult-find)
         ("M-s c" . consult-locate)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))

  :hook (completion-list-mode . consult-preview-at-point-mode)
  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))

(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings)))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


;; additional global keybindings

(global-set-key [remap dabbrev-expand] 'hippie-expand)
(global-set-key [remap list-buffers] 'ibuffer)
(global-set-key (kbd "M-i") 'imenu)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key [remap cycle-spacing] 'just-one-space)

(global-set-key (kbd "M-[") 'tab-bar-history-back)
(global-set-key (kbd "M-]") 'tab-bar-history-forward)

(global-set-key (kbd "M-S-z") 'zap-up-to-char)
(global-set-key (kbd "C-x C-r") 'recentf)

(global-set-key (kbd "M-n") 'scroll-up-command)
(global-set-key (kbd "M-p") 'scroll-down-command)

(global-set-key (kbd "C-x q") #'query-replace)
