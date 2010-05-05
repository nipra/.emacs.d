(setq additional-paths '("/home/nipra/.emacs.d"
                         "/home/nipra/.emacs.d/swank-clojure"
			 "/home/nipra/.emacs.d/slime"
			 "/home/nipra/.emacs.d/slime/contrib"
			 "/home/nipra/.emacs.d/clojure-mode-1.5"

			 "/home/nipra/.emacs.d/magit"
			 "/home/nipra/.emacs.d/emacs-w3m"
			 "/home/nipra/.emacs.d/twittering-mode"))

(setq load-path (append additional-paths load-path))

;; Slime
(require 'slime-autoloads)
(slime-setup '(slime-fancy
               slime-repl
               slime-asdf))
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (slime-mode t)))


;; Clojure
(require 'swank-clojure-autoload)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))


;; -----------------------------
;; General Display Customisation
;; -----------------------------

(setq inhibit-startup-message t)
(setq font-lock-maximum-decoration t)
(setq visible-bell t)
(setq require-final-newline t)
(setq resize-minibuffer-frame t)
(setq column-number-mode t)
(setq-default transient-mark-mode t)
(setq next-line-add-newlines nil)
(setq blink-matching-paren t)
(setq blink-matching-delay .25)
(setq size-indication-mode t)
(global-font-lock-mode 1 t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(show-paren-mode t)
(set-scroll-bar-mode 'nil)
(savehist-mode 1)
;; (setq cursor-type "box")
;; (set-cursor-color "red")
(setq frame-title-format "%b")
(setq icon-title-format  "%b")
(setq query-replace-highlight t)
(setq search-highlight t)
(setq mouse-avoidance-mode 'banish)
(set-frame-font "DejaVu Sans Mono-8")


;; X11 Copy & Paste to/from Emacs
(setq x-select-enable-clipboard t)

;; 'y' for 'yes', 'n' for 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;; ;; ----------------------
;; ;; Final newline handling
;; ;; ----------------------
(setq require-final-newline t)
(setq next-line-extends-end-of-buffer nil)
(setq next-line-add-newlines nil)

;; ;; ;; -------------------
;; ;; ;; Everything in UTF-8
;; ;; ;; -------------------
(prefer-coding-system 'utf-8)
(set-language-environment 'UTF-8)
(set-default-coding-systems             'utf-8)
(setq file-name-coding-system           'utf-8)
(setq buffer-file-coding-system 'utf-8)
(setq coding-system-for-write           'utf-8)
(set-keyboard-coding-system             'utf-8)
(set-terminal-coding-system             'utf-8)
(set-clipboard-coding-system            'utf-8)
(set-selection-coding-system            'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
;; (add-to-list 'auto-coding-alist '("." . utf-8))

;; ;; ;; ---------
;; ;; ;; TAB Setup
;; ;; ;; ---------
;; (setq-default tab-width 8
;; 	      standard-indent 4
;; 	      indent-tabs-mode nil)

;; ;; ;; COLOR-THEME
(require 'color-theme)
(require 'zenburn)
;; (zenburn)
(color-theme-hober)

;; ;; ;; -----------------
;; ;; ;; Insert time stamp
;; ;; ;; -----------------
(defun insert-date ()
  "Insert current date and time."
  (interactive "*")
  (insert (current-time-string)))

(add-hook 'before-save-hook 'time-stamp)


;; ;; ;; ----------------------------------------
;; ;; ;; kill current buffer without confirmation
;; ;; ;; ----------------------------------------
(global-set-key "\C-xk" 'kill-current-buffer)
(defun kill-current-buffer ()
  "Kill the current buffer, without confirmation."
  (interactive)
  (kill-buffer (current-buffer)))


;; ;; ;; ---------
;; ;; ;; Automodes
;; ;; ;; ---------
(setq auto-mode-alist (append '(("\\.py$" . python-mode)
                                ("\\.conf$" . conf-mode)
                                ("\\.sh$" . shell-script-mode)
                                ("\\.txt$" . text-mode)
                                ("\\.lisp" . lisp-mode)
                                ("\\.textile\\'" . textile-mode)
                                ("\\.rnc$" . rnc-mode))
                              auto-mode-alist))


;; ;; ;; ------------
;; ;; ;; General Info
;; ;; ;; ------------
(setq user-mail-address "prabhakar.nikhil@gmail.com")
(setq user-full-name "Nikhil Prabhakar")

;;; Snippet for full screen toggling
(defun toggle-fullscreen () 
  (interactive) 
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen) 
                                           nil 
                                           'fullboth)))
(global-set-key [(meta return)] 'toggle-fullscreen) 

(when (executable-find "wmctrl")        ; apt-get install wmctrl
  (defun full-screen-toggle ()
    (interactive)
    (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))
  (global-set-key (kbd "<f11>")  'full-screen-toggle))


;;; Magit
(require 'magit)

;; Set the name of the host and current path/file in title bar:
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
	    '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))


;; ;; ;; PAREDIT-MODE
(require 'paredit)
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

;; -----
;; SLIME
;; -----

(setq common-lisp-hyperspec-root
      ;; "http://www.lispworks.com/reference/HyperSpec/"
      "file:///home/nipra/Documents/Lisp/HyperSpec/")

(add-hook 'slime-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'slime-connected-hook (lambda () (paredit-mode +1)))
(setq slime-complete-symbol*-fancy t)
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://groups.google.com/group/clojure/msg/b5a4f5b3b7e63d35
;;; http://gist.github.com/raw/337280/cba0979f0caf42053d854053c7f457bfd1d33d03/clojure-font-lock-setup.el
;;; all code in this function lifted from the clojure-mode function
;;; from clojure-mode.el

;;; http://stackoverflow.com/questions/2474804/is-there-a-colored-repl-for-clojure

(defun clojure-font-lock-setup ()
  (interactive)
  (set (make-local-variable 'lisp-indent-function)
       'clojure-indent-function)
  (set (make-local-variable 'lisp-doc-string-elt-property)
       'clojure-doc-string-elt)
  (set (make-local-variable 'font-lock-multiline) t)

  (add-to-list 'font-lock-extend-region-functions
               'clojure-font-lock-extend-region-def t)

  (when clojure-mode-font-lock-comment-sexp
    (add-to-list 'font-lock-extend-region-functions
                 'clojure-font-lock-extend-region-comment t)
    (make-local-variable 'clojure-font-lock-keywords)
    (add-to-list 'clojure-font-lock-keywords
                 'clojure-font-lock-mark-comment t)
    (set (make-local-variable 'open-paren-in-column-0-is-defun-start) nil))

  (setq font-lock-defaults
        '(clojure-font-lock-keywords    ; keywords
          nil nil
          (("+-*/.<>=!?$%_&~^:@" . "w")) ; syntax alist
          nil
          (font-lock-mark-block-function . mark-defun)
          (font-lock-syntactic-face-function
           . lisp-font-lock-syntactic-face-function))))

(add-hook 'slime-repl-mode-hook
          (lambda ()
            ;; (font-lock-mode nil)
            (clojure-font-lock-setup)
            ;; (font-lock-mode t)
	    ))


(defadvice slime-repl-emit (after sr-emit-ad activate)
  (with-current-buffer (slime-output-buffer)
    (add-text-properties slime-output-start slime-output-end
                         '(font-lock-face slime-repl-output-face
                                          rear-nonsticky (font-lock-face)))))

(defadvice slime-repl-insert-prompt (after sr-prompt-ad activate)
  (with-current-buffer (slime-output-buffer)
    (let ((inhibit-read-only t))
      (add-text-properties slime-repl-prompt-start-mark (point-max)
                           '(font-lock-face slime-repl-prompt-face
                                            rear-nonsticky
                                            (slime-repl-prompt
                                             read-only
                                             font-lock-face
                                             intangible))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



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

          ))

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

;; Use w3m for web browsing.  (Mostly for SLIME Hyperspec lookups.)
(require 'w3m-load)
(require 'w3m)

(defun w3m-new-tab ()
  (interactive)
  (w3m-copy-buffer nil nil nil t))

(defun w3m-browse-url-new-tab (url &optional new-session)
  (interactive)
  (unless (eql major-mode 'w3m-mode)
    (if (> (length (window-list)) 2)
        (other-window 0)
        (if (= (length (window-list)) 1)
            (progn (split-window-vertically)
                   (other-window 1))
            (other-window 1))))
  (w3m-new-tab)
  (w3m-browse-url url))

(setq browse-url-browser-function 'w3m-browse-url-new-tab)

;; w3m mode key bindings
(define-key w3m-mode-map (kbd "t")         'w3m-goto-url-new-session)
(define-key w3m-mode-map (kbd "u")         'w3m-view-this-url-new-session)
(define-key w3m-mode-map (kbd "c")         'w3m-delete-buffer)
(define-key w3m-mode-map (kbd "M-c")       'w3m-delete-other-buffers)
(define-key w3m-mode-map (kbd "n")         'w3m-next-buffer)
(define-key w3m-mode-map (kbd "p")         'w3m-previous-buffer)
(define-key w3m-mode-map (kbd "M-l")       'w3m-delete-left-tabs)
(define-key w3m-mode-map (kbd "M-r")       'w3m-delete-right-tabs)
(define-key w3m-mode-map (kbd "C-c C-d h") 'cl-lookup)
(define-key w3m-mode-map (kbd "C-c C-f")   'w3m-find-file)

;; http://web.archive.org/web/20061025212623/http://www.cs.utexas.edu/users/hllu/EmacsSmoothScrolling.html
(setq truncate-lines t)

(defun point-of-beginning-of-bottom-line ()
  (save-excursion
    (move-to-window-line -1)
    (point)))

(defun point-of-beginning-of-line ()
  (save-excursion
    (beginning-of-line)
    (point)))

(defun next-one-line () (interactive)
  (if (= (point-of-beginning-of-bottom-line) (point-of-beginning-of-line))
      (progn (scroll-up 1)
             (next-line 1))
    (next-line 1)))

(defun point-of-beginning-of-top-line ()
  (save-excursion
    (move-to-window-line 0)
    (point)))

(defun previous-one-line () (interactive)
  (if (= (point-of-beginning-of-top-line) (point-of-beginning-of-line))
      (progn (scroll-down 1)
             (previous-line 1))
    (previous-line 1)))

(global-set-key (kbd "C-n") 'next-one-line)
(global-set-key (kbd "C-p") 'previous-one-line)


(defun rename-buffer* ()
  (interactive)
  (let* ((buffer-name (buffer-name))
         (file-name (buffer-file-name))
         (directory (file-name-directory file-name))
         (new-buffer-name (format "%s %s" buffer-name directory)))
    (rename-buffer new-buffer-name)))






;; starter-kit-defuns.el
(defun sudo-edit (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))


;; starter-kit-bindings.el

;; Turn on the menu bar for exploring new modes
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)
;; Help should search more than just commands
(global-set-key (kbd "C-h a") 'apropos)


;; starter-kit-misc.el
;; ido-mode is like magic pixie dust!
(when (> emacs-major-version 21)
  (ido-mode t)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point 'guess
        ido-max-prospects 10))

;; Cosmetics
(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")))

;;; someday might want to rotate windows if more than 2 of them
;;; http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun swap-windows ()
  "If you have 2 windows, it swaps them."
  (interactive)
  (cond ((not (= (count-windows) 2))
         (message "You need exactly 2 windows to do this."))
        
        (t
         (let* ((w1 (first (window-list)))
                (w2 (second (window-list)))
                (b1 (window-buffer w1))
                (b2 (window-buffer w2))
                (s1 (window-start w1))
                (s2 (window-start w2)))
           (set-window-buffer w1 b2)
           (set-window-buffer w2 b1)
           (set-window-start w1 s2)
           (set-window-start w2 s1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://www.emacswiki.org/emacs/TransposeWindows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; When working with multiple windows it can be annoying if they get out of order. With this function it’s easy
;;; to fix that. This is a slight rewrite of an original written by ThomasBellman.

(defun transpose-windows (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
	    (next-win (window-buffer (funcall selector))))
	(set-window-buffer (selected-window) next-win)
	(set-window-buffer (funcall selector) this-win)
	(select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))


(define-key ctl-x-4-map (kbd "t") 'transpose-windows)

;;; And because diversity is a good thing, here is Stephen Gildea’s version of the same:
(defun swap-window-positions ()         ; Stephen Gildea
  "*Swap the positions of this window and the next one."
  (interactive)
  (let ((other-window (next-window (selected-window) 'no-minibuf)))
    (let ((other-window-buffer (window-buffer other-window))
	  (other-window-hscroll (window-hscroll other-window))
	  (other-window-point (window-point other-window))
	  (other-window-start (window-start other-window)))
      (set-window-buffer other-window (current-buffer))
      (set-window-hscroll other-window (window-hscroll (selected-window)))
      (set-window-point other-window (point))
      (set-window-start other-window (window-start (selected-window)))
      (set-window-buffer (selected-window) other-window-buffer)
      (set-window-hscroll (selected-window) other-window-hscroll)
      (set-window-point (selected-window) other-window-point)
      (set-window-start (selected-window) other-window-start))
    (select-window other-window)))


(setq swapping-buffer nil)
(setq swapping-window nil)

;;; ChrisWebber provides a similar function, but this one allows you to select which two you want to swap
;;; (perhaps if you have 3 or more windows open)

(defun swap-buffers-in-windows ()
  "Swap buffers between two windows"
  (interactive)
  (if (and swapping-window
	   swapping-buffer)
      (let ((this-buffer (current-buffer))
	    (this-window (selected-window)))
	(if (and (window-live-p swapping-window)
		 (buffer-live-p swapping-buffer))
	    (progn (switch-to-buffer swapping-buffer)
		   (select-window swapping-window)
		   (switch-to-buffer this-buffer)
		   (select-window this-window)
		   (message "Swapped buffers."))
	  (message "Old buffer/window killed.  Aborting."))
	(setq swapping-buffer nil)
	(setq swapping-window nil))
    (progn
      (setq swapping-buffer (current-buffer))
      (setq swapping-window (selected-window))
      (message "Buffer and window marked for swapping."))))

 (global-set-key (kbd "C-c p") 'swap-buffers-in-windows)

;;; Yet another window-altering function by Robert Bost slightly based on Steve Yegge’s swap-windows. This one
;;; will handle > 1 windows.
(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows) 1)) (message "You can't rotate a sinlge window!"))
	(t
	 (setq i 1)
	 (setq numWindows (count-windows))
	 (while  (< i numWindows)
	   (let* (
		  (w1 (elt (window-list) i))
		  (w2 (elt (window-list) (+ (% i numWindows) 1)))

		  (b1 (window-buffer w1))
		  (b2 (window-buffer w2))

		  (s1 (window-start w1))
		  (s2 (window-start w2))
		  )
	     (set-window-buffer w1  b2)
	     (set-window-buffer w2 b1)
	     (set-window-start w1 s2)
	     (set-window-start w2 s1)
	     (setq i (1+ i)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global key bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(global-set-key (kbd "C-x M-k") 'kill-some-buffers)
;(global-set-key (kbd "C-c C-l") 'move-to-window-line)
(global-set-key (kbd "<f2>") 'select-frame-by-name)
(global-set-key (kbd "<f3>") 'set-frame-name)
(global-set-key (kbd "C-x M-r") 'rename-buffer)
(global-set-key (kbd "C-x M-b") 'rename-buffer*)
(global-set-key (kbd "<f6>") 'advertised-undo)
;(global-set-key "\C-xs" 'kill-some-buffers)
(global-set-key (kbd "RET") 'newline-and-indent)

(global-set-key (kbd "C-M-y") 'scroll-other-down-full-screen)
(global-set-key (kbd "C-M-z") 'scroll-other-up-1)
(global-set-key (kbd "C-M-c") 'scroll-other-down-1)

(global-set-key (kbd "C-x M-s") 'swap-windows)
(global-set-key (kbd  "C-x O") 'other-window-minus)
(global-set-key (kbd  "C-x o") 'other-window)




;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;; (when
;;     (load
;;      (expand-file-name "~/.emacs.d/elpa/package.el"))
;;   (package-initialize))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;; http://www.emacswiki.org/emacs-en/ShellPop
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell "/bin/bash")
(shell-pop-set-window-height 100) ;the number for the percentage of the selected window. if 100, shell-pop use the whole of selected window, not spliting.
(shell-pop-set-window-position "bottom") ;shell-pop-up position. You can choose "top" or "bottom". 
(global-set-key [f8] 'shell-pop)


;;; http://www.emacswiki.org/emacs/TwitteringMode
(require 'twittering-mode)
;; (setq twittering-username "twitter user name here")
;; (setq twittering-password "twitter password here")

;; (twittering-icon-mode)                       ; Show icons (requires wget)
(setq twittering-timer-interval 300)         ; Update your timeline each 300 seconds (5 minutes)
(setq twittering-tmp-dir "~/.emacs.d/twittering-mode/twittering-tmp-dir") ; Directory to store buddy icons
(nconc twittering-tinyurl-services-map '((unu . "http://u.nu/unu-api-simple?url=")))
(setq twittering-tinyurl-service 'unu)

;; (add-hook 'twittering-mode-hook
;; 	  (lambda ()
;; 	    (local-set-key "f" 'twittering-friends-timeline)
;; 	    (local-set-key "r" 'twittering-replies-timeline)
;; 	    (local-set-key "u" 'twittering-user-timeline)
;; 	    (local-set-key "w" 'twittering-update-status-interactive)))

(setq twittering-status-format (concat "%i %s:  %@:\n%FILL{  %T } \n\n⋙ from %f%L%r%R\n" "-----------------------------------"))
(setq twittering-convert-fix-size 30)
(add-hook 'twittering-mode-hook (lambda () (setq browse-url-browser-function nil)))

;; Typing Speed
;;; http://www.pluralsight-training.net/community/blogs/craig/archive/2008/10/07/typing-speed-mode-emacs-minor-mode.aspx
(require 'typing-speed)
(add-hook 'text-mode-hook (lambda () (typing-speed-mode t)))
(add-hook 'clojure-mode-hook (lambda () (typing-speed-mode t)))
(add-hook 'lisp-mode-hook (lambda () (typing-speed-mode t)))
(add-hook 'python-mode-hook (lambda () (typing-speed-mode t)))


;; http://www.emacswiki.org/emacs/EmacsNiftyTricks
;; Use cursor-chg.el to ChangingCursorDynamically. If you sometimes find
;; yourself inadvertently overwriting some text because you are in overwrite
;; mode but you didn’t expect so, this might prove useful. It changes cursor
;; color and shape to indicate read-only and overwrite modes. And here is
;; another way:

(setq hcz-set-cursor-color-color "")
(setq hcz-set-cursor-color-buffer "")
(defun hcz-set-cursor-color-according-to-mode ()
  "change cursor color according to some minor modes."
  ;; set-cursor-color is somewhat costly, so we only call it when needed:
  (let ((color
         (if buffer-read-only
             "green"
             (if overwrite-mode
                 "blue"
                 "red"))))
    (unless (and
             (string= color hcz-set-cursor-color-color)
             (string= (buffer-name) hcz-set-cursor-color-buffer))
      (set-cursor-color (setq hcz-set-cursor-color-color color))
      (setq hcz-set-cursor-color-buffer (buffer-name)))))
(add-hook 'post-command-hook 'hcz-set-cursor-color-according-to-mode)
