;; -*- lexical-binding: t -*-


;; Makes dired goooood

(setq dired-listing-switches "-alh")

(use-package diff-hl :config (global-diff-hl-mode))

(use-package diredfl :config (diredfl-global-mode))

(use-package
  dired-rsync
  :bind (:map dired-mode-map ("<leader> r r" . dired-rsync)))

(use-package
  dired-rsync-transient
  :bind
  (:map dired-mode-map ("<leader> r t" . dired-rsync-transient)))

(use-package casual-dired)

(defun search-emacs-dir ()
  (interactive)
  (ido-find-file-in-dir user-emacs-directory))


(general-def
  :states
  'normal
  :prefix "<leader> f"
  :prefix-command 'Files
  "f"
  '("Find files" . ido-find-file)
  "p"
  '("Search conf" . search-emacs-dir)
  "d"
  '("Create dir" . make-directory)
  "D"
  '("Delete directory" . delete-directory)
  "c"
  '("Copy current file" . crux-copy-file-preserve-attributes)
  "e"
  '("sudoedit current file" . crux-sudo-edit)
  "n"
  '("Create empty file" . dired-create-empty-file)
  "b"
  '("Fuzzy search files" . consult-fd)
  "g"
  '("Change current dir" . cd)
  "o"
  '("Dired here" . dired-jump)
  )

(general-def
  :states
  'normal
  :keymaps 'dired-mode-map
  "C-o"
  '("Casual dired" .  casual-dired-tmenu)
  )


(general-def
  :states
  'normal
  :prefix "<leader> f m"
  :prefix-command 'Modify
  "n"
  '("Rename current file" . crux-rename-file-and-buffer)
  "d"
  '("Remove file" . delete-file)
 )
