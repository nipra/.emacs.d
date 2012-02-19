(setq additional-paths-rb '("/home/nipra/.emacs.d"
                            "/home/nipra/.emacs.d/rb/rinari"
                            "/home/nipra/.emacs.d/rb/rhtml"
                            "/home/nipra/.emacs.d/rb/emacs-rails-reloaded"))

(setq load-path (append additional-paths-rb load-path))

(require 'rinari)
(setq ruby-insert-encoding-magic-comment nil)
(setq rinari-tags-file-name "TAGS")

(require 'rhtml-mode)
(autoload 'rhtml-mode "rhtml-mode" "RHTML" t)
(add-to-list 'auto-mode-alist '("\\.rhtml$" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.html\.erb$" . rhtml-mode))

(require 'rails-autoload)

(defun rb-dbg (pos)
  (interactive "d")
  (let ((trace-command "require 'ruby-debug'; debugger"))
    (save-excursion
      (save-restriction
        (widen)
        (goto-char (point-min))
        (search-forward trace-command nil t)
        (beginning-of-line)
        (kill-line 1)))
    (beginning-of-line)
    (insert (concat trace-command "\n"))
    (forward-line -1)
    (indent-for-tab-command)))

(define-key ruby-mode-map (kbd "C-x g") 'rb-dbg)

(provide 'config-rb)
