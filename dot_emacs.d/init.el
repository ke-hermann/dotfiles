;;; package -- Personal Emacs Configuration
;;; Commentary:

;;; Code:

;; ███████╗███████╗████████╗██╗   ██╗██████╗
;; ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
;; ███████╗█████╗     ██║   ██║   ██║██████╔╝
;; ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝
;; ███████║███████╗   ██║   ╚██████╔╝██║
;; ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝


(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))


;; make custom elisp code available
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/themes")
(require 'utilities)
(require 'openwith)

;; variables to toggle various groups of packages
(defvar evil-t +1)
;; set default dir on startup
(cd (expand-file-name "~"))


;; ██████╗  █████╗ ███████╗██╗ ██████╗███████╗
;; ██╔══██╗██╔══██╗██╔════╝██║██╔════╝██╔════╝
;; ██████╔╝███████║███████╗██║██║     ███████╗
;; ██╔══██╗██╔══██║╚════██║██║██║     ╚════██║
;; ██████╔╝██║  ██║███████║██║╚██████╗███████║
;; ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝ ╚═════╝╚══════╝


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

(let ((mono-spaced-font "Cascadia Code")
      (proportionately-spaced-font "Inter"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 130)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

(prefer-coding-system 'utf-8)


;; ██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗███████╗
;; ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝██╔════╝
;; ██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗  ███████╗
;; ██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝  ╚════██║
;; ██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗███████║
;; ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝


(use-package doric-themes
  :ensure t)

(use-package gruvbox
  :ensure t
  :config (load-theme 'gruvbox-light-soft t))

(use-package multiple-cursors
  :ensure t
  ;; not needed in vim mode
  :disabled t
  :config
  (global-set-key (kbd "C-x m") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-x e") 'mc/mark-all-like-this))


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


(use-package nerd-icons
  :ensure t)


(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

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

(use-package go-mode
  :mode "\\.go\\'"
  :hook ((before-save . gofmt-before-save))
  :config
  (setq gofmt-command "goimports")) ;; Automatically fix imports too

(use-package cider :ensure t)

(use-package paredit
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode #'paredit-mode))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :bind ("C-x g" . magit-status))

(use-package nov
  :ensure t)

;; For better error/warning visualization
(use-package flycheck
  :ensure t
  :custom (flycheck-emacs-lisp-load-path 'inherit)
  :diminish flycheck-mode
  :config (add-hook 'after-init-hook #'global-flycheck-mode))

;; ██████╗ ██████╗ ███╗   ███╗██████╗ ██╗     ███████╗████████╗██╗ ██████╗ ███╗   ██╗
;; ██╔════╝██╔═══██╗████╗ ████║██╔══██╗██║     ██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║
;; ██║     ██║   ██║██╔████╔██║██████╔╝██║     █████╗     ██║   ██║██║   ██║██╔██╗ ██║
;; ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══╝     ██║   ██║██║   ██║██║╚██╗██║
;; ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ███████╗███████╗   ██║   ██║╚██████╔╝██║ ╚████║
;;  ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚══════╝╚══════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝


;; Enable vertico
(use-package vertico
  :ensure t
  :custom
  (enable-recursive-minibuffers t)
  (vertico-resize t)
  (vertico-cycle t)
  :init
  (vertico-mode +1))

;; Example configuration for Consult
(use-package consult
  :ensure t
  :bind (("C-c M-x" . consult-mode-command)
	 ("C-c h" . consult-history)
         ("C-x C-j" . consult-recent-file)
         ([remap Info-search] . consult-info)
         ("C-x b" . consult-buffer)
         ("C-c b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
	 ("C-x t c" . consult-theme)
         ("M-y" . consult-yank-pop)
         ("C-c f f" . consult-fd)
         ("C-c f g" . consult-ripgrep)
         ("C-c f l" . consult-locate)
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
  :ensure t
  :bind
  (("C-," . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings)))

(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :ensure t
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  ;; The :init section is always executed.
  :init (marginalia-mode))

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :config
  (use-package corfu-popupinfo
    :ensure nil ; corfu-popupinfo is included with corfu
    :init
    (corfu-popupinfo-mode))
  :custom
  (corfu-popupinfo-delay '(0.5 . 0.2)) ; Show popup after 0.5s,; update after 0.2s
  (corfu-auto t)		    ;; Enable auto-completion
  (corfu-cycle t)		    ;; Enable cycling for completions
  (corfu-preselect 'prompt)	    ;; Preselect the prompt
  (corfu-quit-no-match 'separator)) ;; Quit if no match after separator


;; ███████╗██╗   ██╗██╗██╗
;; ██╔════╝██║   ██║██║██║
;; █████╗  ██║   ██║██║██║
;; ██╔══╝  ╚██╗ ██╔╝██║██║
;; ███████╗ ╚████╔╝ ██║███████╗
;; ╚══════╝  ╚═══╝  ╚═╝╚══════╝


;; Install and configure Evil
(use-package evil
:ensure t
:init
(setq evil-want-integration t)
(setq evil-want-keybinding nil)      ; important for evil-collection
(setq evil-want-C-u-scroll t)
(setq evil-undo-system 'undo-redo)
:config
(evil-mode evil-t)

;; Custom "jk" to escape insert mode
(define-key evil-insert-state-map (kbd "j")
	    (lambda () (interactive)
	      (let ((next-key (read-event "j")))
		(if (and (characterp next-key) (char-equal next-key ?k))
		    (evil-normal-state)
		  (insert "j")
		  (setq unread-command-events (list next-key)))))))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode evil-t))

;; Evil Collection for better integration with other modes
(use-package evil-collection
  :ensure t
  :after evil
  :config
  (when (> evil-t 0) (evil-collection-init)))

(use-package reader
    :vc t
    :load-path "~/.emacs.d/elisp/emacs-reader")


;;  ██████╗ ██████╗  ██████╗       ███╗   ███╗ ██████╗ ██████╗ ███████╗
;; ██╔═══██╗██╔══██╗██╔════╝       ████╗ ████║██╔═══██╗██╔══██╗██╔════╝
;; ██║   ██║██████╔╝██║  ███╗█████╗██╔████╔██║██║   ██║██║  ██║█████╗
;; ██║   ██║██╔══██╗██║   ██║╚════╝██║╚██╔╝██║██║   ██║██║  ██║██╔══╝
;; ╚██████╔╝██║  ██║╚██████╔╝      ██║ ╚═╝ ██║╚██████╔╝██████╔╝███████╗
;;  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝       ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════

(use-package org
  :ensure nil ;; builtin
  :bind (("C-c a" . org-agenda)
	 ("C-c i l" . org-insert-formatted-link)
	 ("C-c t l" . org-insert-file-task-list))
  :config
  ;; Basic settings
  (setq org-startup-indented t)	;; Enable indent mode for cleaner visuals
  (setq org-startup-folded t)	;; Start with folded headings
  (setq org-log-done 'time)	;; Log time when tasks are marked DONE
  (setq org-hide-emphasis-markers t) ;; Hide markup markers (e.g., *bold* -> bold)
  (setq org-pretty-entities t) ;; Display entities like \alpha as symbols

  ;; Default directory for Org files
  (setq org-directory "~/org/")
  (setq org-default-notes-file "~/org/notes.org")

  ;; Agenda settings
  (setq org-agenda-files '("~/org/agenda.org")))

(use-package org-capture
  :ensure nil
  :bind (("C-c c". org-capture))
  :config
  ;; Org Capture Templates
  (setq org-capture-templates
	'(("t" "Todo" entry
           (file+headline "~/org/todo.org" "Tasks")
           "* TODO %?\n  %U\n  %a")
          ("n" "Note" entry
           (file+headline "~/org/atoms.org" "Notes")
           "* %? :note:\n  %U\n  %a"))))

(use-package org-journal
  :ensure t
  :custom
  (org-journal-dir (file-truename "~/org/journals"))
  (org-journal-file-format "%Y-%m-%d.org"))


;; ██╗  ██╗███████╗██╗   ██╗██████╗ ██╗███╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗ ███████╗
;; ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔══██╗██║████╗  ██║██╔══██╗██║████╗  ██║██╔════╝ ██╔════╝
;; █████╔╝ █████╗   ╚████╔╝ ██████╔╝██║██╔██╗ ██║██║  ██║██║██╔██╗ ██║██║  ███╗███████╗
;; ██╔═██╗ ██╔══╝    ╚██╔╝  ██╔══██╗██║██║╚██╗██║██║  ██║██║██║╚██╗██║██║   ██║╚════██║
;; ██║  ██╗███████╗   ██║   ██████╔╝██║██║ ╚████║██████╔╝██║██║ ╚████║╚██████╔╝███████║
;; ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝


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

(provide 'init)
;;; init.el ends here
