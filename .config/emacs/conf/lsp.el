;; -*- lexical-binding: t -*-

(defun dotfiles--lsp-deferred-if-supported ()
  "Run `lsp-deferred' if it's a supported mode."
  (unless (derived-mode-p 'emacs-lisp-mode)
    (lsp-deferred)))

(use-package
  lsp-mode
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  :hook
  ( ;; replace XXX-mode with concrete major-mode(e. g. python--tsmode)
   ;; (python-ts-mode . lsp-deferred) ;;already taken care of
   (go-ts-mode . lsp-deferred)
   (rust-ts-mode . lsp-deferred) ;;already taken care of
   ;;(rustic-mode . lsp-deferred) ;;already taken care of
   ;; if you want which-key integration
   (lsp-mode . lsp-enable-which-key-integration)
   (LaTeX-mode . lsp-deferred)
   (nix-mode . lsp-deferred)
   (kill-emacs . lsp-workspace-remove-all-folders)
   )
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-lens-enable nil)
  (lsp-signature-mode t)
  (setq lsp-eldoc-enable-hover t)
  (setq lsp-signature-auto-activate t)
  (setq lsp-signature-render-documentation nil)
  (setq lsp-ui-doc-use-childframe nil)
  ;; (setq lsp-ui-doc-show-with-cursor t)
  ;; (setq lsp-ui-doc-position 'at-point)
  ;; (setq lsp-headerline-breadcrumb-segments '(symbols))
  ;; (setq lsp-ui-doc-include-signature t)
  ;; (setq lsp-ui-doc-max-height 8)
  ;; :global/:workspace/:file
  (setq lsp-modeline-diagnostics-scope :workspace)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-idle-delay 0.250)
  )

;; Make the help buffer smaller
(add-to-list 'display-buffer-alist
             '((lambda (buffer _) (with-current-buffer buffer
			       (seq-some (lambda (mode)
                                           (derived-mode-p mode))
                                         '(help-mode))))
	       (display-buffer-reuse-window display-buffer-below-selected)
	       (reusable-frames . visible)
	       (window-height . 0.33)))

(general-def
  :states
  'normal
  :prefix "<leader> c"
  :prefix-command 'Code
  "d"
  '("Find definition" . lsp-ui-peek-find-definitions)
  "a"
  '("Execute action" . lsp-execute-code-action)
  "i"
  '("Find implementation" . lsp-find-implementation)
  "t"
  '("Find type def" . lsp-find-type-definition)
  "D"
  '("Find declaration" . lsp-find-declaration)
  "b"
  '("Open doc in buffer" . lsp-describe-thing-at-point)
  "r"
  '("Find reference" . lsp-ui-peek-find-references)
  "n"
  '("Rename" . lsp-rename)
  "f"
  '("Format buffer" . format-all-buffer)
  "h"
  '("Toggle inlay" . (lambda () (interactive)(progn (setq lsp-inlay-hint-enable t)(lsp-inlay-hints-mode))))
  "k"
  '("Describe" . lsp-ui-doc-glance)
  )

;; This function filters any diagnostics coming from the virtual env of python

(setf lsp-diagnostic-filter (lambda (param work) ;; params is the hash map containing the diagnostics for a single buffer
			      ;; (message "%s" param)
			      (if (string-match (regexp-quote ".venv/") (plist-get param :uri) )
				  (plist-put param :diagnostics [])
				param
				)
			      ))


;; source:
;; (setf lsp-diagnostic-filter (lambda (param work)
;; 			      (puthash "diagnostics"
;; 				       (cl-remove-if (lambda (diag) (gethash "tags" diag))
;; 						     (gethash "diagnostics" param))
;; 				       param)
;; 			      param))


;; (defun smart-lsp-ui-doc ()
;;   (interactive)
;;   (if lsp-ui-doc-frame-mode
;;       ((lsp-ui-doc-show)
;;        (lsp-ui-doc-focus-frame)
;;        (lsp-ui-doc-enable nil))
;;     ((lsp-ui-doc-hide)
;;      (setq lsp-ui-doc-enable t))
;;     )
;;   )

(general-def
  :states
  'normal
  :prefix "<leader> c w"
  :prefix-command 'Workspace
  "d"
  '("LSP Workspace delete" . lsp-workspace-folders-remove)
  "a"
  '("LSP Workspace add" . lsp-workspace-folders-add)
  "r"
  '("LSP restart workspace" . lsp-workspace-restart)
  )

(use-package all-the-icons)

;; optionally
;; By default, lsp-mode automatically activates lsp-ui unless lsp-auto-configure is set to nil.
(use-package lsp-ui :commands lsp-ui-mode)

;;LSP optimizations

(defun lsp-optim ()
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 4 (* 1024 1024))) ;; 1mb
  (setq lsp-use-plists t))

(lsp-optim)

;; Python
(use-package
  lsp-pyright
  :after lsp-mode
  :init
  (setq lsp-pyright-diagnostic-mode "workspace")
  :hook
  (python-ts-mode
   .
   (lambda ()
     (require 'lsp-pyright)
     (lsp-deferred)))) ; or lsp-deferred

(with-eval-after-load 'lsp-mode
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection "pyright")
                    :major-modes '(python-mode)
                    :remote? t
                    :server-id 'pyright-remote)))

;; Rust
(use-package rust-mode
  ;;   :mode "\\.rs\\'"
  ;; :hook
  ;; (rust-mode . rustic-mode)
  ;; (rustic-mode . lsp)
  :init
  (setq-default lsp-rust-analyzer-cargo-watch-command "clippy")
  (setq-default lsp-rust-all-features t)
  (setq rust-mode-treesitter-derive t)
  ;; (add-to-list 'org-src-lang-modes '("rust" . rustic) )
  )


;; Latex
(use-package
  lsp-latex
  :init (setq lsp-latex-forward-search-executable "zathura")
  (setq lsp-latex-forward-search-args
	'("--synctex-forward" "%l:1:%f" "%p"))
  :hook (tex-mode . lsp-deferred) (latex-mode . lsp-deferred) (LaTeX-mode . lsp-deferred))

;; Go
(use-package
  go-mode
  :config (setq-default lsp-go-use-gofumpt t)
  :hook (go-mode . flycheck-golangci-lint-setup)
  (go-mode . go-guru-hl-identifier-mode))

(use-package go-eldoc :hook (go-mode . go-eldoc-setup))

(use-package flycheck-golangci-lint)

(eval-after-load
    'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))

(use-package
  lsp-latex
  :init (setq lsp-latex-forward-search-executable "zathura")
  (setq lsp-latex-forward-search-args
	'("--synctex-forward" "%l:1:%f" "%p")))

;; Nix
(use-package nix-mode :mode "\\.nix\\'")
