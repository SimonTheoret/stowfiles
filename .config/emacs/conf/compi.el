;; -*- lexical-binding: t -*- 

(defun change-compile-command (str)
  (set (make-local-variable 'compile-command) str))

(add-hook 'python-ts-mode-hook (apply-partially #'change-compile-command "python3 -m "))
(add-hook 'rustic-mode-hook (apply-partially #'change-compile-command "cargo "))
(add-hook 'rust-ts-mode-hook (apply-partially #'change-compile-command "cargo "))
(add-hook 'rust-mode-hook (apply-partially #'change-compile-command "cargo "))
(add-hook 'go-ts-mode (apply-partially #'change-compile-command "go "))
(add-hook 'sh-mode (apply-partially #'change-compile-command "bash "))

(use-package fancy-compilation
  :commands (fancy-compilation-mode))

(with-eval-after-load 'compile
  (fancy-compilation-mode))

(general-def
  :states
  'normal
  :prefix "<leader> c c"
  :prefix-command 'Compile
  "c"
  '("compile" . compile)
  "r"
  '("recompile" . recompile)
  )

