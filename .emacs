;; Mouse
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(add-to-list 'load-path "/usr/share/emacs/site-lisp")

(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
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
(load-file "/usr/local/share/typerex/ocp-indent/ocp-indent.el")
(custom-set-variables '(ocp-indent-syntax (quote ("lwt"))))

;; ocp-index
(load-file "/usr/local/share/typerex/ocp-index/ocp-index.el")
(global-set-key [backtab] 'auto-complete)

;; display and remove trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

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
