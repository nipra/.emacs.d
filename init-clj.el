(setq additional-paths '("/home/nipra/.emacs.d"))

(setq load-path (append additional-paths load-path))

(require 'init-common)

(require 'config-clj)

