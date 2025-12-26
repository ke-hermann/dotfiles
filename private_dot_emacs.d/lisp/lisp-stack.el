;;; lisp-stack-use-package.el --- Lisp editing stack -*- lexical-binding: t; -*-

;; Requires: use-package, Emacs 28+

;;; --------------------
;;; Common Lisp editing defaults
;;; --------------------

(defun my/lisp-setup ()
  "Common defaults for Lisp buffers."
  (electric-pair-local-mode -1)   ; paredit handles pairing
  (show-paren-mode 1)
  (setq-local comment-column 40))

;;; --------------------
;;; Paredit
;;; --------------------

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode
          lisp-interaction-mode
          lisp-mode
          scheme-mode
          clojure-mode
          clojurec-mode
          clojurescript-mode)
         . paredit-mode)
  :config
  ;; Familiar keybindings
  (define-key paredit-mode-map (kbd "M-(") #'paredit-wrap-round)
  (define-key paredit-mode-map (kbd "M-)") #'paredit-close-round))

;;; --------------------
;;; Eldoc (docs in minibuffer)
;;; --------------------

(use-package eldoc
  :ensure nil
  :hook ((emacs-lisp-mode . eldoc-mode)
         (lisp-interaction-mode . eldoc-mode)
         (clojure-mode . eldoc-mode)))

;;; --------------------
;;; Emacs Lisp
;;; --------------------

(use-package elisp-mode
  :ensure nil
  :hook (emacs-lisp-mode . my/lisp-setup)
  :bind (:map emacs-lisp-mode-map
              ("C-c C-c" . eval-defun)
              ("C-c C-b" . eval-buffer)
              ("C-c C-r" . eval-region)))

(use-package elisp-slime-nav
  :ensure t
  :hook (emacs-lisp-mode . elisp-slime-nav-mode))

(use-package macrostep
  :ensure t
  :bind (:map emacs-lisp-mode-map
              ("C-c m" . macrostep-expand)))

;;; --------------------
;;; Clojure
;;; --------------------

(use-package clojure-mode
  :ensure t
  :mode ("\\.clj\\'" "\\.cljs\\'" "\\.cljc\\'")
  :hook (clojure-mode . my/lisp-setup))

(use-package cider
  :ensure t
  :after clojure-mode
  :init
  (setq cider-repl-display-help-banner nil
        cider-repl-result-prefix ";; => "
        cider-repl-use-pretty-printing t
        cider-show-error-buffer 'only-in-repl
        cider-font-lock-dynamically '(macro core function var))
  :hook ((cider-mode . eldoc-mode)
         (cider-repl-mode . paredit-mode))
  :bind (:map clojure-mode-map
              ("C-c C-j" . cider-jack-in)
              ("C-c C-k" . cider-load-buffer)))

;;; --------------------
;;; REPL & evaluation helpers
;;; --------------------

(use-package eval-sexp-fu
  :ensure t
  :hook ((emacs-lisp-mode
          lisp-interaction-mode
          clojure-mode)
         . eval-sexp-fu-flash-mode))

;;; --------------------
;;; Structural navigation (optional but great)
;;; --------------------

(use-package smartparens
  :ensure t
  :disabled t) ;; Explicitly disabled; paredit is primary

;;; --------------------
;;; Quality-of-life
;;; --------------------

;; Keep Lisp indentation sane
(setq lisp-indent-offset 2)

;; Don’t overwrite selected text when typing parens
(delete-selection-mode 1)

(provide 'lisp-stack-use-package)
;;; lisp-stack-use-package.el ends here
