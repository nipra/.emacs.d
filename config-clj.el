(setq additional-paths-clj '("/home/nipra/.emacs.d"
                             "/home/nipra/.emacs.d/clj"
                             ;; https://github.com/pallet/ritz
                             ;; Ritz
                             ;; "/home/nipra/.emacs.d/clj/swank-clojure"

                             ;; "/home/nipra/.emacs.d/clj/slime"
                             ;; "/home/nipra/.emacs.d/clj/slime/contrib"

                             ;; "/home/nipra/.emacs.d/clj/official/slime-2012-02-12"
                             ;; "/home/nipra/.emacs.d/clj/official/slime-2012-02-12/contrib"

                             "/home/nipra/.emacs.d/clj/slime.technomancy.git"
                             "/home/nipra/.emacs.d/clj/slime.technomancy.git/contrib"

                             ;; "/home/nipra/.emacs.d/clj/clojure-mode-1.5"
                             "/home/nipra/.emacs.d/clj/clojure-mode-1.8.0"

                             ;; Broken
                             ;; "/home/nipra/.emacs.d/clj/clojure-mode.git"
                             
                             ;; Ritz
                             ;; "/home/nipra/.emacs.d/clj/ritz/slime"
                             ;; "/home/nipra/.emacs.d/clj/ritz/slime/contrib"
                             ))

(setq load-path (append additional-paths-clj load-path))

;; Slime
;; http://dev.clojure.org/display/doc/Getting+Started+with+Emacs
;; (require 'slime)
;; ;; (eval-after-load 'slime '(setq slime-protocol-version 'ignore))
;; (slime-setup '(slime-repl))


;; Clojure
;;; Ritz
;; (require 'swank-clojure-autoload)
(require 'paredit)
(require 'clojure-mode)
(require 'clojure-test-mode) 
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

(require 'slime)
;; (require 'slime-autoloads)
(slime-setup '(slime-fancy
               slime-repl
               slime-asdf
               slime-fuzzy))
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (slime-mode t)))
;; (require 'paredit)

;;; Ritz
;; (require 'slime-ritz)

;; ;; ;; PAREDIT-MODE

(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)
;; (add-hook 'paredit-mode-hook (lambda () (slime-mode t)))

;; (autoload 'paredit-mode "paredit"
;;   "Minor mode for pseudo-structurally editing Lisp code."
;;   t)

(add-hook 'slime-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'slime-connected-hook (lambda () (paredit-mode +1)))

(add-hook 'slime-connected-hook (lambda ()
                                  (require 'clojure-mode)))

;; (setq slime-complete-symbol*-fancy t)
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
(setq slime-net-coding-system 'utf-8-unix)

(add-hook 'slime-repl-mode-hook
          (defun clojure-mode-slime-font-lock ()
            (let (font-lock-mode)
              (clojure-mode-font-lock-setup))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://groups.google.com/group/clojure/msg/b5a4f5b3b7e63d35
;;; http://gist.github.com/raw/337280/cba0979f0caf42053d854053c7f457bfd1d33d03/clojure-font-lock-setup.el
;;; all code in this function lifted from the clojure-mode function
;;; from clojure-mode.el

;;; http://stackoverflow.com/questions/2474804/is-there-a-colored-repl-for-clojure

;; (defun clojure-font-lock-setup ()
;;   (interactive)
;;   (set (make-local-variable 'lisp-indent-function)
;;        'clojure-indent-function)
;;   (set (make-local-variable 'lisp-doc-string-elt-property)
;;        'clojure-doc-string-elt)
;;   (set (make-local-variable 'font-lock-multiline) t)

;;   (add-to-list 'font-lock-extend-region-functions
;;                'clojure-font-lock-extend-region-def t)

;;   (when clojure-mode-font-lock-comment-sexp
;;     (add-to-list 'font-lock-extend-region-functions
;;                  'clojure-font-lock-extend-region-comment t)
;;     (make-local-variable 'clojure-font-lock-keywords)
;;     (add-to-list 'clojure-font-lock-keywords
;;                  'clojure-font-lock-mark-comment t)
;;     (set (make-local-variable 'open-paren-in-column-0-is-defun-start) nil))

;;   (setq font-lock-defaults
;;         '(clojure-font-lock-keywords    ; keywords
;;           nil nil
;;           (("+-*/.<>=!?$%_&~^:@" . "w")) ; syntax alist
;;           nil
;;           (font-lock-mark-block-function . mark-defun)
;;           (font-lock-syntactic-face-function
;;            . lisp-font-lock-syntactic-face-function))))

;; (add-hook 'slime-repl-mode-hook
;;           (lambda ()
;;             ;; (font-lock-mode nil)
;;             (clojure-font-lock-setup)
;;             ;; (font-lock-mode t)
;;             ))


;; (defadvice slime-repl-emit (after sr-emit-ad activate)
;;   (with-current-buffer (slime-output-buffer)
;;     (add-text-properties slime-output-start slime-output-end
;;                          '(font-lock-face slime-repl-output-face
;;                                           rear-nonsticky (font-lock-face)))))

;; (defadvice slime-repl-insert-prompt (after sr-prompt-ad activate)
;;   (with-current-buffer (slime-output-buffer)
;;     (let ((inhibit-read-only t))
;;       (add-text-properties slime-repl-prompt-start-mark (point-max)
;;                            '(font-lock-face slime-repl-prompt-face
;;                                             rear-nonsticky
;;                                             (slime-repl-prompt
;;                                              read-only
;;                                              font-lock-face
;;                                              intangible))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; http://bc.tech.coop/blog/081120.html
;;; Clojure SLIME Mods for Java Documentation

;; (setq slime-browse-local-javadoc-root "/usr/share/doc/sun-java6-doc/html/api/")

;; (defun slime-browse-local-javadoc (ci-name)
;;   "Browse local JavaDoc documentation on Java class/Interface at point."
;;   (interactive (list (slime-read-symbol-name "Class/Interface name: ")))
;;   (when (not ci-name)
;;     (error "No name given"))
;;   (let ((name (replace-regexp-in-string "\\$" "." ci-name))
;;         (path (concat (expand-file-name slime-browse-local-javadoc-root) "")))
;;     (with-temp-buffer
;;       (insert-file-contents (concat path "allclasses-noframe.html"))
;;       (let ((l (delq nil
;;                      (mapcar #'(lambda (rgx)
;;                                  (let* ((r (concat "\\.?\\(" rgx "[^./]+\\)[^.]*\\.?$"))
;;                                         (n (if (string-match r name)
;;                                                (match-string 1 name)
;;                                              name)))
;;                                    (if (re-search-forward (concat "<A HREF=\"\\(.+\\)\" +.*>" n "<.*/A>") nil t)
;;                                        (match-string 1)
;;                                      nil)))
;;                              '("[^.]+\\." "")))))
;;         (if l
;;             (browse-url (concat "file://" path (car l)))
;;           (error (concat "Not found: " ci-name)))))))

;; (add-hook 'slime-connected-hook #'(lambda ()
;;                                     (define-key slime-mode-map          (kbd "C-c C-d j")   'slime-browse-local-javadoc)
;;                                     (define-key slime-repl-mode-map     (kbd "C-c C-d j")   'slime-browse-local-javadoc)))


(eval-after-load 'slime
  '(progn (define-key slime-mode-map (kbd "C-c M-a") 'slime-arglist)
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
          ;; (define-key slime-mode-map (kbd "C-M-m") 'mark-sexp)
          (define-key slime-mode-map (kbd "C-c :") 'slime-eval-buffer)
          (define-key slime-mode-map (kbd "C-c r") 'slime-send-dwim)
          (define-key slime-mode-map (kbd "C-c s") 'my-slime-send-dwim)
          ;; (define-key slime-mode-map (kbd "C-x C-k 0") 'redshank-indent-slots)

          (define-key slime-mode-map          (kbd "C-c C-d j")   'slime-browse-local-javadoc)))

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
          ;; (define-key slime-repl-mode-map (kbd "C-c C-d h") 'cl-lookup)
          (define-key slime-repl-mode-map (kbd "C-c C-x c") 'slime-list-connections)
          (define-key slime-repl-mode-map     (kbd "C-c C-d j")   'slime-browse-local-javadoc)))




;; Paredit mode
(eval-after-load 'paredit
  '(progn (define-key paredit-mode-map (kbd "(")       'paredit-open-parenthesis)
          (define-key paredit-mode-map (kbd ")")       'paredit-close-parenthesis)
          (define-key paredit-mode-map (kbd "{")       'paredit-open-curly)
          (define-key paredit-mode-map (kbd "}")       'paredit-close-curly)
          (define-key paredit-mode-map (kbd "[")       'paredit-open-square)
          (define-key paredit-mode-map (kbd "]")       'paredit-close-square)
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

;;; Add the following to your .emacs file for better Trammel formatting:
;;; https://github.com/fogus/trammel
;; (eval-after-load 'clojure-mode
;;   '(define-clojure-indent
;;      (contract 'defun)
;;      (defconstrainedfn 'defun)
;;      (defcontract 'defun)
;;      (provide 'defun)))

(provide 'config-clj)
