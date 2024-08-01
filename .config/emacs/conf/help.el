;; -*- lexical-binding: t -*-


(use-package helpful
  :general
  ("C-h f"   '("callable help" . helpful-callable)
   "C-h v"   '("variable help" . helpful-variable)
   "C-h k"   '("key help" . helpful-key)
   "C-h x"   '("command help" . helpful-command)
   "C-c C-d" '("help at point" . helpful-at-point)
   "C-h F"   '("help function" . helpful-function)
   )
  )


(use-package casual-calc
  :general
  (general-def
    :states 'normal
    "<leader> a c" '("Calc" . calc)
    )
  )
(general-def
  :states 'normal
  :keymaps 'calc-mode-map
  "C-o" '("Calc transient" . casual-calc-tmenu)
  )
