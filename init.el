(setq mac? (eq system-type 'darwin))
(setq nipra-home (getenv "HOME"))
(setq additional-paths-common (list (concat nipra-home "/.emacs.d")
                                    (concat nipra-home "/.emacs.d/magit")
                                    ;; (concat nipra-home "/.emacs.d/emacs-w3m")
                                    ;; "/usr/share/emacs/site-lisp/w3m"
                                    (concat nipra-home "/.emacs.d/emacs-w3m-cvs")
                                    (concat nipra-home "/.emacs.d/twittering-mode-new")
                                    (concat nipra-home "/.emacs.d/emms-3.0")
                                    (concat nipra-home "/.emacs.d/color-themes")
                                    "/opt/local/share/emacs/site-lisp/color-theme-6.6.0"
                                    (concat nipra-home "/.emacs.d/R/ess-12.04-2/lisp")
                                    ;; "/home/nipra/.emacs.d/py"
                                    ;; "/home/nipra/.emacs.d/py-new"
                                    ;; "/home/nipra/.emacs.d/py-vedang"
                                    ;; "/home/nipra/.emacs.d/py-vedang/Pymacs"
                                    ;; "/home/nipra/.emacs.d/py-vedang/ropemacs"
                                    ;; "/home/nipra/.emacs.d/py-vedang/rope"
                                    ;; "/home/nipra/.emacs.d/py-vedang/ropemode"
                                    ;; "/home/nipra/.emacs.d/erl"
                                    ;; "/home/nipra/.emacs.d/js"
                                    (concat nipra-home "/.emacs.d/php-mode-1.5.0")
                                    ;; "/home/nipra/.emacs.d/oz"
                                    ;; "/home/nipra/.emacs.d/hs"
                                    (concat nipra-home "/.emacs.d/haskellmode-emacs")
                                    ;; "/home/nipra/.emacs.d/scala"

                                    ;; Compile cedet
                                    ;; "/home/nipra/.emacs.d/cedet/cedet-1.0beta3b/eieio"
                                    (concat nipra-home "/.emacs.d/cedet/cedet-1.0beta3b/common")
                                    (concat nipra-home "/.emacs.d/cedet/cedet-1.0beta3b/semantic")
                                    ;; "/home/nipra/.emacs.d/cedet/cedet-1.0beta3b/speedbar"
                                    ;; "/home/nipra/.emacs.d/cedet/cedet-1.0beta3b/eieio"
                                
                                    ;; Compile cedet
                                    ;; "/home/nipra/.emacs.d/cedet/cedet-1.0.1/cogre"
                                    ;; "/home/nipra/.emacs.d/cedet/cedet-1.0.1/contrib"
                                    ;; "/home/nipra/.emacs.d/cedet/cedet-1.0.1/ede"
                                    ;; "/home/nipra/.emacs.d/cedet/cedet-1.0.1/eieio"
                                    ;; "/home/nipra/.emacs.d/cedet/cedet-1.0.1/common"
                                    ;; "/home/nipra/.emacs.d/cedet/cedet-1.0.1/semantic"
                                    ;; "/home/nipra/.emacs.d/cedet/cedet-1.0.1/speedbar"
                                    ;; "/home/nipra/.emacs.d/cedet/cedet-1.0.1/srecode"

                                    (concat nipra-home "/.emacs.d/emacs-eclim")
                                    (concat nipra-home "/.emacs.d/company-mode")))

(setq load-path (append additional-paths-common load-path))

;; (require 'cedet)

(when mac? ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  ;; (global-set-key [kp-delete] 'delete-char)
  ;; sets fn-delete to be right-delete
  )

;; -----------------------------
;; General Display Customisation
;; -----------------------------

(setq inhibit-startup-message t)
(setq font-lock-maximum-decoration t)
(setq visible-bell t)
(setq require-final-newline t)
(setq resize-minibuffer-frame t)
(setq column-number-mode t)
(setq line-number-mode t)
(setq-default transient-mark-mode t)
(setq next-line-add-newlines nil)
(setq blink-matching-paren t)
(setq blink-matching-delay .25)
(setq size-indication-mode t)
(global-font-lock-mode 1)
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
(if mac?
    (set-frame-font "DejaVu Sans Mono-14")
  (set-frame-font "DejaVu Sans Mono-10"))


;; X11 Copy & Paste to/from Emacs
(setq x-select-enable-clipboard t)

;; 'y' for 'yes', 'n' for 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;;; If the value of the variable confirm-kill-emacs is non-nil, C-x C-c assumes
;;; that its value is a predicate function, and calls that function.

(setq confirm-kill-emacs 'y-or-n-p)

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

(setq-default tab-width 4
	          indent-tabs-mode nil)

;; http://www.emacswiki.org/emacs/TransparentEmacs
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))

(transparency 100)

;;; anything
(require 'anything)

;; ;; ;; COLOR-THEME
(require 'color-theme)
(color-theme-initialize)
(color-theme-hober)

(require 'zenburn)
;; (zenburn)

(require 'color-theme-billc)
;; (color-theme-billc)

(require 'gentooish)
;; (color-theme-gentooish)

(require 'color-theme-tango)
;; (color-theme-tango)

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
(setq auto-mode-alist (append '(("\\.conf$" . conf-mode)
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
;; (require 'paredit)
;; (autoload 'paredit-mode "paredit"
;;   "Minor mode for pseudo-structurally editing Lisp code."
;;   t)

;; (add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode t)))


;; -----
;; SLIME
;; -----

(setq common-lisp-hyperspec-root
      ;; "http://www.lispworks.com/reference/HyperSpec/"
      ;; "file:///home/nipra/Documents/Lisp/HyperSpec/"
      (concat "file://" nipra-home "/Documents/Lisp/HyperSpec/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs-w3m
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Use w3m for web browsing.  (Mostly for SLIME Hyperspec lookups.)
(when (not mac?)
  (require 'w3m-load)
  (require 'w3m)
  (setq w3m-use-cookies t)
  (setq w3m-default-display-inline-images t)

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
  ;; (define-key w3m-mode-map (kbd "b")   'w3m-bookmark-add-current-url)

;;; http://www.emacswiki.org/emacs/WThreeMHintsAndTips

;;; Browsing the current buffer
  (defun w3m-browse-current-buffer ()
    (interactive)
    (let ((filename (concat (make-temp-file "w3m-") ".html")))
      (unwind-protect
          (progn
            (write-region (point-min) (point-max) filename)
            (w3m-find-file filename))
        (delete-file filename))))


;;; http://github.com/emacsmirror/w3m-multibookmarks
  (require 'w3m-multibookmarks)
  ;; (setq w3m-multibookmarks-enable t)


  (setq w3m-multibookmarks-list
        '(("b"  "~/.emacs.d/data/bookmarks.html" "Firefox")
          ("w"  "~/.w3m/bookmark.html" "w3m")
          ("f" "~/.mozilla/firefox/7d5an3qn.default/bookmarks.html" "FF Updated")))

  ;; (eval-after-load 'w3m-multibookmarks
  ;;   '(progn 
  ;;      (define-key w3m-mode-map (kbd "a")   'w3m-bookmark-add-current-url)))
  )

;;; anything-delicious
(require 'anything-delicious)
(setq anything-delicious-user nil)
(setq anything-delicious-password nil)

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


;;; http://www.emacswiki.org/emacs/RevertBuffer
(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files.") )


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
;; (require 'shell-pop)
;; (shell-pop-set-internal-mode "ansi-term")
;; (shell-pop-set-internal-mode-shell "/bin/bash")
;; (shell-pop-set-window-height 100) ;the number for the percentage of the selected window. if 100, shell-pop use the whole of selected window, not spliting.
;; (shell-pop-set-window-position "bottom") ;shell-pop-up position. You can choose "top" or "bottom". 
;; (global-set-key [f8] 'shell-pop)


;;; http://www.emacswiki.org/emacs/TwitteringMode
(require 'twittering-mode)
;; (setq twittering-username "twitter user name here")
;; (setq twittering-password "twitter password here")

;; (twittering-icon-mode)                       ; Show icons (requires wget)
(setq twittering-timer-interval 300)         ; Update your timeline each 300 seconds (5 minutes)
(setq twittering-tmp-dir "~/.emacs.d/twittering-mode/twittering-tmp-dir") ; Directory to store buddy icons
(nconc twittering-tinyurl-services-map '((unu . "http://u.nu/unu-api-simple?url=")
                                         (bitly . "http://api.bit.ly/v3/shorten?login=nipra&apiKey=R_1f466bc1d834924dddc8bbb488001e6b&format=txt&uri=")))
(setq twittering-tinyurl-service 'unu)

;; (add-hook 'twittering-mode-hook
;; 	  (lambda ()
;; 	    (local-set-key "f" 'twittering-friends-timeline)
;; 	    (local-set-key "r" 'twittering-replies-timeline)
;; 	    (local-set-key "u" 'twittering-user-timeline)
;; 	    (local-set-key "w" 'twittering-update-status-interactive)))

(setq twittering-status-format (concat "%i %s:  %@:\n%FILL{  %T } \n\n⋙ from %f%L%r%R\n" "-----------------------------------"))
(setq twittering-convert-fix-size 30)
;; (add-hook 'twittering-mode-hook (lambda ()
;; 				  (setq browse-url-browser-function 'w3m-browse-url-new-tab)))
(setq twittering-retweet-format "RT @%s: %t")


;; (defun start-twittering-and-go-make-a-cup-of-coffee ()
;;   (interactive)
;;   (twittering-mode)
;;   (twittering-icon-mode)

;;   (mapcar (lambda (x)
;; 	    (split-window-horizontally)
;; 	    (other-window 1)
;; 	    (twittering-search x))

;; 	  '("#clojure" "common lisp" "#emacs"))

;;   (split-window-horizontally)
;;   (twittering-replies-timeline)
;;   (twittering-icon-mode)

;;   (mapcar (lambda (x)
;; 	    (other-window 1)
;; 	    (twittering-icon-mode))
;; 	  '(1 2 3 4))

;;   (balance-windows))

;; (defun start-twittering-quick ()
;;   (interactive)
;;   (twittering-mode)

;;   (mapcar (lambda (x)
;; 	    (split-window-horizontally)
;; 	    (other-window 1)
;; 	    (twittering-search x))

;; 	  '("#clojure" "#lisp" "#emacs"))

;;   (split-window-horizontally)
;;   (other-window 1)
;;   (twittering-replies-timeline)

;;   (balance-windows))

(defun start-twittering-quick* ()
  (interactive)
  (delete-other-windows)
  ;; (full-screen-toggle)
  (twittering-mode)

  (split-window-horizontally)
  (other-window 1)
  (twittering-search "#clojure")

  (split-window-horizontally)
  (other-window 1)
  (twittering-search "#mongodb")

  (split-window-horizontally)
  (other-window 1)
  (twittering-replies-timeline)
  
  (balance-windows)
  (rotate-windows)
  (rotate-windows)
  (rotate-windows))

;; Typing Speed
;;; http://www.pluralsight-training.net/community/blogs/craig/archive/2008/10/07/typing-speed-mode-emacs-minor-mode.aspx
;; (require 'typing-speed)
;; (add-hook 'text-mode-hook (lambda () (typing-speed-mode t)))
;; (add-hook 'clojure-mode-hook (lambda () (typing-speed-mode t)))
;; (add-hook 'lisp-mode-hook (lambda () (typing-speed-mode t)))
;; (add-hook 'python-mode-hook (lambda () (typing-speed-mode t)))


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

;; http://www.emacswiki.org/emacs/TwIt
(require 'twit)

;; Define M-x commands

(autoload 'twit-show-recent-tweets      "twit" "" t) ; most recent direct tweets (!)
(autoload 'twit-show-at-tweets          "twit" "" t) ; directed to you
(autoload 'twit-show-friends            "twit" "" t) ; your friends
(autoload 'twit-show-followers          "twit" "" t) ; your followers

(autoload 'twit-follow-recent-tweets    "twit" "" t) ; at idle, check at background

(autoload 'twit-post                    "twit" "" t)
(autoload 'twit-post-region             "twit" "" t)
(autoload 'twit-post-buffer             "twit" "" t)
(autoload 'twit-direct                  "twit" "" t) ; tweet to person

(autoload 'twit-add-favorite            "twit" "" t) ; Add to favourite: (*) star
(autoload 'twit-remove-favorite         "twit" "" t)

(autoload 'twit-add-friend              "twit" "" t) ; follow a friend
(autoload 'twit-remove-friend           "twit" "" t) ; emove a frienda

;; Customize twit-multi-accounts in order to use these: ((user . pass) ...)
(autoload 'twit-switch-account          "twit" "" t)
(autoload 'twit-direct-with-account     "twit" "" t)
(autoload 'twit-post-with-account       "twit" "" t)

(autoload 'twit-show-direct-tweets-with-account "twit" "" t)
(autoload 'twit-show-at-tweets-with-account     "twit" "" t)

;; 

;; Gnus
;; ~/.gnus.el
(require 'highline)
(add-hook 'gnus-summary-mode-hook 'highline-local-mode)
(defun my-setup-hl-line ()
  (hl-line-mode 1)
  (setq cursor-type nil) ; Comment this out, if you want the cursor to
                                        ; stay visible.
  )

(add-hook 'gnus-summary-mode-hook 'my-setup-hl-line)
(add-hook 'gnus-group-mode-hook 'my-setup-hl-line)

;; Keyboard Macros Tricks
;; http://www.emacswiki.org/emacs/KeyboardMacrosTricks
(defun save-macro (name)                  
  "save a macro. Take a name as argument
     and save the last defined macro under 
     this name at the end of your .emacs"
  (interactive "SName of the macro :")  ; ask for the name of the macro    
  (kmacro-name-last-macro name)         ; use this name for the macro    
  (find-file "~/.emacs.d/init.el")                ; open the .emacs file 
  (goto-char (point-max))               ; go to the end of the .emacs
  (newline)                             ; insert a newline
  (insert-kbd-macro name)               ; copy the macro 
  (newline)                             ; insert a newline
  (switch-to-buffer nil))               ; return to the initial buffer

(setq black-star "★")
(setq white-star "☆")

(defun star-rating (movie n comment)
  (interactive "MMovie: \nnRating: \nMComment: ")
  (let ((n-white-stars (make-string (- 10 n) ?☆))
        (n-black-stars (make-string n ?★)))
    (insert movie ": " (concat n-black-stars n-white-stars) ". " comment ".")))

;;; MultiTerm
;;; http://www.emacswiki.org/emacs/MultiTerm

(require 'multi-term)
(setq multi-term-program "/bin/bash")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun multi-term-dedicated-toggle*
;;   (interactive)
;;   (multi-term-dedicated-toggle)
;;   (multi-term-dedicated-select))

;; (defun multi-term-list ()
;;   "List term buffers presently active."
;;   ;; Autload command `remove-if-not'.
;;   (autoload 'remove-if-not "cl-seq")
;;   (sort
;;    (remove-if-not (lambda (b)
;;                     (setq case-fold-search t)
;;                     (or (string-match
;; 			 (format "^\\\*%s<[0-9]+>\\\*$" multi-term-buffer-name)
;; 			 (buffer-name b))
;; 			(string-match
;; 			 "^.+//[0-9]+$"
;; 			 (buffer-name b))))
;;                   (buffer-list))
;;    (lambda (a b)
;;      (< (string-to-number
;;          (if (string-match "^.+//[0-9]+$" (buffer-name a))
;; 	     (first (last (split-string (buffer-name a) "[/]")))
;; 	   (cadr (split-string (buffer-name a) "[<>]"))))
;;         (string-to-number
;;          (if (string-match "^.+//[0-9]+$" (buffer-name b))
;; 	     (first (last (split-string (buffer-name b) "[/]")))
;; 	   (cadr (split-string (buffer-name b)  "[<>]"))))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defun multi-term-dedicated-open* ()
;;   (interactive)
;;   (multi-term-dedicated-open)
;;   (multi-term-dedicated-select))

;; (defun multi-term-dedicated-open** ()
;;   (interactive)
;;   (other-window 1)
;;   (delete-window)
;;   (other-window -1)
;;   (multi-term-dedicated-open)
;;   (multi-term-dedicated-select))

;; (defun multi-term-dedicated-close* ()
;;   (interactive)
;;   (multi-term-dedicated-close)
;;   (other-window -1))

;; (defun multi-term-dedicated-close** ()
;;   (interactive)
;;   (multi-term-dedicated-close*)
;;   (split-window-vertically)
;;   (other-window 1))

;; (global-set-key (kbd "C-c C-t") 'multi-term)
;; (global-set-key (kbd "C-c C-n") 'multi-term-next)
;; (global-set-key (kbd "C-c C-p") 'multi-term-prev)
;; (global-set-key (kbd "<f1>") 'multi-term-dedicated-open*)
;; (global-set-key (kbd "<f2>") 'multi-term-dedicated-close*)
;; (global-set-key (kbd "<f7>") 'multi-term-dedicated-open**)
;; (global-set-key (kbd "<f9>") 'multi-term-dedicated-close**)



;;; Via #emacs
(defun lnap ()
  (interactive)
  (message "%s" (line-number-at-pos)))

(require 'line-num)

(add-to-list 'load-path "~/.emacs.d/auto-complete-installation/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete-installation//ac-dict")
(ac-config-default)
(define-key ac-mode-map (kbd "M-y") 'auto-complete)


;;;
(require 'framemove)
;; (framemove-default-keybindings) ;; default prefix is Meta

;;; http://www.emacswiki.org/emacs/frame-cmds.el
;; (require 'frame-cmds)
;; (global-set-key [(meta up)] 'move-frame-up)
;; (global-set-key [(meta down)] 'move-frame-down)
;; (global-set-key [(meta left)] 'move-frame-left)
;; (global-set-key [(meta right)] 'move-frame-right)
;; (global-set-key [(control meta down)] 'enlarge-frame)
;; (global-set-key [(control meta right)] 'enlarge-frame-horizontally)
;; (global-set-key [(control meta up)] 'shrink-frame)
;; (global-set-key [(control meta left)] 'shrink-frame-horizontally)

;; (global-set-key [(control ?x) (control ?z)] 'iconify-everything)
;; (global-set-key [vertical-line S-down-mouse-1] 'iconify-everything)
;; (global-set-key [(control ?z)] 'iconify/map-frame)
;; (global-set-key [mode-line mouse-3] 'mouse-iconify/map-frame)
;; (global-set-key [mode-line C-mouse-3] 'mouse-remove-window)
;; (global-set-key [(control meta ?z)] 'show-hide)
;; (global-set-key [vertical-line C-down-mouse-1] 'show-hide)
;; (global-set-key [C-down-mouse-1] 'mouse-show-hide-mark-unmark)
;; (substitute-key-definition 'delete-window 'remove-window global-map)
;; (define-key ctl-x-map "o" 'other-window-or-frame)
;; (define-key ctl-x-4-map "1" 'delete-other-frames)
;; (define-key ctl-x-5-map "h" 'show-*Help*-buffer)
;; (substitute-key-definition 'delete-window 'delete-windows-for global-map)
;; (define-key global-map "\C-xt." 'save-frame-config)
;; (define-key ctl-x-map "o" 'other-window-or-frame)
;;
;;   (defalias 'doremi-prefix (make-sparse-keymap))
;;   (defvar doremi-map (symbol-function 'doremi-prefix) "Keymap for Do Re Mi commands.")
;;   (define-key global-map "\C-xt" 'doremi-prefix)
;;   (define-key doremi-map "." 'save-frame-config)

(require 'cheat)

;;; EMMS

;;; http://www.gnu.org/software/emms/quickstart.html
(require 'emms-setup)
(emms-standard)
(emms-default-players)

;;; http://www.gnu.org/software/emms/manual/Configuration.html#Configuration
(require 'emms-player-simple)
(require 'emms-source-file)
(require 'emms-source-playlist)
(setq emms-player-list '(emms-player-mpg321
                         emms-player-ogg123
                         emms-player-mplayer))



;;; http://trey-jackson.blogspot.com/2008/01/emacs-tip-11-uniquify.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
;; (setq uniquify-after-kill-buffer-p t)
                                        ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers


;;; Org Mode Customisation
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files (list (concat nipra-home "/.emacs.d/org/todos.org")))


;; Python

;;; http://www.saltycrane.com/blog/2010/05/my-emacs-python-environment/
;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t)


;;; 
;; (add-hook 'find-file-hook 'flymake-find-file-hook)
;; (when (load "flymake" t)
;;   (defun flymake-pyflakes-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                'flymake-create-temp-inplace))
;;        (local-file (file-relative-name
;;             temp-file
;;             (file-name-directory buffer-file-name))))
;;       (list "pycheckers"  (list local-file))))
;;    (add-to-list 'flymake-allowed-file-name-masks
;;              '("\\.py\\'" flymake-pyflakes-init)))
;; (load-library "flymake-cursor")
;; (global-set-key [f10] 'flymake-goto-prev-error)
;; (global-set-key [f11] 'flymake-goto-next-error)


;; Erlang
;; (require 'config-erl)
;;; Distel = Emacs erlang-mode++
;;; http://bc.tech.coop/blog/070528.html

;; This is needed for Erlang mode setup
(when (not mac?)
  (setq erlang-root-dir "/usr/local/lib/erlang")
  (setq load-path (cons "/usr/local/lib/erlang/lib/tools-2.6.7/emacs" load-path))
  (setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))

  ;; (setq erlang-root-dir "/usr/lib/erlang")
  ;; (setq load-path (cons "/usr/lib/erlang/lib/tools-2.6.5/emacs" load-path))
  ;; (setq exec-path (cons "/usr/lib/erlang/bin" exec-path))

  (require 'erlang-start)

  ;; This is needed for Distel setup
  (let ((distel-dir (concat nipra-home "/.emacs.d/distel/elisp")))
    (unless (member distel-dir load-path)
      ;; Add distel-dir to the end of load-path
      (setq load-path (append load-path (list distel-dir)))))

  (require 'distel)
  (distel-setup)

  ;; Some Erlang customizations
  (add-hook 'erlang-mode-hook
            (lambda ()
              ;; when starting an Erlang shell in Emacs, default in the node name
              (setq inferior-erlang-machine-options
                    '("-sname" "emacs"
                      "-pa" (concat nipra-home "/.emacs.d/distel/src")
                      "-pa" (concat nipra-home "/Erlang/source")))
              ;; add Erlang functions to an imenu menu
              ;; (imenu-add-to-menubar "imenu")
              ))

  ;; A number of the erlang-extended-mode key bindings are useful in the shell too
  (defconst distel-shell-keys
    '(("\C-\M-i"   erl-complete)
      ("\M-?"      erl-complete)	
      ("\M-."      erl-find-source-under-point)
      ("\M-,"      erl-find-source-unwind) 
      ("\M-*"      erl-find-source-unwind))
    "Additional keys to bind when in Erlang shell.")

  (add-hook 'erlang-shell-mode-hook
            (lambda ()
              ;; add some Distel bindings to the Erlang shell
              (dolist (spec distel-shell-keys)
                (define-key erlang-shell-mode-map (car spec) (cadr spec)))))
  )


;; Oz
(or (getenv "OZHOME")
    (setenv "OZHOME" 
            "/usr/local/oz"))   ; or wherever Mozart is installed
(setenv "PATH" (concat (getenv "OZHOME") "/bin:" (getenv "PATH")))

(setq load-path (cons (concat (getenv "OZHOME") "/share/elisp")
                      load-path))

(setq auto-mode-alist 
      (append '(("\\.oz\\'" . oz-mode)
                ("\\.ozg\\'" . oz-gump-mode))
              auto-mode-alist))

(autoload 'run-oz "oz" "" t)
(autoload 'oz-mode "oz" "" t)
(autoload 'oz-gump-mode "oz" "" t)
(autoload 'oz-new-buffer "oz" "" t)

;;; JavaScript
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . espresso-mode))
(autoload 'espresso-mode "espresso" nil t)

(add-hook 'espresso-mode-hook 'espresso-custom-setup)
(defun espresso-custom-setup ()
  (moz-minor-mode 1))

;;; Haskell
(load (concat nipra-home "/.emacs.d/haskellmode-emacs/haskell-site-file"))
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(setq haskell-program-name "/usr/local/haskell-platform-2011.2.0.1/bin/ghci")
(require 'inf-haskell)

;;; Ruby
;; http://rinari.rubyforge.org/Basic-Setup.html#Basic-Setup
;; git clone git://github.com/eschulte/rinari.git
;;      cd rinari
;;      git submodule init
;;      git submodule update
(setq additional-paths-rb (list (concat nipra-home "/.emacs.d/rinari")
                                (concat nipra-home "/.emacs.d/rhtml")
                                (concat nipra-home "/.emacs.d/emacs-rails-reloaded")))

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


;;; PHP
(require 'php-mode)

;;; Java

;; http://www.emacswiki.org/emacs/java-mode-indent-annotations.el
;; (require 'java-mode-indent-annotations)

;;; http://www.emacswiki.org/emacs/JonathanArnoldDotEmacs
(setq auto-mode-alist
      (append
       '(("\\.java$" . java-mode))
       auto-mode-alist))

;; http://www.emacswiki.org/emacs/IndentingJava
(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 4
                                  tab-width 4
                                  indent-tabs-mode t)))

;; http://www.emacswiki.org/emacs/IndentingJava
(add-hook 'java-mode-hook
          (lambda ()
            "Treat Java 1.5 @-style annotations as comments."
            (setq c-comment-start-regexp "(@|/(/|[*][*]?))")
            (modify-syntax-entry ?@ "< b" java-mode-syntax-table)))

;; <<START>>

;; https://github.com/senny/emacs-eclim
;; This project brings some of the great eclipse features to emacs
;; developers. It is based on the eclim project, which provides
;; eclipse features for vim.

(require 'eclim)
(global-eclim-mode)

(custom-set-variables
 '(eclim-eclipse-dirs (list (concat nipra-home "/Downloads/eclipse"))))

;;
(setq eclim-executable (concat nipra-home "/Downloads/eclipse/eclim"))
(setq eclimd-executable nil)
(setq eclim-auto-save nil)              ; Turn off auto save

;; Displaying compilation error messages in the echo area
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

;; Emacs-eclim can integrate with company-mode to provide pop-up
;; dialogs for auto-completion.
(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)

;; Keymap
;; C-c C-e m r => eclim-maven-run (Goal: install)
(define-key eclim-mode-map (kbd "C-c C-e r") 'eclim-run-class)

;; <<END>>

(setq c-auto-newline nil)
(setq c-brace-offset -2)
(setq c-continued-statement-offset 2)
(setq c-indent-level 2)
(setq c-tab-always-indent t)
(setq c-indent-comments-syntactically-p nil)


(defun my-c-mode-common-hook ()
  ;; use Ellemtel style for all C, C++, and Objective-C code
  (c-set-style "ellemtel")
  (c-set-offset 'inclass '+)
  (c-set-offset 'case-label 0)
  (c-set-offset 'statement-case-intro '+)
  (c-set-offset 'inline-open '0)
  (c-set-offset 'substatement '+)
  (c-set-offset 'comment-intro '0)
  
  (abbrev-mode 1)
  (setq dabbrev-case-replace nil)

  (setq c-tab-always-indent t
        c-basic-offset 2
        tab-width 2
        indent-tabs-mode nil
        c-double-slash-is-comments-p t
        )

  (imenu-add-to-menubar "Functions")
  (which-function-mode 1)
  (auto-revert-mode 1)

  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; http://www.emacswiki.org/emacs/IndentingJava
;; (add-hook 'java-mode-hook 'java-mode-indent-annotations-setup)

;; Scala
;; (setq additional-paths-scala '("/home/nipra/.emacs.d/scala"
;;                                "/home/nipra/.emacs.d/scala/scala-mode-new"))

;; (setq load-path (append additional-paths-scala load-path))

;; (require 'scala-mode-auto)


;;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;; http://kdstevens.com/~stevens/ispell-page.html
;;; http://www.emacswiki.org/emacs/InteractiveSpell
;; (require 'ispell)

;;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;;; SQL
(eval-after-load "sql"
  (load-library "sql-indent"))


;;; http://www.emacswiki.org/emacs/SmoothScrolling
;;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; http://www.emacswiki.org/emacs/TransparentEmacs
;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(85 50))
(add-to-list 'default-frame-alist '(alpha 85 50))

;; You can use the following snippet after you’ve set the alpha as above to assign a toggle to “C-c t”:

(eval-when-compile (require 'cl))
(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(85 50))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

;; A general transparency function:
;; Set transparency of emacs
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))

;; http://emacs-fu.blogspot.in/2009/02/transparent-emacs.html
(defun djcb-opacity-modify (&optional dec)
  "modify the transparency of the emacs frame; if DEC is t,
    decrease the transparency, otherwise increase it in 10%-steps"
  (let* ((alpha-or-nil (frame-parameter nil 'alpha)) ; nil before setting
         (oldalpha (if alpha-or-nil alpha-or-nil 100))
         (newalpha (if dec (- oldalpha 10) (+ oldalpha 10))))
    (when (and (>= newalpha frame-alpha-lower-limit) (<= newalpha 100))
      (modify-frame-parameters nil (list (cons 'alpha newalpha))))))

;; C-8 will increase opacity (== decrease transparency)
;; C-9 will decrease opacity (== increase transparency
;; C-0 will returns the state to normal
(global-set-key (kbd "C-8") '(lambda()(interactive)(djcb-opacity-modify)))
(global-set-key (kbd "C-9") '(lambda()(interactive)(djcb-opacity-modify t)))
(global-set-key (kbd "C-0") '(lambda()(interactive)
                               (modify-frame-parameters nil `((alpha . 100)))))

;; R
(require 'ess-site)

(require 'config-clj)
;; (require 'config-cl)
;; (require 'config-clj-new)

;; Pig
(require 'pig-mode)
