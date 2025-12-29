;;; completion-stack-use-package.el --- Modern completion stack -*- lexical-binding: t; -*-

;; Requires use-package to be installed and configured already

;;; --------------------
;;; Vertico
;;; --------------------

(use-package vertico
  :ensure t
  :init
  (setq vertico-cycle t)
  :config
  (vertico-mode 1))

;;; --------------------
;;; Orderless
;;; --------------------

(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides
        '((file (styles partial-completion)))))

;;; --------------------
;;; Marginalia
;;; --------------------

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

;;; --------------------
;;; Consult
;;; --------------------

(use-package consult
  :ensure t
  :bind (("C-s"   . consult-line)
         ("C-x b" . consult-buffer)
         ("M-y"   . consult-yank-pop)))

;;; --------------------
;;; Embark
;;; --------------------

(use-package embark
  :ensure t
  :bind (("C-."   . embark-act)
         ("C-;"   . embark-dwim)
         ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :ensure t
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;;; --------------------
;;; Corfu
;;; --------------------

(use-package corfu
  :ensure t
  :init
  (setq corfu-cycle t
        corfu-auto t
        corfu-auto-delay 0.1
        corfu-auto-prefix 1
        corfu-preview-current nil
        corfu-preselect 'prompt)
  :config
  (global-corfu-mode 1))

;; Enable Corfu in minibuffer when appropriate
(defun my/corfu-enable-in-minibuffer ()
  (when (where-is-internal #'completion-at-point (list (current-local-map)))
    (corfu-mode 1)))

(add-hook 'minibuffer-setup-hook #'my/corfu-enable-in-minibuffer)

;;; --------------------
;;; Cape
;;; --------------------

(use-package cape
  :ensure t
  :init
  ;; Add useful completion-at-point functions
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

;;; --------------------
;;; Sensible defaults
;;; --------------------

(setq completion-ignore-case t
      read-buffer-completion-ignore-case t
      read-file-name-completion-ignore-case t)

(provide 'completion-stack-use-package)
;;; completion-stack-use-package.el ends here
