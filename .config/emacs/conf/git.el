;; -*- lexical-binding: t -*-


;; git magic!

;; magit
(use-package
  magit
  :after evil-collection
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  (setq magit-todos-exclude-globs '("*.ipynb"))
  :general-config
  (general-def
    :states 'normal
    :prefix "<leader> g"
    :prefix-command 'Git
    "/" '("Magit" . magit)
    "l" '("Magit status" . magit-log)
    "t" '("Git TimeMachine" . git-timemachine)
    ))

(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh) ;;compatibility with diff-hl
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh) ;;compatibility with diff-hl

(use-package magit-todos :after magit :config (magit-todos-mode 1))

(use-package git-modes)

(use-package git-timemachine)

(general-def
  :states 'normal
  :prefix "<leader> g s"
  :prefix-command 'Smerge
  "s" '("Smerge" . smerge-mode)
  "n" '("Smerge next" . smerge-next)
  "p" '("Smerge previous" . smerge-prev)
  "k" '("Smerge keep current" . magit-smerge-keep-current)
  "u" '("Smerge keep current" . magit-smerge-keep-lower)
  "l" '("Smerge keep current" . magit-smerge-keep-upper)
  "a" '("Smerge keep current" . magit-smerge-keep-all)
  )
