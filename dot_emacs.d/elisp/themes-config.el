;;; package --- themes-config

;;; Commentary:
;;; Contains all theming related plugins

;;; Code:

(use-package nerd-icons)
(use-package tao-theme)
(use-package solarized-theme)
(use-package catppuccin-theme)
(use-package ef-themes)

(use-package doom-themes)

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :init (setq doom-modeline-icon nil)
  :config (doom-modeline-mode +1))

(provide 'themes-config)
;;; themes-config.el ends here
