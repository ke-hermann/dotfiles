(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; custom themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; custom configuration variables and settings
(defcustom my-theme-candidates '(solarized-dark solarized-light) "selection of themes to cycle through.")
(defcustom config-evil-enabled nil "decide whether evil layer should be enabled.")
(defcustom config-font-mono"Cascadia Code" "monospaced font")
(defcustom config-font-mono-height 130 "monospaced font size")
(defcustom config-font-ui "Inter" "font used for the UI")
;; font settings
(let ((mono-spaced-font config-font-mono)
      (proportionately-spaced-font config-font-ui))
  (set-face-attribute 'default nil :family mono-spaced-font :height config-font-mono-height)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

;; Packages
(use-package emacs
  :custom
  ;; Still needed for terminals
  (menu-bar-mode nil)         ;; Disable the menu bar
  (scroll-bar-mode nil)       ;; Disable the scroll bar
  (tool-bar-mode nil)         ;; Disable the tool bar

  (ring-bell-function 'ignore) ;; turn the obnoxious bell off

  (inhibit-startup-screen t)  ;; Disable welcome screen

  (delete-selection-mode t)   ;; Select text and delete it by typing.
  (electric-indent-mode t)  ;; Turn off the weird indenting that Emacs does by default.
  (electric-pair-mode t)      ;; Turns on automatic parens pairing

  (global-auto-revert-mode t) ;; Automatically reload file and show changes if the file has changed
  (use-short-answers t)   ;; Since Emacs 29, `yes-or-no-p' will use `y-or-n-p'

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
  ;; Move customization variables to a separate file and load it, avoid filling up init.el with unnecessary variables
  (setq custom-file (locate-user-emacs-file "custom-vars.el"))
  (load custom-file 'noerror 'nomessage)
  :bind (([escape] . keyboard-escape-quit) ;; Makes Escape quit prompts
         ))

;; themes
(use-package solarized-theme :ensure t)
(use-package doric-themes :ensure t)
(use-package ef-themes :ensure t)

(use-package org-modern
  :ensure t
  :config
  (global-org-modern-mode))

(use-package doom-modeline
  :ensure t
  :custom
  (doom-modeline-height 25) ;; Set modeline height
  :hook (after-init . doom-modeline-mode))

(use-package nerd-icons :ensure t)

(use-package nerd-icons-dired
  :ensure t
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

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
         ("C-c h" . consult-history)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ("C-c f" . consult-fd)
         ([remap Info-search] . consult-info)
         ("C-x r b" . consult-bookmark)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("C-x p b" . consult-project-buffer)))

;; Corfu: completion popup
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
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
  (("C-," . embark-act)         ;; pick an action
   ("C-;" . embark-dwim)        ;; do what I mean
   ("C-h B" . embark-bindings)) ;; show keybindings
  :init
  ;; Replace the default help with Embark
  (setq prefix-help-command #'embark-prefix-help-command))

(setq denote-directory (expand-file-name "~/Documents/notes"))
;; helper function to search notes with consult given that
;; the denote builtin grep command does not work on windows
;; due to `xargs' dependencies
(defun denote-ripgrep ()
  (interactive)
  (consult-ripgrep denote-directory))
;; same for `denote-dired'
(defun denote-fd ()
  (interactive)
  (consult-fd denote-directory))

(use-package denote
  :ensure t
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . denote-dired)
   ("C-c n g" . denote-ripgrep)
   ("C-c n f" . denote-fd))
  :config
  ;; Automatically shorten Denote buffers names
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
  :if config-evil-enabled
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

;; Programming Configuration
(use-package paredit
  :ensure t
  :commands paredit-mode
  :hook
  (emacs-lisp-mode . paredit-mode))

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
  :ensure t
  :config (apheleia-global-mode +1))

(use-package empv
  :ensure nil
  :config
  (setq empv-video-dir "D:/Videos"))

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
                                        ;:vc (:url "https://github.com/jdtsmith/ultra-scroll") ; if desired (emacs>=v30)
  :ensure t
  :init
  (setq scroll-conservatively 3 ; or whatever value you prefer, since v0.4
        scroll-margin 0)        ; important: scroll-margin>0 not yet supported
  :config
  (ultra-scroll-mode 1))

;; theme switching

(defun cycle-theme-selection ()
  (interactive)
  (setq my-theme-candidates (-rotate 1 my-theme-candidates))
  (consult-theme (nth 0 my-theme-candidates)))

;; Keybindings
;; additional global keybindings
(global-set-key [remap dabbrev-expand] 'hippie-expand)
(global-set-key [remap list-buffers] 'ibuffer)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key [remap cycle-spacing] 'just-one-space)

(global-set-key (kbd "C-x C-r") 'recentf)

(global-set-key (kbd "M-n") 'scroll-up-command)
(global-set-key (kbd "M-p") 'scroll-down-command)

(global-set-key (kbd "C-x q") #'query-replace)
(global-set-key (kbd "<f7>") #'menu-bar-mode)
(global-set-key (kbd "<f9>") #'cycle-theme-selection)

