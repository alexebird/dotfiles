(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; ido mode
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; EVIL
;; must be set before require
(setq evil-want-C-u-scroll t)
;(require 'evil)
(evil-mode 1)

;; misc
(menu-bar-mode -1)

;; projectile
(add-hook 'prog-mode-hook 'projectile-mode)

;; linum
(setq linum-format " %4d ")
(add-hook 'prog-mode-hook 'linum-mode)
;(global-linum-mode t)

;; color theme
(load-theme 'solarized-dark t)

;; git gutter
;(require 'git-gutter)
;(global-git-gutter+-mode t)
;(git-gutter:linum-setup)
;(global-git-gutter-mode +1)

;; SMEX
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
