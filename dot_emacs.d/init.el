;;; package --- personal emacs configuration files
;;; Commentary:

;;; Code:
;; separate custom file location

;; custom file setup
(setq custom-safe-themes t)
(setq custom-file (expand-file-name "customs.el" user-emacs-directory))
(load custom-file)

;;;;;;;;;;;;;;;;;
;; MELPA setup ;;
;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;;;;;;;;;;;;;;;;;;;;
;; PACKAGE CONFIG ;;
;;;;;;;;;;;;;;;;;;;;

(load "~/.emacs.d/elisp/base-config.el")
(load "~/.emacs.d/elisp/ace-window-config.el")
(load "~/.emacs.d/elisp/cider-config.el")
(load "~/.emacs.d/elisp/company-config.el")
(load "~/.emacs.d/elisp/completion-config.el")
(load "~/.emacs.d/elisp/dap-mode-config.el")
(load "~/.emacs.d/elisp/diminish-config.el")
(load "~/.emacs.d/elisp/eglot-config.el")
(load "~/.emacs.d/elisp/evil-mode-config.el")
(load "~/.emacs.d/elisp/exec-path-from-shell-config.el")
(load "~/.emacs.d/elisp/flycheck-config.el")
;; (load "~/.emacs.d/elisp/helm-config.el")
(load "~/.emacs.d/elisp/key-chord-config.el")
(load "~/.emacs.d/elisp/magit-config.el")
(load "~/.emacs.d/elisp/paredit-config.el")
(load "~/.emacs.d/elisp/projectile-config.el")
(load "~/.emacs.d/elisp/python-config.el")
(load "~/.emacs.d/elisp/super-save-config.el")
(load "~/.emacs.d/elisp/themes-config.el")
(load "~/.emacs.d/elisp/tree-sitter-config.el")
(load "~/.emacs.d/elisp/undo-fu-config.el")
(load "~/.emacs.d/elisp/which-key-config.el")
(load "~/.emacs.d/elisp/whole-line-or-region-config.el")

;;;;;;;;;;;;;
;; KEYMAPS ;;
;;;;;;;;;;;;;

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key (kbd "<f6>") (lambda () (interactive) (consult-theme 'ef-elea-dark)))
(global-set-key (kbd "<f7>") (lambda () (interactive) (consult-theme 'ef-kassio)))
(global-set-key (kbd "<f8>") 'menu-bar-mode)

(provide 'init)
;;; init.el ends here
