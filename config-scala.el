(setq additional-paths-scala '("/home/nipra/.emacs.d"
                               "/home/nipra/.emacs.d/scala"
                               "/home/nipra/.emacs.d/scala/scala-mode-new"))

(setq load-path (append additional-paths-scala load-path))

(require 'scala-mode-auto)

(provide 'config-scala)
