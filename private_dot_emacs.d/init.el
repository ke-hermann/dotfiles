(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; general UX settings
(setq ring-bell-function #'ignore)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq vc-follow-symlinks t)

(electric-pair-mode +1)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq display-line-numbers-type 'relative)
;; history
(recentf-mode 1)

;; automatically update buffers
(global-auto-revert-mode +1)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; helpful completion suggestions
(which-key-mode +1)

;; custom themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'oxocarbon t)


;; Packages
(use-package doric-themes  :ensure t)

(use-package ef-themes)

(use-package whole-line-or-region
  :ensure t
  :config (whole-line-or-region-global-mode +1))

(use-package nov
  :ensure t)

(use-package magit
  :ensure t)

;; Vertico: minibuffer completion UI
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

;; Orderless: flexible matching
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides
        '((file (styles basic partial-completion)))))

;; Marginalia: annotations in minibuffer
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

;; Consult: powerful completion commands
(use-package consult
  :ensure t
  :bind (("C-x b" . consult-buffer)
         ("M-y"   . consult-yank-pop)
         ("C-s"   . consult-line)))

;; Corfu: completion popup
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)        ;; auto completion
  (corfu-cycle t))      ;; cycle candidates

;; Cape: completion sources
(use-package cape
  :ensure t
  :init
  ;; Add useful completion sources
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

;; TAB for completion everywhere
(setq tab-always-indent 'complete)

;; Enable completion in the minibuffer
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)

;; Embark: contextual actions
(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)         ;; pick an action
   ("C-;" . embark-dwim)        ;; do what I mean
   ("C-h B" . embark-bindings)) ;; show keybindings
  :init
  ;; Replace the default help with Embark
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package denote
  :ensure t
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . denote-dired)
   ("C-c n g" . denote-grep))
  :config
  (setq denote-directory (expand-file-name "~/Documents/notes/"))

  ;; Automatically rename Denote buffers when opening them so that
  ;; instead of their long file name they have, for example, a literal
  ;; "[D]" followed by the file's title.  Read the doc string of
  ;; `denote-rename-buffer-format' for how to modify this.
  (denote-rename-buffer-mode 1))

(use-package denote-journal
  :ensure t
  ;; Bind those to some key for your convenience.
  :commands ( denote-journal-new-entry
              denote-journal-new-or-existing-entry
              denote-journal-link-or-create-entry )
  :hook (calendar-mode . denote-journal-calendar-mode)
  :config
  ;; Use the "journal" subdirectory of the `denote-directory'.  Set this
  ;; to nil to use the `denote-directory' instead.
  (setq denote-journal-directory
        (expand-file-name "journal" denote-directory))
  ;; Default keyword for new journal entries. It can also be a list of
  ;; strings.
  (setq denote-journal-keyword "journal")
  ;; Read the doc string of `denote-journal-title-format'.
  (setq denote-journal-title-format 'day-date-month-year))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(with-eval-after-load 'evil
  (define-key evil-insert-state-map (kbd "j k") 'evil-normal-state))

;; Programming Configuration
(use-package paredit
  :ensure t
  :commands paredit-mode
  :hook
  (emacs-lisp-mode . paredit-mode))

(use-package enhanced-evil-paredit
  :ensure t
  :commands enhanced-evil-paredit-mode
  :hook (paredit-mode . enhanced-evil-paredit-mode))

(use-package python-mode
  :ensure t)

(use-package zig-mode
  :mode "\\.zig\\'")

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(zig-mode . ("zls"))))

(use-package eglot
  :ensure nil
  :hook ((python-mode zig-mode) . eglot-ensure))

;; Keybindings
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
(global-set-key (kbd "<f7>") #'menu-bar-mode)
