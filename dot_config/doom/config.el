;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(setq user-full-name "Kevin Hermann"
      user-mail-address "hermannkevin@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face

(setq doom-theme 'doom-solarized-light)
(setq doom-font (font-spec :family "JetBrains Mono" :size 14 :weight 'regular))

(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;;;;;;;;;;;;;;;;;
;; KEYBINDINGS ;;
;;;;;;;;;;;;;;;;;

(map! [f8] (lambda () (interactive) (consult-theme 'doom-solarized-dark)))
(map! [f9] (lambda () (interactive) (consult-theme 'doom-solarized-light)))

;;;;;;;;;;;;;;;;;;;
;; VARIOUS HOOKS ;;
;;;;;;;;;;;;;;;;;;;

(add-hook! clojure-mode
           (paredit-mode +1))
