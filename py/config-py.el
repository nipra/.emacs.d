;;; Electric Pairs
(add-hook 'python-mode-hook
	  (lambda ()
	    (define-key python-mode-map "\"" 'electric-pair)
	    (define-key python-mode-map "\'" 'electric-pair)
	    (define-key python-mode-map "(" 'electric-pair)
	    (define-key python-mode-map "[" 'electric-pair)
	    (define-key python-mode-map "{" 'electric-pair)))

(setq python-python-command "ipython")

(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

(require 'virtualenv)

;; (add-hook 'python-mode-hook
;;           '(lambda ()
;;              (require 'virtualenv)))

(setq virtualenv-use-ipython t)
(setq virtualenv-root-dir "/home/nipra/InfinitelyBeta/")

(provide 'config-py)
