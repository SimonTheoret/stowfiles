;; -*- lexical-binding: t -*-

;;loading function
(defun config-load-file-no-extension (content)
  "Loads and runs the file contained in the directory user-emacs-directory/conf"
  (let ((path (concat user-emacs-directory "conf/" content ".el")))
    (load(locate-user-emacs-file path))))
()

;; Immediate loading
(add-to-list 'load-path (concat user-emacs-directory "conf/"))
;;--------- Does not require packages.el -----------;;
(config-load-file-no-extension "generic")

(load (locate-user-emacs-file "packages.el"))

;;--------- Does require packages.el -----------;;
(config-load-file-no-extension "keybindings")
(config-load-file-no-extension "looks")
(config-load-file-no-extension "completion")
(config-load-file-no-extension "diredup")
(config-load-file-no-extension "search")
(config-load-file-no-extension "org")
(config-load-file-no-extension "lsp")
(config-load-file-no-extension "dap")
(config-load-file-no-extension "treesitter")
(config-load-file-no-extension "emacslisp")
(config-load-file-no-extension "views")
(config-load-file-no-extension "projectsman")
(config-load-file-no-extension "git")
(config-load-file-no-extension "buffers")
(config-load-file-no-extension "help")
(config-load-file-no-extension "pdf")
(config-load-file-no-extension "hooks")
(config-load-file-no-extension "prog")
(config-load-file-no-extension "undo")
(config-load-file-no-extension "pythonlang")
(config-load-file-no-extension "terminal")
(config-load-file-no-extension "check")
(config-load-file-no-extension "latexlang")
(config-load-file-no-extension "shellenv")
(config-load-file-no-extension "format")
(config-load-file-no-extension "utils")
(config-load-file-no-extension "compi")
(config-load-file-no-extension "spelling")
(config-load-file-no-extension "envir")
(config-load-file-no-extension "projdeploy")
(config-load-file-no-extension "dock")
(config-load-file-no-extension "typeoffiles")
;; (config-load-file-no-extension "email")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((comment-fill-column . 80)
     (deadgrep-extra-arguments quote
			       ("--no-config --L --hidden"))
     (eval setq consult-ripgrep-args
	   (concat consult-ripgrep-args " -L --hidden ")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
