(use-package package
  :ensure nil
  :config
  (setq package-archives
        '(("gnu-elpa" . "https://elpa.gnu.org/packages/")
          ("nongnu" . "https://elpa.nongnu.org/nongnu/")
          ("melpa" . "https://melpa.org/packages/")))
  (setq package-archive-priorities
        '(("gnu-elpa" . 3)
          ("nongnu" . 2)
          ("melpa" . 1))))

;; Packages
(use-package emacs
  :custom
  ;; Still needed for terminals
  (menu-bar-mode nil)         ;; Disable the menu bar
  (scroll-bar-mode nil)       ;; Disable the scroll bar
  (tool-bar-mode nil)         ;; Disable the tool bar

(use-package solarized-theme
  :ensure t)

(use-package ef-themes
  :ensure t
  :config (load-theme 'ef-dream t))

  (electric-indent-mode t)  ;; Turn off the weird indenting that Emacs does by default.
  (electric-pair-mode t)      ;; Turns on automatic parens pairing

  (global-auto-revert-mode t) ;; Automatically reload file and show changes if the file has changed

  (custom-safe-themes t)
  (use-short-answers t)
  (read-answer-short t)

  (recentf-mode t) ;; Enable recent file mode

  (global-display-line-numbers-mode t)  ;; Display line numbers
  (global-hl-line-mode t)               ;; Highlight current line

  (native-comp-async-report-warnings-errors 'silent) ;; Don't show native comp errors
  (warning-minimum-level :error) ;; Only show errors in warnings buffer

  (indent-tabs-mode nil) ;; Only use spaces for indentation
  (tab-width 4)

  (whitespace-style '(face tabs tab-mark trailing))

  (make-backup-files nil) ;; Stop creating ~ backup files
  (auto-save-default nil) ;; Stop creating # auto save files
  (delete-by-moving-to-trash t)
  :hook
  (prog-mode . hs-minor-mode) ;; Enable folding hide/show globally
  ;; (prog-mode . display-fill-column-indicator-mode) ;; Display line length indicator
  (prog-mode . whitespace-mode)
  :config
  (set-face-attribute 'default nil :family "PragmataPro" :height 140)
  (set-face-attribute 'fixed-pitch nil :family "PragmataPro" :height 1.0)
  (set-face-attribute 'variable-pitch nil :family "Inter" :height 1.0)
  ;; Move customization variables to a separate file and load it, avoid filling up init.el with unnecessary variables
  :bind (([escape] . keyboard-escape-quit) ;; Makes Escape quit prompts
         ))

;; Without the `custom-file', Emacs writes directly to the "init.el",
;; which can be confusing.
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(use-package ef-themes
  :ensure t
  :config (load-theme 'ef-dream t))

;;;; Save minibuffer histories
(use-package savehist
  :ensure nil
  :config
  (savehist-mode 1))

;; simplified window switching
(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'ace-window))

;;;; Delete the selected text when inserting new text
(use-package delsel
  :ensure nil
  :config
  (delete-selection-mode 1))

(use-package org-modern
  :ensure t
  :config
  (vertico-mode 1))

;;;; Bookmarks
(use-package bookmark
  :ensure nil
  :config
  ;; Write changes to the file when modified.
  (setq bookmark-save-flag 1))

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
  (setq pulsar-iterations 5))

(use-package whole-line-or-region
  :ensure t
  :config (whole-line-or-region-global-mode +1))

(use-package nov
  :ensure t)

(use-package magit
  :ensure t)

(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

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
  ;; Embark is helpful in every context, though there are other ways
  ;; to do what it does.  Where it stands out is in its ability to
  ;; deal with all the minibuffer results.  The equivalent of those
  ;; two commands should be a core Emacs functionality.
  ("C-," . embark-act)
  ( :map minibuffer-local-map
    ("C-c C-c" . embark-collect)
    ("C-c C-e" . embark-export))
  :config
  ;; Needed for correct exporting while using Embark with Consult commands.
  (use-package embark-consult
    :ensure t
    :after consult))

;; Useful when combined with `delete-by-moving-to-trash'.
(use-package trashed
  :ensure t)

;; Corfu: completion popup
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :custom
  (corfu-auto t)   ;; auto completion
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

(use-package evil
  :ensure t
  :custom
  (evil-want-integration t)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  (evil-want-C-i-jump nil)
  (evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :if config-evil-enabled
  :after evil
  :config
  (evil-collection-init))

(use-package rainbow-delimiters
  :ensure t
  :config (rainbow-delimiters-mode +1))

;; SBCl / common lisp config
(use-package sly
  :ensure t
  :init
  (setq inferior-lisp-program "sbcl")
  :config
  ;; Enable useful SLY modules
  (setq sly-contribs '(sly-fancy))
  ;; nicer REPL history
  (setq sly-history-file "~/.emacs.d/sly-history.eld"))


;; Programming Configuration
(use-package paredit
  :ensure t
  :commands paredit-mode
  :hook
  (emacs-lisp-mode . paredit-mode)
  (lisp-mode . paredit-mode))

(use-package magit
  :defer
  :custom (magit-diff-refine-hunk (quote all)) ;; Shows inline diff
  :config
  (setopt magit-format-file-function #'magit-format-file-nerd-icons) ;; Magit nerd icons
  )

(use-package enhanced-evil-paredit
  :ensure t
  :if config-evil-enabled
  :commands enhanced-evil-paredit-mode
  :hook (paredit-mode . enhanced-evil-paredit-mode))

(use-package lua-mode
  :ensure t)

(use-package zig-mode
  :mode "\\.zig\\'")

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(zig-mode . ("zls"))))

(use-package eglot
  :ensure nil
  :hook ((python-mode zig-mode) . eglot-ensure))

(use-package apheleia
  :if (not (eq system-type 'windows-nt))
  :ensure t
  :config (apheleia-global-mode +1))

(use-package which-key
  :ensure nil ;; Don't install which-key because it's now built-in
  :hook (after-init . which-key-mode)
  :diminish
  :custom
  (which-key-side-window-location 'bottom)
  (which-key-sort-order #'which-key-key-order-alpha) ;; Same as default, except single characters are sorted alphabetically
  (which-key-sort-uppercase-first nil)
  (which-key-add-column-padding 1) ;; Number of spaces to add to the left of each column
  (which-key-min-display-lines 6)  ;; Increase the minimum lines to display because the default is only 1
  (which-key-idle-delay 0.8)       ;; Set the time delay (in seconds) for the which-key popup to appear
  (which-key-max-description-length 25)
  (which-key-allow-imprecise-window-fit nil)) ;; Fixes which-key window slipping out in Emacs Daemon

(use-package ultra-scroll
  :ensure t
  :init
  (setq scroll-conservatively 3 ; or whatever value you prefer, since v0.4
        scroll-margin 0)        ; important: scroll-margin>0 not yet supported
  :config
  (ultra-scroll-mode 1))

;; Keybindings
;; additional global keybindings
(global-set-key [remap dabbrev-expand] 'hippie-expand)
(global-set-key [remap list-buffers] 'ibuffer)
(global-set-key [remap cycle-spacing] 'just-one-space)

(global-set-key (kbd "C-x C-r") 'recentf)

(global-set-key (kbd "M-n") 'scroll-up-command)
(global-set-key (kbd "M-p") 'scroll-down-command)

(global-set-key (kbd "C-x q") #'query-replace)
(global-set-key (kbd "<f7>") #'menu-bar-mode)
(global-set-key (kbd "<f9>") #'cycle-theme-selection)

