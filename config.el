;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")
(add-hook 'window-setup-hook #'toggle-frame-maximized)
(setq doom-font (font-spec :family "monospace" :size 16))
(setq mac-command-modifier 'control)
(setq mac-option-modifier 'meta)
(setq projectile-project-search-path '("~/repos/"))
(setq projectile-switch-project-action 'projectile-dired)


(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; String Inflection
(defun my-string-inflection-cycle-auto ()
    "switching by major-mode"
    (interactive)
    (cond
     ;; for emacs-lisp-mode
     ((eq major-mode 'emacs-lisp-mode)
      (string-inflection-all-cycle))
     ;; for python
     ((eq major-mode 'python-mode)
      (string-inflection-python-style-cycle))
     ;; for java
     ((eq major-mode 'java-mode)
      (string-inflection-java-style-cycle))
     (t
      ;; default
      (string-inflection-ruby-style-cycle))))

(use-package! string-inflection
  :defer 1
  :config
  (global-unset-key (kbd "C-c s"))
  (global-set-key (kbd "C-c s") 'my-string-inflection-cycle-auto))


(use-package! browse-kill-ring
  :config
  (map! :leader
        :desc "View kill ring"
        "k"
        #'browse-kill-ring))

(prodigy-define-service
  :name "GraphQl"
  :command "yarn dev"
  :cwd "~/repos/graphql-server"
  :stop-signal 'sigkill
  :kill-process-buffer-on-stop t)

;; keybind to disable search highlighting (like :set noh)
(map! :leader
      :desc "Clear search highlight"
      "s c"
      #'evil-ex-nohighlight)
