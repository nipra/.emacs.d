;; (setq ansi-color-for-comint-mode t)

(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

(setq py-python-command "ipython")
(setq py-python-command-args '("-colors" "NoColor"))

;; (require 'ipython)

;;; http://jesselegg.com/archives/2010/03/14/emacs-python-programmers-2-virtualenv-ipython-daemon-mode/
;;; http://github.com/jdodds/virtualenv.el/raw/master/virtualenv.el
(require 'virtualenv)
(setq virtualenv-root "~/InfinitelyBeta/")

(provide 'config-py)
