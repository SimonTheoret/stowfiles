;; -*- lexical-binding: t -*- 


(general-def
  :states 'normal
  :prefix "<leader> b"
  :prefix-command 'Buffers
  "i" '("Ibuffer" . ibuffer)
  "l" '("Buffer list" . consult-buffer))
(use-package casual-ibuffer
  :general
  (general-def
    :states 'normal
    :keymaps 'ibuffer-mode-map
    "C-o" '("Transient ibuffer" . casual-ibuffer-tmenu)))

(use-package popwin
  :config
  (popwin-mode 1))

