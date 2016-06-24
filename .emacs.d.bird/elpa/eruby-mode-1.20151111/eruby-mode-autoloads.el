;;; eruby-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (eruby-mode-auto-mode eruby-mode) "eruby-mode"
;;;;;;  "eruby-mode.el" (22256 26040 471991 957000))
;;; Generated autoloads from eruby-mode.el

(autoload 'eruby-mode "eruby-mode" "\
Minor mode for eRuby templates

\(fn &optional ARG)" t nil)

(defconst eruby-mode-file-regexp "\\.erb\\'")

(add-to-list 'auto-mode-alist `(,eruby-mode-file-regexp ignore t))

(autoload 'eruby-mode-auto-mode "eruby-mode" "\
Turn on eRuby mode for appropriate file extensions.

\(fn)" nil nil)

(add-hook 'find-file-hook #'eruby-mode-auto-mode)

;;;***

;;;### (autoloads nil nil ("eruby-mode-pkg.el") (22256 26040 503096
;;;;;;  863000))

;;;***

(provide 'eruby-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; eruby-mode-autoloads.el ends here
