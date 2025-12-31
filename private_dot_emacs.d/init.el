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

(setq custom-file (make-temp-file "emacs-custom"))
(when (file-exists-p custom-file)
  (load custom-file))

(let ((mono-spaced-font "Cascadia Code")
      (proportionately-spaced-font "Inter"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 130)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

;; Packages
(use-package doric-themes)

(use-package ef-themes
  :ensure t
  :config (load-theme 'ef-dark t))

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
;; (load-file "~/.emacs.d/lisp/vim-stack.el") ;; vim support

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(company company-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
