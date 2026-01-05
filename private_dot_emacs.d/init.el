(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
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


;; Packages
(use-package doric-themes)

(use-package ef-themes)

(use-package whole-line-or-region
  :ensure t
  :config (whole-line-or-region-global-mode +1))

(use-package nov
  :ensure t)

;; helpful completion suggestions
(which-key-mode +1)

;; code from /lisp dir
(load-file "~/.emacs.d/lisp/completion.el") ;; completion: VOMCECC
(load-file "~/.emacs.d/lisp/lisp-stack.el") ;; lisp editing
(load-file "~/.emacs.d/lisp/vim-stack.el") ;; vim support

;; Keybindings
;; additional global keybindings
; (global-set-key [remap dabbrev-expand] 'hippie-expand)
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

