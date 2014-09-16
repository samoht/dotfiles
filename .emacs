;; Mouse
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))

(require 'package)
(add-to-list 'package-archives
   '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; tuareg-mode
(add-to-list 'load-path "/Users/thomas/.opam/system/tuareg")
(load "tuareg-site-file")

;; ocp-indent
(add-to-list 'load-path "/Users/thomas/.opam/system/share/emacs/site-lisp")
(require 'ocp-indent)

;; merlin
(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(add-hook 'tuareg-mode-hook 'merlin-mode)
(require 'merlin)
;; (require 'merlin-iedit)
(setq merlin-use-auto-complete-mode 'easy)
(global-set-key [backtab] 'auto-complete)

;; Colored buffers
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; Enable copy/past in terminals
(require 'pbcopy)
(turn-on-pbcopy)

;; Remove trailing white-space
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(set-face-attribute 'whitespace-space nil :background "red" :foreground "blue")
(global-whitespace-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(custom-set-faces
 '(caml-types-expr-face ((t (:background "white" :foreground "black"))) t))
