(setq additional-paths-clj
      (list (concat nipra-home "/.emacs.d/clojure-mode")
            (concat nipra-home "/.emacs.d/nrepl.el")))

(setq load-path (append additional-paths-clj load-path))

(require 'paredit)
(require 'clojure-mode)
(require 'clojure-test-mode)
(require 'nrepl)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)

(provide 'config-clj-new)
