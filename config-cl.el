(setq additional-paths-cl '("/home/nipra/.emacs.d"
			    "/home/nipra/.emacs.d/cl/slime"
			    "/home/nipra/.emacs.d/cl/slime/contrib"
			    "/home/nipra/.emacs.d/cl/cl-lookup"))

(setq load-path (append additional-paths-cl load-path))

;;
(require 'cl-lookup)

;; PAREDIT-MODE
(require 'paredit)
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

;; -----
;; SLIME
;; -----

;; slime-autodoc-mode is an additional minor-mode for automatically
;; showing documentation (argument lists) for code near the point.
(require 'slime-autoloads)
(add-hook 'slime-mode-hook (lambda () (slime-autodoc-mode t)))

(setq inferior-lisp-program
      "/usr/local/bin/sbcl"
      slime-startup-animation t
      lisp-indent-function 'common-lisp-indent-function)

;; (require 'slime)
(slime-setup '(slime-repl
               slime-fancy
               slime-asdf
               ;; slime-indentation
               ))
;; (slime-setup)

(defmacro defslime-start (name lisp)
  `(defun ,name ()
     (interactive)
     (let ((inferior-lisp-program ,lisp))
       (slime))))

(setq common-lisp-hyperspec-root
      ;; "http://www.lispworks.com/reference/HyperSpec/"
      "file:///home/nipra/Documents/Lisp/HyperSpec/")

;; (setq common-lisp-hyperspec-symbol-table
;;       "/home/nipra/Documents/Lisp/HyperSpec/Data/Map_Sym.txt")

(defslime-start cmucl "/usr/bin/cmucl")
(defslime-start sbcl-local "/usr/local/bin/sbcl")
(defslime-start sbcl "/usr/bin/sbcl")
(defslime-start alisp "/home/nipra/opt/acl80/alisp")
(defslime-start mlisp "/home/nipra/opt/acl80/mlisp")
(defslime-start mlisp8 "/home/nipra/opt/acl80/mlisp8")
(defslime-start alisp8 "/home/nipra/opt/acl80/alisp8")
(defslime-start clisp "/usr/bin/clisp")
(defslime-start gcl "/usr/bin/gcl")
(defslime-start ccl "/home/nipra/Softwares/ccl/scripts/ccl")

(add-hook 'slime-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'slime-connected-hook (lambda () (paredit-mode +1)))
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
;; (setq slime-complete-symbol 'slime-fuzzy-complete-symbol)
;; (setq slime-simple-complete-symbol 'slime-fuzzy-complete-symbol)

;;; Customizations for Slime Lisp

;; Either use `slime-indentation' or below snippet
;; (setq lisp-simple-loop-indentation 1
;;       lisp-loop-keyword-indentation 6
;;       lisp-loop-forms-indentation 6)

;; http://bc.tech.coop/blog/070424.html
(defun slime-send-dwim (arg)
  "Send the appropriate forms to CL to be evaluated."
  (interactive "P")
  (save-excursion
    (cond 
      ;;Region selected - evaluate region
      ((not (equal mark-active nil))
       (copy-region-as-kill (mark) (point)))
      ;; At/before sexp - evaluate next sexp
      ((or (looking-at "\s(")
           (save-excursion
             (ignore-errors (forward-char 1))
             (looking-at "\s(")))
       (forward-list 1)
       (let ((end (point))
             (beg (save-excursion
                    (backward-list 1)
                    (point))))
         (copy-region-as-kill beg end)))
      ;; At/after sexp - evaluate last sexp
      ((or (looking-at "\s)")
           (save-excursion
             (backward-char 1)
             (looking-at "\s)")))
       (if (looking-at "\s)")
           (forward-char 1))
       (let ((end (point))
             (beg (save-excursion
                    (backward-list 1)
                    (point))))
         (copy-region-as-kill beg end)))
      ;; Default - evaluate enclosing top-level sexp
      (t (progn
           (while (ignore-errors (progn
                                   (backward-up-list)
                                   t)))
           (forward-list 1)
           (let ((end (point))
                 (beg (save-excursion
                        (backward-list 1)
                        (point))))
             (copy-region-as-kill beg end)))))
    (set-buffer (slime-output-buffer))
    (unless (eq (current-buffer) (window-buffer))
      (pop-to-buffer (current-buffer) t))
    (goto-char (point-max))
    (yank)
    (if arg (progn
              (slime-repl-return)
              (other-window 1)))))

;; http://bc.tech.coop/blog/070425.html
(defun slime-new-repl (&optional new-port)
  "Create additional REPL for the current Lisp connection."
  (interactive)
  (if (slime-current-connection)
      (let ((port (or new-port (slime-connection-port (slime-connection)))))
        (slime-eval `(swank::create-server :port ,port))
        (slime-connect slime-lisp-host port))
      (error "Not connected")))

(defun my-slime-send-dwim ()
  (interactive)
  (slime-send-dwim 0)
  (slime-reindent-defun)
  (slime-repl-return)
  (other-window 1))

(eval-after-load 'slime
  '(progn
    (define-key slime-mode-map (kbd "C-c M-a") 'slime-arglist)
    (define-key slime-mode-map (kbd "C-c w") 'paredit-wrap-sexp)
    (define-key slime-mode-map (kbd "C-t")     'transpose-sexps)
    (define-key slime-mode-map (kbd "C-M-t")   'transpose-chars)
    (define-key slime-mode-map (kbd "C-M-b")   'backward-char)
    (define-key slime-mode-map (kbd "C-M-f")   'forward-char)
					; (define-key slime-mode-map (kbd "<f7>")    'vertical-split-slime-repl)
    (define-key slime-mode-map (kbd "C-c h")   'slime-hyperspec-lookup)
    (define-key slime-mode-map (kbd "C-c C-f") 'slime-complete-form)
    (define-key slime-mode-map (kbd "C-c C-s") 'paredit-split-sexp)
    (define-key slime-mode-map (kbd "<f5>")    'slime-selector)
    (define-key slime-mode-map (kbd "C-c ;")   'slime-insert-balanced-comments) ;
    (define-key slime-mode-map (kbd "C-c M-;") 'slime-remove-balanced-comments)
    (define-key slime-mode-map (kbd "<C-tab>") 'slime-fuzzy-complete-symbol)
    (define-key slime-mode-map (kbd "C-M-m") 'mark-sexp)
    (define-key slime-mode-map (kbd "C-c :") 'slime-eval-buffer)
    (define-key slime-mode-map (kbd "C-c r") 'slime-send-dwim)
    (define-key slime-mode-map (kbd "C-c s") 'my-slime-send-dwim)
    (define-key slime-mode-map (kbd "C-x C-k 0") 'redshank-indent-slots)))

;; (define-key slime-inspector-mode-map (kbd "C-c c") 'slime-inspector-copy-down)

;; (define-key sldb-mode-map (kbd "<f5>")     'slime-selector)

;; (define-key slime-repl-mode-map (kbd "<f5>")    'slime-selector)
;; (define-key slime-repl-mode-map (kbd "C-c M-a") 'slime-arglist)
;; (define-key slime-repl-mode-map (kbd "C-c w") 'paredit-wrap-sexp)
;; (define-key slime-repl-mode-map (kbd "C-M-b")   'backward-char)
;; (define-key slime-repl-mode-map (kbd "C-M-f")   'forward-char)
;; (define-key slime-repl-mode-map (kbd "C-c C-f") 'slime-complete-form)
;; (define-key slime-repl-mode-map (kbd "C-c C-s") 'paredit-split-sexp)
;; (define-key slime-repl-mode-map (kbd "C-c h")   'slime-hyperspec-lookup)
;; (define-key slime-repl-mode-map (kbd "<C-tab>") 'slime-fuzzy-complete-symbol)
;; (define-key slime-repl-mode-map (kbd "C-M-m") 'mark-sexp)
;; (define-key slime-repl-mode-map (kbd "C-c C-d h") 'cl-lookup)
;; (define-key slime-repl-mode-map (kbd "C-c C-x c") 'slime-list-connections)


;; ;; Paredit mode
;; (define-key paredit-mode-map (kbd "(")       'paredit-open-parenthesis)
;; (define-key paredit-mode-map (kbd ")")       'paredit-close-parenthesis)
;; (define-key paredit-mode-map (kbd "M-(")     (lambda () (interactive) (insert "(")))
;; (define-key paredit-mode-map (kbd "M-)")     (lambda () (interactive) (insert ")")))
;; (define-key paredit-mode-map (kbd "M-j")     'paredit-newline)
;; (define-key paredit-mode-map (kbd "RET")     nil)
;; (define-key paredit-mode-map (kbd "C-t")     'transpose-sexps)
;; (define-key paredit-mode-map (kbd "C-M-t")   'transpose-chars)
;; (define-key paredit-mode-map (kbd "C-b")     'backward-sexp)
;; (define-key paredit-mode-map (kbd "C-M-b")   'backward-char)
;; (define-key paredit-mode-map (kbd "C-f")     'forward-sexp)
;; (define-key paredit-mode-map (kbd "C-M-f")   'forward-char)
;; (define-key paredit-mode-map (kbd "C-c b")   'backward-kill-sexp)
;; (define-key paredit-mode-map (kbd "C-c C-j") 'paredit-join-sexps)
;; (define-key paredit-mode-map (kbd "C-i") 'slime-indent-and-complete-symbol)
;; (define-key paredit-mode-map (kbd "C-c C-1") 'paredit-backward-barf-sexp)
;; (define-key paredit-mode-map (kbd "C-c C-2") 'paredit-forward-barf-sexp)
;; (define-key paredit-mode-map (kbd "C-c C-3") 'paredit-backward-slurp-sexp)
;; (define-key paredit-mode-map (kbd "C-c C-4") 'paredit-forward-slurp-sexp)
;; (define-key paredit-mode-map (kbd "C-c x") 'paredit-backward-slurp-sexp)
;; (define-key paredit-mode-map (kbd "C-c z") 'paredit-forward-slurp-sexp)
;; (define-key paredit-mode-map (kbd "C-c c") 'paredit-splice-sexp-killing-backward)
;; (define-key paredit-mode-map (kbd "C-c v") 'paredit-splice-sexp-killing-forward)

(eval-after-load 'slime-inspector
  '(progn (define-key slime-inspector-mode-map (kbd "C-c c") 'slime-inspector-copy-down)))

(eval-after-load 'sldb
  '(define-key sldb-mode-map (kbd "<f5>")     'slime-selector)) 

(eval-after-load 'slime-repl
  '(progn (define-key slime-repl-mode-map (kbd "<f5>")    'slime-selector)
          (define-key slime-repl-mode-map (kbd "C-c M-a") 'slime-arglist)
          (define-key slime-repl-mode-map (kbd "C-c w") 'paredit-wrap-sexp)
          (define-key slime-repl-mode-map (kbd "C-M-b")   'backward-char)
          (define-key slime-repl-mode-map (kbd "C-M-f")   'forward-char)
          (define-key slime-repl-mode-map (kbd "C-c C-f") 'slime-complete-form)
          (define-key slime-repl-mode-map (kbd "C-c C-s") 'paredit-split-sexp)
          (define-key slime-repl-mode-map (kbd "C-c h")   'slime-hyperspec-lookup)
          (define-key slime-repl-mode-map (kbd "<C-tab>") 'slime-fuzzy-complete-symbol)
          (define-key slime-repl-mode-map (kbd "C-M-m") 'mark-sexp)
          (define-key slime-repl-mode-map (kbd "C-c C-d h") 'cl-lookup)
          (define-key slime-repl-mode-map (kbd "C-c C-x c") 'slime-list-connections)))




;; Paredit mode
(eval-after-load 'paredit
  '(progn (define-key paredit-mode-map (kbd "(")       'paredit-open-parenthesis)
          (define-key paredit-mode-map (kbd ")")       'paredit-close-parenthesis)
          (define-key paredit-mode-map (kbd "M-(")     (lambda () (interactive) (insert "(")))
          (define-key paredit-mode-map (kbd "M-)")     (lambda () (interactive) (insert ")")))
          (define-key paredit-mode-map (kbd "M-j")     'paredit-newline)
          (define-key paredit-mode-map (kbd "RET")     nil)
          (define-key paredit-mode-map (kbd "C-t")     'transpose-sexps)
          (define-key paredit-mode-map (kbd "C-M-t")   'transpose-chars)
          (define-key paredit-mode-map (kbd "C-b")     'backward-sexp)
          (define-key paredit-mode-map (kbd "C-M-b")   'backward-char)
          (define-key paredit-mode-map (kbd "C-f")     'forward-sexp)
          (define-key paredit-mode-map (kbd "C-M-f")   'forward-char)
          (define-key paredit-mode-map (kbd "C-c b")   'backward-kill-sexp)
          (define-key paredit-mode-map (kbd "C-c C-j") 'paredit-join-sexps)
          (define-key paredit-mode-map (kbd "C-i") 'slime-indent-and-complete-symbol)
          (define-key paredit-mode-map (kbd "C-c C-1") 'paredit-backward-barf-sexp)
          (define-key paredit-mode-map (kbd "C-c C-2") 'paredit-forward-barf-sexp)
          (define-key paredit-mode-map (kbd "C-c C-3") 'paredit-backward-slurp-sexp)
          (define-key paredit-mode-map (kbd "C-c C-4") 'paredit-forward-slurp-sexp)
          (define-key paredit-mode-map (kbd "C-c x") 'paredit-backward-slurp-sexp)
          (define-key paredit-mode-map (kbd "C-c z") 'paredit-forward-slurp-sexp)
          (define-key paredit-mode-map (kbd "C-c c") 'paredit-splice-sexp-killing-backward)
          (define-key paredit-mode-map (kbd "C-c v") 'paredit-splice-sexp-killing-forward)))

(provide 'config-cl)
