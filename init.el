;;----------------------------------------------------------------------------
;; Adjust garbage collection
;;----------------------------------------------------------------------------
(setq gc-cons-threshold (* 20 1024 1024))



;; ---------------------
;; Setup Load Path
;; ---------------------
(add-to-list 'load-path (expand-file-name "user" user-emacs-directory))


;; -----------------------
;; use-package
;; -----------------------
(setq load-prefer-newer t) ; Don't load outdated byte code

(require 'package)

(let*
    ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		  (not (gnutls-available-p))))
     (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))


(when (< (string-to-number emacs-version) 26.3)
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))


(package-initialize)
(setq package-enable-at-startup nil)


;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)
(use-package diminish)



(use-package wakib-keys
  :diminish wakib-keys
  :config
  (wakib-keys 1)
  (add-hook 'after-change-major-mode-hook 'wakib-update-major-mode-map)
  (add-hook 'menu-bar-update-hook 'wakib-update-minor-mode-maps)
  ;; Modifying other modules
  ;; When remap is used for wakib-next and wakib-previous it no longer works
  (define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
  (define-key isearch-mode-map (kbd "C-S-f") 'isearch-repeat-backward)
  (define-key isearch-mode-map (kbd "M-;") 'isearch-repeat-forward)
  (define-key isearch-mode-map (kbd "M-:") 'isearch-repeat-backward)
  (define-key isearch-mode-map (kbd "C-v") 'isearch-yank-kill))



;; -------------------
;; switch-window
;; -------------------
(use-package switch-window
  :bind ("M-H" . switch-window)
  :config
  (setq switch-window-shortcut-style 'qwerty)
  (setq switch-window-threshold 1))



;; -------------------
;; OWN SETINGS
;; -------------------
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files


(use-package zenburn-theme
  :config
  (load-theme 'zenburn t))


(cua-selection-mode 1) ; Enable CUA selection mode without the C-z/C-x/C-c/C-v bindings.
(toggle-scroll-bar -1) ; Disable vertical scroolbar
(menu-bar-mode -1) ; Disable menu bar
(tool-bar-mode -1)
(show-paren-mode 1)
(ivy-mode 1)
(elpy-enable)


(global-set-key (kbd "M-c") `minibuffer-keyboard-quit)
(global-set-key (kbd "M-z") `er/expand-region)


(defhydra hydra-elpy-region-move (global-map "M-<tab>")
  ("M-i" elpy-nav-move-line-or-region-up)
  ("M-k" elpy-nav-move-line-or-region-down)
  ("M-j" elpy-nav-indent-shift-left)
  ("M-l" elpy-nav-indent-shift-right))


(global-set-key (kbd "M-q") `treemacs)
(add-hook 'treemacs-mode-hook (lambda () (linum-mode -1)))


;; -------------------
;; linum snippet
;; -------------------
;; (setq linum-format " %d ")
(require 'linum-highlight-current-line-number)
(setq linum-format 'linum-highlight-current-line-number)
(global-linum-mode)



;; -------------------
;; ivy switch buffer snippet
;; -------------------
(defun my-ivy-switch-buffer (regex-list)
  (interactive)
  (let ((ivy-ignore-buffers regex-list))
    (ivy-switch-buffer)))


(defun my-ivy-switch-buffer-ignore ()
  (interactive)
  (my-ivy-switch-buffer `("\\` " "^*")))


(global-set-key
     (kbd "M-b") `my-ivy-switch-buffer-ignore)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("cdb4ffdecc682978da78700a461cdc77456c3a6df1c1803ae2dd55c59fa703e3" "e61752b5a3af12be08e99d076aedadd76052137560b7e684a8be2f8d2958edc3" default)))
 '(package-selected-packages
   (quote
    (expand-region neotree elpy js2-mode swiper ivy treemacs rainbow-delimiters zenburn-theme moe-theme wakib-keys diminish use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
