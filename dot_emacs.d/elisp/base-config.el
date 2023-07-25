;; General settings that don't fit anywhere else


(setq make-backup-files nil)
(setq auto-save-default nil)
(setq vc-follow-symlinks t)
(setq ring-bell-function 'ignore)
(setq custom-safe-themes t)
(electric-pair-mode +1)
;; Hide unnecessary UI elements
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
;; show line numbers and currently selected line
(global-hl-line-mode +1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)
;; enable history
(recentf-mode 1)
;; automatically load changed file s
(global-auto-revert-mode +1)
(show-paren-mode +1)
