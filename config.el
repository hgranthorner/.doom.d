;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Grant Horner"
      user-mail-address "h.grant.horner@gmail.com")
(add-hook 'window-setup-hook #'toggle-frame-maximized)
(setq doom-font (font-spec :family "monospace" :size 17))
(setq mac-command-modifier 'control)
(setq mac-option-modifier 'meta)
(setq projectile-project-search-path '("~/Dev/"))
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
(defvar doom-user-map (make-sparse-keymap)
  "Key map for user shortcuts.")

(map! :leader
      :desc "user"
      ","
      doom-user-map)

(add-hook! 'org-mode-hook #'+org-init-keybinds-h)
(setq evil-snipe-override-evil-repeat-keys nil)
(setq doom-localleader-key ",")
(setq doom-localleader-alt-key "M-,")
(setq python-shell-interpreter "python3")

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
  (map! :leader
        :desc "String inflection"
        ", s"
        #'my-string-inflection-cycle-auto))

(use-package! web-mode
  :init
  (setq web-mode-markup-indent-offset 2
        web-mode-attr-indent-offset 2
        web-mode-attr-value-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2
        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
        web-mode-enable-auto-indentation nil))

;; keybind to disable search highlighting (like :set noh)
(map! :leader
      :desc "Clear search highlight"
      "s c"
      #'evil-ex-nohighlight)

(map! :leader
      :desc "Repeat"
      "."
      #'repeat)

(map! :leader
      :desc "List processes"
      ", l"
      #'list-processes)

(map! :localleader
      :map (clojure-mode-map
            lisp-mode-map
            emacs-lisp-mode-map)
      "s f" #'paredit-forward-slurp-sexp
      "s b" #'paredit-backward-slurp-sexp
      "b f" #'paredit-forward-barf-sexp
      "b b" #'paredit-backward-barf-sexp)

(use-package! evil
  :config
  (setq evil-move-beyond-eol t
        evil-insert-state-cursor '(box "#98BE65")
        evil-visual-state-cursor '(box "orange")
        evil-emacs-state-cursor  '(box "purple")))

;; Lots of useful helm tips here: https://tuhdo.github.io/helm-intro.html
(use-package! helm
  :init
  (setq helm-split-window-inside-p  t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match    t
        helm-semantic-fuzzy-match   t
        helm-imenu-fuzzy-match      t)
  :config
  (map! :leader
        :desc "View kill ring"
        ", k"
        #'helm-show-kill-ring))

(use-package! swiper-helm
  :init
  (setq helm-split-window-inside-p t)
  :config
  (map! :leader
        :desc "Helm swiper"
        "s s"
        #'swiper-helm))

(setq lsp-eldoc-enable-hover nil)
(setq counsel-projectile-switch-project-action 'counsel-projectile-switch-project-action-dired)

(when (and (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (progn
    (setq native-comp-async-report-warnings-errors nil)
    (setq comp-deferred-compilation t)
    (add-to-list 'native-comp-eln-load-path (expand-file-name "eln-cache/" user-emacs-directory))
    (setq package-native-compile t)))
