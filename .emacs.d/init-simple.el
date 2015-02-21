;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
  '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(setq x-select-enable-clipboard t)

;; ido mode
(ido-mode 1)
;(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; misc
(menu-bar-mode -1)
(setq smooth-scroll-margin 5)
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 1)))
(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 1)))

;; projectile
(projectile-global-mode)

;; auto complete with company-mode
(add-hook 'after-init-hook 'global-company-mode)

;(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
;(add-hook 'cider-mode-hook 'ac-cider-setup)
;(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
;(eval-after-load "auto-complete"
  ;'(add-to-list 'ac-modes 'cider-mode))

;; color theme
(load-theme 'cyberpunk t)

;; rainbows
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; git gutter
(global-git-gutter-mode +1)

;; SMEX
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Ace Jump mode
(define-key global-map (kbd "C-o") 'ace-jump-mode)

;; Undo-Tree mode
(global-undo-tree-mode)
