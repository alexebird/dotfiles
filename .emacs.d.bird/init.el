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

;; EVIL
;; must be set before require
;(setq evil-want-C-u-scroll t)
;(require 'evil)
;(evil-mode 1)

;; misc
(menu-bar-mode -1)
(setq smooth-scroll-margin 5)
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 1)))
(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 1)))

;; projectile
(projectile-global-mode)
;(add-hook 'prog-mode-hook 'projectile-mode)

;; linum
;(setq linum-format " %4d ")
;(add-hook 'prog-mode-hook 'linum-mode)
;(global-linum-mode t)

(add-hook 'after-init-hook 'global-company-mode)

(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-mode))

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

;; Ruby Mode
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . enh-ruby-mode))


;; Clojure
 (add-hook 'lisp-mode-hook 'paredit-mode)
 ;(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
 (add-hook 'ielm-mode-hook 'paredit-mode)
 (add-hook 'clojure-mode-hook 'paredit-mode)
 (add-hook 'cider-repl-mode-hook 'paredit-mode)
 (add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
 (add-hook 'cider-mode-hook 'turn-on-eldoc-mode)

;; Ace Jump mode
(define-key global-map (kbd "C-o") 'ace-jump-char-mode)

;; Undo-Tree mode
(global-undo-tree-mode)

;; Key bindings
;(defun switch-to-previous-buffer ()
;  "Switch to previously open buffer. Repeated invocations toggle between the two most recently open buffers."
;    (interactive)
;    (switch-to-buffer (other-buffer (current-buffer) 1)))

;(global-set-key (kbd "C-x C-j") 'switch-to-previous-buffer)
