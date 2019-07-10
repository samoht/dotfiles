;; Mouse
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; add the system switch path to loaded paths
(setq opam-system-share
  (substring (shell-command-to-string "opam config var share --switch=system 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-system-share "/emacs/site-lisp"))

;; tuareg-mode
(load "tuareg-site-file")

;; add the current switch path to loaded paths
(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))

;; ocp-indent
(require 'ocp-indent)

;; merlin
(add-hook 'tuareg-mode-hook 'merlin-mode)
(require 'merlin)
;; (require 'merlin-iedit)
;; need: M-x package-install auto-complete
(require 'auto-complete)
(setq merlin-use-auto-complete-mode 'easy)
(define-key merlin-mode-map [backtab] 'auto-complete)
(define-key merlin-mode-map (kbd "C-c C-g") 'merlin-document)

;; ocamlformat
(require 'ocamlformat)
  (add-hook 'tuareg-mode-hook (lambda ()
  (define-key merlin-mode-map (kbd "<tab>") 'ocamlformat)
  (add-hook 'before-save-hook 'ocamlformat-before-save)))

;; Colored buffers
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; Enable copy/past in terminals
;; need: M-x package-install pbcopy
(require 'pbcopy)
(turn-on-pbcopy)

;; Remove trailing white-space
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(set-face-attribute 'whitespace-space nil :background "red" :foreground "blue")
(global-whitespace-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-to-list 'load-path "~/.emacs.d/capnp")
(require 'capnp-mode)
(add-to-list 'auto-mode-alist '("\\.capnp\\'" . capnp-mode))

(add-to-list 'load-path "~/.emacs.d/dockerfile")
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; markdown
;;(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
;;(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;;(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(caml-types-expr-face ((t (:background "white" :foreground "black"))) t)
 '(font-lock-function-name-face ((t (:foreground "brightblue"))))
 '(font-lock-string-face ((t (:foreground "SkyBlue"))))
 '(tuareg-font-lock-interactive-output-face ((t (:foreground "color-27")))))

;; (setq opam (substring (shell-command-to-string "opam config var prefix 2> /dev/null") 0 -1))
;; (setq refmt-command (concat opam "/bin/refmt"))
;; (require 'reason-mode)
;; (require 'merlin)
;; (setq merlin-ac-setup t)
;; (add-hook 'reason-mode-hook (lambda ()
;;                               (add-hook 'before-save-hook 'refmt-before-save)
;;                               (merlin-mode)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-mode merlin-eldoc edit-indirect json-mode tuareg pbcopy auto-complete))))

(setq-default indent-tabs-mode nil)

;; mdx
(setq markdown-fontify-code-blocks-natively t)
(define-derived-mode mdx-mode markdown-mode "MDX files"
  (merlin-mode)
  (merlin-flags "-pp 'mdx pp'"))

;; (require 'sturgeon)
