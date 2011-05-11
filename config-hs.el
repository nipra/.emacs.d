(load "/home/nipra/.emacs.d/hs/haskellmode-emacs/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(setq haskell-program-name "/usr/local/haskell-platform-2011.2.0.1/bin/ghci")
(require 'inf-haskell)

(provide 'config-hs)
