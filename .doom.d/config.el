;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq company-idle-delay 0.2
	  company-minimum-prefix-length 3)
(load-theme 'doom-tomorrow-night t)
(after! elixir-mode
  (set-lookup-handlers! 'elixir-mode
    :definition #'alchemist-goto-definition-at-point
    :documentation #'alchemist-help-search-at-point
    )
  (map! :map elixir-mode-map
        :localleader
        (:prefix ("t" . "test")
          :n "t" #'alchemist-mix-test-at-point
          :n "b" #'alchemist-mix-test-this-buffer
          :n "r" #'alchemist-mix-rerun-last-test
          )
        :desc "goto" :n "g" #'alchemist-goto-definition-at-point
        :desc "help" :n "h" #'alchemist-help-search-at-point
        )
  )
