;; Mouse
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))

(require 'package)
(add-to-list 'package-archives
   '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; tuareg-mode
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu"
  "Configuration of imenu for tuareg" t)
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
		("\\.topml$" . tuareg-mode))
	      auto-mode-alist))

;; ocp-indent
(add-to-list 'load-path "/Users/thomas/.opam/system/share/emacs/site-lisp")
(require 'ocp-indent)

;; ocp-index
(require 'merlin)
(require 'merlin-iedit)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(setq merlin-use-auto-complete-mode t)
(setq ac-auto-show-menu t)
(setq ac-auto-start nil)
(setq ac-delay 0.0)
(setq ac-expand-on-auto-complete nil)
(setq ac-ignore-case nil)
(setq ac-quick-help-delay 2)
(setq ac-trigger-commands nil)
;; (add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
;; (require 'ocp-index)
(global-set-key [backtab] 'auto-complete)

;; Colored buffers
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; Enable copy/past
(require 'pbcopy)
(turn-on-pbcopy)

;; Remove trailing white-space
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(custom-set-faces
 '(caml-types-expr-face ((t (:background "white" :foreground "black"))) t))
