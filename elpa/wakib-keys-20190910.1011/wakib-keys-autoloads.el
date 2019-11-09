;;; wakib-keys-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "wakib-keys" "wakib-keys.el" (0 0 0 0))
;;; Generated autoloads from wakib-keys.el

(defvar wakib-keys nil "\
Non-nil if Wakib-Keys mode is enabled.
See the `wakib-keys' command
for a description of this minor mode.")

(custom-autoload 'wakib-keys "wakib-keys" nil)

(autoload 'wakib-keys "wakib-keys" "\
This mode brings modern style keybindings to Emacs.
Major changes is proper CUA key bindings by moving C-c and C-x to
C-d and C-e respectively. This allow access to all the keybindings of
Emacs while not tripping up users who do not want a steep learning curve
just to use their editor.

Note that only the first prefix is changed. So C-c C-c becomes C-d C-c.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wakib-keys" '("wakib-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; wakib-keys-autoloads.el ends here
