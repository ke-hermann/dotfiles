(deftheme eleuther
  "Created 2023-10-21.")

(custom-theme-set-faces
 'eleuther
 '(default ((t (:family "Iosevka" :foundry "outline" :width normal :height 158 :weight regular :slant normal :underline nil :overline nil :extend nil :strike-through nil :box nil :inverse-video nil :foreground "tomato1" :background "#121212" :stipple nil :inherit nil))))
 '(cursor ((t (:foreground "#F6F6F6" :background "#FAFAFA"))))
 '(fixed-pitch ((t (:family "Iosevka"))))
 '(variable-pitch ((t (:height 1.0 :foreground "#C3C3C3"))))
 '(escape-glyph ((t (:weight bold :foreground "#F6F6F6"))))
 '(homoglyph ((t (:foreground "firebrick"))))
 '(minibuffer-prompt ((t (:foreground "ghost white" :background "gray11" :inherit (fixed-pitch)))))
 '(highlight ((t (:foreground "#FAFAFA" :background "#171717"))))
 '(region ((t (:extend t :foreground "ghost white" :background "gray11"))))
 '(shadow ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey50")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey70")) (((class color) (min-colors 8) (background light)) (:foreground "green")) (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))))
 '(secondary-selection ((t (:extend t :background "#252525"))))
 '(trailing-whitespace ((t (:background "#DADADA"))))
 '(font-lock-bracket-face ((t (:inherit (font-lock-punctuation-face)))))
 '(font-lock-builtin-face ((t (:slant normal :foreground "#F6F6F6"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#3C3C3C"))))
 '(font-lock-comment-face ((t (:height 1.0 :weight normal :slant italic :foreground "#C3C3C3" :inherit (variable-pitch)))))
 '(font-lock-constant-face ((t (:weight normal :slant normal :foreground "#E8E8E8"))))
 '(font-lock-delimiter-face ((t (:inherit (font-lock-punctuation-face)))))
 '(font-lock-doc-face ((t (:weight normal :slant italic :foreground "#C3C3C3"))))
 '(font-lock-doc-markup-face ((t (:inherit (font-lock-constant-face)))))
 '(font-lock-escape-face ((t (:inherit (font-lock-regexp-grouping-backslash)))))
 '(font-lock-function-call-face ((t (:inherit (font-lock-function-name-face)))))
 '(font-lock-function-name-face ((t (:weight normal :slant normal :box (:line-width (1 . -1) :color "#9E9E9E" :style nil) :foreground "#DADADA"))))
 '(font-lock-keyword-face ((t (:weight semi-bold :foreground "#C3C3C3"))))
 '(font-lock-negation-char-face ((t (:foreground "#FAFAFA"))))
 '(font-lock-number-face ((t nil)))
 '(font-lock-misc-punctuation-face ((t (:inherit (font-lock-punctuation-face)))))
 '(font-lock-operator-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:foreground "#E8E8E8"))))
 '(font-lock-property-name-face ((t (:inherit (font-lock-variable-name-face)))))
 '(font-lock-property-use-face ((t (:inherit (font-lock-property-name-face)))))
 '(font-lock-punctuation-face ((t nil)))
 '(font-lock-regexp-grouping-backslash ((t (:weight bold :foreground "#DADADA"))))
 '(font-lock-regexp-grouping-construct ((t (:weight bold :foreground "#F6F6F6"))))
 '(font-lock-string-face ((t (:slant italic :foreground "#C3C3C3"))))
 '(font-lock-type-face ((t (:slant italic :foreground "#C3C3C3"))))
 '(font-lock-variable-name-face ((t (:slant normal :foreground "#C3C3C3"))))
 '(font-lock-variable-use-face ((t (:inherit (font-lock-variable-name-face)))))
 '(font-lock-warning-face ((t (:inherit warning))))
 '(button ((t (:underline (:color foreground-color :style line :position nil)))))
 '(link ((t (:weight normal :underline (:color foreground-color :style line :position nil) :foreground "#F6F6F6"))))
 '(link-visited ((t (:weight normal :underline (:color foreground-color :style line :position nil) :foreground "#E8E8E8"))))
 '(fringe ((t (:weight normal :foreground "#616161"))))
 '(header-line ((t (:inherit (mode-line)))))
 '(tooltip ((t (:foreground "black" :background "lightyellow" :inherit (variable-pitch)))))
 '(mode-line ((t (:height 1.0 :box nil :foreground "#F1F1F1" :background "gray11"))))
 '(mode-line-buffer-id ((t (:weight bold :foreground "#FAFAFA"))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((t (:box (:line-width (2 . 2) :color "grey40" :style released-button)))))
 '(mode-line-inactive ((t (:height 1.0 :box nil :foreground "#C3C3C3" :background "#3C3C3C"))))
 '(isearch ((t (:weight bold :foreground "#E8E8E8" :background "#3C3C3C"))))
 '(isearch-fail ((t (:foreground "#F6F6F6" :background "#616161"))))
 '(lazy-highlight ((t (:weight bold :foreground "#E8E8E8" :background "#252525"))))
 '(match ((t (:weight bold :foreground "#E8E8E8" :background "#0E0E0E"))))
 '(next-error ((t (:inherit region))))
 '(query-replace ((t (:inherit isearch)))))

(provide-theme 'eleuther)
