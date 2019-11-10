;; https://github.com/bbatsov/prelude/blob/master/core/prelude-packages.el
;; functions to automaticaly install dependencies



(require 'cl)
(require 'package)


(package-initialize)


(defvar prelude-packages
  '(wakib-keys
    zenburn-theme
    treemacs
    ivy
    swiper
    js2-mode
    elpy
    hydra
    ))


(defun prelude-packages-installed-p ()
  "Check if all packages in `prelude-packages' are installed."
  (every #'package-installed-p prelude-packages))


(defun prelude-require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package prelude-packages)
    (add-to-list 'prelude-packages package))
  (unless (package-installed-p package)
    (package-install package)))


(defun prelude-require-packages (packages)
  "Ensure PACKAGES are installed.
Missing packages are installed automatically."
  (mapc #'prelude-require-package packages))


(defun prelude-install-packages ()
  "Install all packages listed in `prelude-packages'."
  (unless (prelude-packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (prelude-require-packages prelude-packages)))

;; run package installation
(prelude-install-packages)


(provide 'prelude-packages)
(provide 'prelude-require-package)
(provide 'prelude-require-packages)
(provide 'prelude-install-packages)
