;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Denys Zadorozhnyi"
      user-mail-address "denys@zadorozhnyi.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;;
(setq doom-font (font-spec :family "Iosevka Fixed" :size 20 :weight 'semibold)
      ;; doom-variable-pitch-font (font-spec :family "sans" :size 13)
      )
(when (string= (system-name) "Denyss-MBP.lan")
  (setq doom-font (font-spec :family "Iosevka Fixed" :size 14 :weight 'semibold)
        )
  )

;; There are two ways to load a theme. Both assume the theme is instlled and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-gruvbox-light)
;; (setq doom-theme 'doom-solarized-light)
(load-theme 'solarized-light t)
;; (load-theme 'solarized-gruvbox-light t)

(setq doom-gruvbox-light-variant 'hard)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; 'line is the default
(setq evil-snipe-scope 'line)

;; The benefit of this is:
;; Incremental highlighting
;; You can repeat searches with f, F, t and T (ala Clever-F)
;; ; and , are available for repeating searches (and won't interfere with the original maps; they take effect only after a successful snipe)
;; A more streamlined experience in general
(setq evil-snipe-override-mode 1)

;; This will allow you to quickly hop into avy/evil-easymotion right after a snipe.
;; (define-key evil-snipe-parent-transient-map (kbd "C-;")
;;   (evilem-create 'evil-snipe-repeat
;;                  :bind ((evil-snipe-scope 'buffer)
;;                         (evil-snipe-enable-highlight)
;;                         (evil-snipe-enable-incremental-highlight))))

;; Rust
(setq rustic-lsp-server 'rust-analyzer)
;; build tests
(setq lsp-rust-cfg-test t)
;; cargo clippy instead of check
(setq lsp-rust-analyzer-cargo-watch-command "clippy")
(setq lsp-rust-analyzer-cargo-all-targets t)
(setq lsp-rust-all-targets t)
;; set lib path
;; (setq lsp-rust-analyzer-exclude-globs )
;; (setq lsp-rust-library-directories)

;; auto-refresh all buffers when files have changed on disk
(setq global-auto-revert-mode t)

;; right alt as meta
(setq mac-option-key-is-meta t)
(setq ns-right-option-modifier 'meta)

;; don't format on save
(setq +format-on-save-enabled-modes
      '(not c-mode
            cpp-mode
            c++-mode
            emacs-lisp-mode  ; elisp's mechanisms are good enough
            sql-mode         ; sqlformat is currently broken
            tex-mode         ; latexindent is broken
            latex-mode))

;; Avy
(global-set-key (kbd "s-f") 'avy-goto-char-timer)

(global-set-key (kbd "M--") 'negative-argument) ; revert to default from Doom

;; For Rust
(add-hook! 'rustic-mode-hook (modify-syntax-entry ?_ "w"))
(add-hook! 'rust-mode-hook (modify-syntax-entry ?_ "w"))

;; (global-unset-key (kbd "C-="))
(global-set-key (kbd "C-=") 'lsp-extend-selection)

;; ;; Smartparens
;; ;; (global-unset-key (kbd "C-M-k"))
;; define-key smartparens-mode-map (kbd "C-M-t") 'nil)
;; (define-key smartparens-mode-map (kbd "C-M-k") 'sp-kill-hybrid-sexp)

;; TODO: does not work. Too soon? Run after some event?
(after! smartparens
  (define-key smartparens-mode-map (kbd "C-M-a") 'nil)
  (define-key smartparens-mode-map (kbd "C-M-e") 'nil)
  (define-key smartparens-mode-map (kbd "C-M-f") 'nil)
  (define-key smartparens-mode-map (kbd "C-M-b") 'nil)
  (define-key smartparens-mode-map (kbd "C-M-d") 'nil)
  (define-key smartparens-mode-map (kbd "C-M-k") 'nil)
  (define-key smartparens-mode-map (kbd "C-M-t") 'nil))


;; point(cursor) as line
(setq-default cursor-type 'rectangle)

(global-set-key (kbd "s-m") 'lsp-execute-code-action)
(global-set-key (kbd "s-n") 'flycheck-next-error)
(global-set-key (kbd "s-p") 'flycheck-previous-error)

;; (map! "C-c c g" #'lsp-ui-flycheck-list)
(map! "C-c c g" #'lsp-treemacs-errors-list)

;; cut/copy the current line if no region is active
(whole-line-or-region-global-mode)

(after! ace-window (setq aw-scope 'visible))

;; URL to remote repo copied to clipboard
(global-set-key (kbd "C-c v i") 'git-link)

;; rust-analyzer crashes on start if enabled
(setq lsp-enable-semantic-highlighting nil)

(after! lsp-treemacs
  (setq lsp-treemacs-sync-mode 1)
  (global-set-key (kbd "C-c c l c") 'lsp-treemacs-call-hierarchy))

(global-set-key (kbd "M-z") 'zap-up-to-char)
