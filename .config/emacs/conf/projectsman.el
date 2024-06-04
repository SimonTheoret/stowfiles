;; -*- lexical-binding: t -*-

;; Projects manager

;; projectile
(use-package
  projectile
  :config
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/Documents"))
  (add-to-list 'projectile-globally-ignored-directories "nix")
  (add-to-list 'projectile-globally-ignored-directories ".cargo")
  :general-config
  (general-def
    :states
    'normal
    :prefix "<leader> p"
    :prefix-command 'Projectile
    "m" '("Projectile command map" . projectile-command-map)
    "p" '("Project Switch project" . projectile-switch-project)
    "a" '("Project Add project" . projectile-add-known-project)
    "d" '("Project Remove project" . projectile-remove-known-project)
    ;; "t" '("Search todo in project" . consult-todo-project)
    )
  (general-def
    :states
    'normal
    "<leader> SPC" '("Find file in project" . project-find-file)
    )
  )
