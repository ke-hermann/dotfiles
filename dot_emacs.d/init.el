;;; package --- personal emacs configuration files
;;; Commentary:
;;; Code:

;; figure out what OS we're on
(defvar os-windows? (string= system-type "windows-nt"))

;; melpa setup 
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; custom file

(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
      (load-file custom-file))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'eleuther t)

;; font
(set-face-attribute 'default nil :font "Iosevka-14")

;; General Settings

;; no backup or custom file
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq vc-follow-symlinks t)
;; shut the annoying alarm sound up
(setq ring-bell-function 'ignore)
(setq custom-safe-themes t)
(electric-pair-mode +1)
;; Hide unnecessary UI elements
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; (global-hl-line-mode +1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)
;; enable history
(recentf-mode 1)
;; automatically load changed files
(global-auto-revert-mode +1)
(show-paren-mode +1)
;; custom theme dir

(setq custom-theme-directory "~/.emacs.d/themes")

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
  :config (doom-modeline-mode +1))

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

;; Evil Setup
(use-package evil
  :ensure t
  :disabled t
  :after (key-chord)
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-insert-state-cursor 'box)
  (setq evil-undo-sytem 'undo-redo)
  :config (evil-mode 1))

(use-package evil-escape
  :ensure t
  :disabled t
  :diminish evil-escape-mode
  :config
  (setq-default evil-escape-key-sequence "jk")
  (evil-escape-mode +1))


;; easy wrapping of text objects
(use-package evil-surround
  :ensure t
  :disabled t
  :config
  (global-evil-surround-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :ensure t
  :disabled t
  :diminish evil-collection-unimpaired-mode
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

;; formatting
(use-package format-all
  :ensure t
  :config (add-hook 'prog-mode-hook 'format-all-mode))

;; COMPLETION

;; Enable vertico
(use-package vertico
  :ensure t
  :init
  (vertico-mode +1))

;; Add prompt indicator to `completing-read-multiple'.
;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
(defun crm-indicator (args)
  (cons (format "[CRM%s] %s"
		(replace-regexp-in-string
		 "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
		 crm-separator)
		(car args))
	(cdr args)))
(advice-add #'completing-read-multiple :filter-args #'crm-indicator)

;; Do not allow the cursor in the minibuffer prompt
(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
;; Enable recursive minibuffers
(setq enable-recursive-minibuffers t)


;; Optionally use the `orderless' completion style.
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic)
	completion-category-defaults nil
	completion-category-overrides '((file (styles partial-completion)))))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :ensure t
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
	 :map minibuffer-local-map
	 ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init
  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))


(use-package embark
  :ensure t

  :bind
  (("C-," . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
	       '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
		 nil
		 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Example configuration for Consult
(use-package consult
  :ensure t
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
	 ("C-c h" . consult-history)
	 ("C-c m" . consult-mode-command)
	 ("C-c k" . consult-kmacro)
	 ;; C-x bindings (ctl-x-map)
	 ("C-x M-:" . consult-complex-command) ;; orig. repeat-complex-command
	 ("C-x b" . consult-buffer) ;; orig. switch-to-buffer
	 ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
	 ("C-x 5 b" . consult-buffer-other-frame) ;; orig. switch-to-buffer-other-frame
	 ("C-x r b" . consult-bookmark)	;; orig. bookmark-jump
	 ("C-x p b" . consult-project-buffer) ;; orig. project-switch-to-buffer
	 ("C-x C-r" . consult-recent-file)    ;; orig. r
	 ;; Custom M-# bindings for fast register access
	 ("M-#" . consult-register-load)
	 ("M-'" . consult-register-store) ;; orig. abbrev-prefix-mark (unrelated)
	 ("C-M-#" . consult-register)
	 ;; Other custom bindings
	 ("M-y" . consult-yank-pop)	;; orig. yank-pop
	 ("<help> a" . consult-apropos)	;; orig. apropos-command
	 ;; M-g bindings (goto-map)
	 ("M-g e" . consult-compile-error)
	 ("M-g f" . consult-flymake) ;; Alternative: consult-flycheck
	 ("M-g g" . consult-goto-line)	 ;; orig. goto-line
	 ("M-g M-g" . consult-goto-line) ;; orig. goto-line
	 ("M-g o" . consult-outline) ;; Alternative: consult-org-heading
	 ("M-g m" . consult-mark)
	 ("M-g k" . consult-global-mark)
	 ("M-g i" . consult-imenu)
	 ("M-g I" . consult-imenu-multi)
	 ;; M-s bindings (search-map)
	 ("M-s d" . consult-find)
	 ("M-s D" . consult-locate)
	 ("M-s g" . consult-grep)
	 ("M-s G" . consult-git-grep)
	 ("M-s r" . consult-ripgrep)
	 ("M-s l" . consult-line)
	 ("M-s L" . consult-line-multi)
	 ("M-s m" . consult-multi-occur)
	 ("M-s k" . consult-keep-lines)
	 ("M-s u" . consult-focus-lines)
	 ;; Isearch integration
	 ("M-s e" . consult-isearch-history)
	 :map isearch-mode-map
	 ("M-e" . consult-isearch-history) ;; orig. isearch-edit-string
	 ("M-s e" . consult-isearch-history) ;; orig. isearch-edit-string
	 ("M-s L" . consult-line-multi)	;; needed by consult-line to detect isearch
	 ;; Minibuffer history
	 :map minibuffer-local-map
	 ("M-s" . consult-history) ;; orig. next-matching-history-element
	 ("M-r" . consult-history)) ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
	register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
	xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<"))

;; KEYMAPS
(global-set-key (kbd "<f6>") (lambda () (interactive) (consult-theme 'solarized-light)))
(global-set-key (kbd "<f7>") (lambda () (interactive) (consult-theme 'solarized-dark)))
(global-set-key (kbd "<f8>") 'menu-bar-mode)
(global-set-key (kbd "M-n") 'scroll-up)
(global-set-key (kbd "M-p") 'scroll-down)
(global-set-key (kbd "C-x C-n") 'company-complete)
(global-set-key [remap dabbrev-expand] 'hippie-expand)

(provide 'init)
;;; init.el ends here
