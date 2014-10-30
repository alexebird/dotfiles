(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; EVIL

;; must be set before require
(setq evil-want-C-u-scroll t)

;(require 'evil)
(evil-mode 1)

(menu-bar-mode -1)

(setq linum-format " %4d ")
(add-hook 'prog-mode-hook 'linum-mode)
;(global-linum-mode t)

(load-theme 'solarized-dark t)

;(require 'git-gutter)
;(global-git-gutter+-mode t)
;(git-gutter:linum-setup)
;(global-git-gutter-mode +1)

;(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
