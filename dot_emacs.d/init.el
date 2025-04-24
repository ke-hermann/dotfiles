(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/pa
;;ckages/") t)
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

;;;;;;;;;;;;;;
;; PACKAGES ;;
;;;;;;;;;;;;;;

(setq use-package-always-ensure t)

;; Company-mode basic configuration
(use-package company
  :hook (after-init . global-company-mode)
  :init
  (setq company-minimum-prefix-length 1      ; Show completions after 1 character
        company-idle-delay 0.0               ; Show suggestions immediately
        company-tooltip-align-annotations t  ; Align annotations to the right tooltip border
        company-show-numbers t               ; Show numbers for quick selection
        company-selection-wrap-around t      ; Wrap around when navigating candidates
        company-tooltip-limit 20             ; Maximum number of candidates
        company-dabbrev-downcase nil         ; Don't downcase completions
        company-dabbrev-ignore-case t)       ; Ignore case when completing

  :config
  (global-company-mode 1)

  ;; Optional keybindings for company
  (define-key company-active-map (kbd "TAB") 'company-complete-selection)
  (define-key company-active-map (kbd "<tab>") 'company-complete-selection)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-d") 'company-show-doc-buffer)
  (define-key company-active-map (kbd "M-.") 'company-show-location))


(use-package eglot
  :hook ((python-mode go-mode) . eglot-ensure)
  :config
  (setq eglot-autoshutdown t)
  ;; Optional: if you want to specify servers manually
  ;; (add-to-list 'eglot-server-programs '(go-mode . ("gopls")))
)

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

(use-package doom-themes)

(use-package ef-themes
  :config (load-theme 'ef-bio t))

(use-package nov)

;; For better error/warning visualization
(use-package flycheck
  :diminish flycheck-mode
  :hook (eglot . flycheck-mode))

(use-package embark
  :bind
  (("C-," . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings)))

;; completion stack: vertico; consult; embark etc
(load "~/.emacs.d/elisp/completion.el")

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
