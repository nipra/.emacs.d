;;; w3m-bookmarks-lynx.el --- Add lynx-style multi-bookmarks and functionality
;; Copyright (C) 2007, 2008
;; Rediscover <discover@well.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.


;; add lynx-style multi-bookmarks (using the same ones lynx uses
;; or alternatives)
;;    and
;; add lynx-style A)dd D)ocument or L)ink and munging of
;; url Title to bookmark functions.
;;

;; This won't be useful unless You also have the wonderful emacs-w3m.
;; I'm mostly using version emacs-w3m-1.4.4 with this.
;; Find it at
;;    http://emacs-w3m.namazu.org/

;; This is NOT a direct replacement for w3m-bookmark.el,
;; because I am using a few routines from there.



;; If You want to use lynx-like multi bookmarks,
;; you need to (currently):
;;
;; 1) add (require 'w3m-multibookmarks)
;;      and
;; 2) add (setq w3m-multibookmarks-enable t)
;;      to your .emacs
;; Done.  Optional extra steps are:
;;
;; 3) specify the bookmark files using your .lynxrc
;;    file with the multibookmarks defined there
;;    (automagically handled, so do nothing if You
;;    want to use them)
;;      or
;;    some other file with similar format
;;    (see below)
;;      or
;;    include it as a list in your .emacs
;;    (see below)
;;
;; Commentary on the format in .lynxrc
;;  multi_bookmark Capital Letter equals path to file comma optional description
;; with no spaces prior to the comma.  Some examples are
;; multi_bookmarkC=.lynx_bookmarks/NeXTBootFloppyImages.html,NeXT Boot Floppies
;; multi_bookmarkD=.lynx_bookmarks/Linux-ports.html,Linux Ports
;; multi_bookmarkE=.lynx_bookmarks/emacspeak.html
;; one per line, starting at column 0, for each of the ones You
;; want defined (for A to Z).  The comma separates the optional comment.
;;
;; 3a) This gets parsed into w3m-multibookmarks-list by calling
;; the w3m-multibookmarks-file-list-autocreate-from-lynxrc function
;; Instead of that, You could add something like the following
;; to .emacs, thus skipping the need for reading that
;; other file):
;; (setq w3m-multibookmarks-list
;;   (("c"  "~/.lynx_bookmarks/NeXTBootFloppyImages.html" "NeXT Boot Floppies")
;;    ("d"  "~/.lynx_bookmarks/Linux-ports.html"   "Linux Ports")
;;    ("z"  "~/.lynx_bookmarks/fpga.html"  "fpga docs"))
;;    ("f"  "/coda/away.example.org/share/rdb/wearables.html"    "wearables"
;;    ("n"  "~/.mozilla/firefox/zSomeHugeString/bookmarks.html"  "mozilla")
;; The order doesn't matter.
;;
;; 4) Make certain the above files exist.  If You want to stay
;; with the lynx vaguely-defined format, put this at the
;; top of each file
;; <head>
;; <meta http-equiv="content-type" content="text/html;charset=iso-8859-1">
;; <title>Some title</title>
;; </head>
;; Your notes/scratchpad area/message about some helpful
;; lynx commands
;; <p>
;; <ol>
;;
;; Whatever.  You get the idea.
;; I prefer to omit the <ol> - You probably will too after
;; using it with emacs-w3m.
;; Originally I thought about added functions to initialize
;; the bookmark files, but I could not justify the mostly
;; unused code taking up space.
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;; Caveat emptor - I am assuming a UNIX-like file system,
;; this needs some hacking if You are not on such a
;; machine.  Yeah, I know elisp can automagically handle
;; that, but I have not touched VMS or MS-DOS in ages.
;; Search for `replace-regexp-in-string' for where to put
;; those hacks.  And please send them to me.
;;
;; other notes
;; * sometimes I write mbVAR instead of just VAR
;; * I assume that all writes to the specific bookmark file
;;     are done without regards to someone else holding
;;     the file open or locked.
;; * I need to clean up the variables, eg using let more
;;     often to save garbage collection
;; * this does not handle moving `B'ack through different
;;     bookmark files correctly (yet)
;; * w3m-safe-string should probably get exercised more
;;     and if I put that in there will need to be some
;;     way to override it
;;
;; not the best code...
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; FIXME - should the eval-when-compile get rm'd?
(eval-when-compile (require 'cl))
(require 'w3m-util)
(require 'w3m)
;; (require 'easymenu)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; I'm not really a fan of customize, so those parts may not be too great
;; or even usable.

(defgroup w3m-multibookmarks nil
  "w3m-multibookmarks - Lynx-like multiple bookmark files."
  :group 'w3m
  :prefix "w3m-multibookmarks-")


(defcustom w3m-multibookmarks-enable nil
  "Enable multibookmarks?"
  :type 'boolean
  :group 'w3m-multibookmarks)


(defcustom w3m-lynxrcfile
  nil
  "Alternate file to grep for multi_bookmark listings.
Use this when You don't want ~/.lynxrc as the base
for finding the listings - eg, when using emacspeak
having the least-accessed ones near the top seems
better - or, on bogged-down machines, having the most
accessed near the top would save a few cycles (but I
doubt I'd notice).
Preferred format, do this for which-ever of A-Z, like so:
multi_bookmarkC=.lynx_bookmarks/NeXTBootFloppyImages.html,NeXT Boot Floppies
multi_bookmarkD=.lynx_bookmarks/Linux-ports.html,Linux Ports
which gets parsed into w3m-multibookmarks-list.
More documentation in the source `w3m-multibookmarks.el' for this."
  ;;  Format of w3m-multibookmarks-list for the above example is
  ;; (("c" "~/.lynx_bookmarks/NeXTBootFloppyImages.html" "NeXT Boot Floppies")
  ;;  ("d" "~/.lynx_bookmarks/Linux-ports.html" "Linux Ports"))
  :group 'w3m-multibookmarks
  :type '(file :size 0))


;; (defcustom w3m-multibookmarks-dir
;; skip - I just realized mine are NOT all in the same directory
;; so having something like this does NOT work for me


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun w3m-multibookmarks-keymap ()
  "Re-map the `a' `M-a' and `v' - this gets called
via a w3m-mode-hook."
  (define-key w3m-mode-map [remap w3m-bookmark-add-this-url]
    'w3m-multibookmarks-add-this-url)
  (define-key w3m-mode-map [remap w3m-bookmark-add-current-url]
    'w3m-multibookmarks-add-some-url)
  (define-key w3m-mode-map [remap w3m-bookmark-view]
    'w3m-multibookmarks-view))

;; FIXME - question to other elisp hackers - which is the preferred
;; way to re-map the keybindings?
;; (add-hook 'foo-mode-hook '(lambda () (define-key map "\C-x" 'new-function)))
;;     or
;; (define-key map [remap func-foo] 'new-func-foo)
;;     or
;; (substitute-key-definition 'func-foo 'new-func-foo (map))




(defun w3m-multibookmarks-show-all ()
  "Display the bookmarks and their keys."
  (save-excursion
    (with-output-to-temp-buffer "w3m-multibookmarks-buf"
      (w3m-multibookmarks-pretty-dump w3m-multibookmarks-list))))
;; (shrink-window-if-larger-than-buffer "w3m-multibookmarks-buf")
;; sort-lines nil mark point



(defun w3m-multibookmarks-pretty-dump (mbbookmarks)
  "Return a pretty multibookmarks listing."
  (cond
   ((null mbbookmarks) nil)
   (t (princ (format "   %s : %-24s (%s)\n"
		     (nth 0 (car mbbookmarks))
		     (nth 2 (car mbbookmarks))
		     (nth 1 (car mbbookmarks))))
      (w3m-multibookmarks-pretty-dump (cdr mbbookmarks)))))
;; this should still do the sort-lines nil (point-min) (point-max)
;; but then we have the problem of this going into a help buffer
;; that is ro - we cannot do this earlier (what if I'm saving
;; cycles by putting my most used marks near one end of the
;; list?)



;; w3m-multibookmarks-display
;;;###autoload
(defun w3m-multibookmarks-view (&optional new-session)
  "Ask the user which bookmarks file is wanted and then
call w3m-bookmark-buffer to show it.  Optional ARG to open
in a new buffer."
  (interactive "P")
  (setq w3m-bookmark-file (expand-file-name
			   (format "%s" (car (w3m-multibookmarks-select)))))
  (w3m-browse-url w3m-bookmark-file new-session))
;; simple but missing the reload et al - okay, the reload is there,
;; but should it probably check the date stamp to decide to reload
;; it?  No, not unless you're gonna keep the date stamp down to mS,
;; because I'm pretty certain I can push 3 or so new additions into
;; a bookmark file in a second if needs be.



;; maybe that should be read-char-exclusive below
(defun w3m-multibookmarks-select ()
  "Process single-key user input, return the list
of (bookmark-file comment) while dealing with a
request to see possible choices (the `=' key)."
  (let ((myselect
	 (read-quoted-char
	  "Select subbookmark, `=' for menu, or ^G to cancel: ")))
    (cond
     ;; early quit C-g
     ((eq 7 myselect) nil)
     ;; list of bookmarks files requested, test for = key
     ((eq 61 myselect)
      (progn
	(save-excursion
	  (setq w3m-prev-frame-config (current-frame-configuration))
	  (with-output-to-temp-buffer "*w3m-bookmarks-list*"
	    (w3m-multibookmarks-pretty-dump w3m-multibookmarks-list))
	  ;; temp-buffer is ro (sort-lines nil (point-min) (point-max))
	  (setq mbcrud (w3m-multibookmarks-select))
	  (set-frame-configuration w3m-prev-frame-config t)
	  mbcrud)))
     ((setq w3m-multibookmarks-file
	    (w3m-multibookmarks-lookup (char-to-string myselect)
				       w3m-multibookmarks-list))
      w3m-multibookmarks-file)
     ;;  what was I thinking - I'm pretty certain that variable gets returned
     (t (w3m-multibookmarks-select)))))



(defun w3m-multibookmarks-lookup (mbkey mbbookmarks)
  "Return a multibookmark name-description for a matching key."
  (cond
   ((null (car (car mbbookmarks))) nil)
   ((equal mbkey (car (car mbbookmarks)))
    (cdr (car mbbookmarks)))
   (t (w3m-multibookmarks-lookup mbkey (cdr mbbookmarks)))))



(defun w3m-multibookmarks-add (mburl &optional mbtitle)
  "Optional argument mbTITLE is title of link or if
not specified it defaults to the url.
Warning: bookmark file is assumed to exist - create
one with lynx(1) if it does not.  Or read the source
of `w3m-multibookmarks.el' - suggested formats to
manually make one are covered in the comments."
  (if (setq w3m-multibookmarks-file (car (w3m-multibookmarks-select)))
      (progn
	(if (null mbtitle) (setq mbtitle mburl))
	(write-region
	 (concat
	  "<LI><a href=\"" mburl "\">"
	  (w3m-encode-specials-string
	   (read-from-minibuffer "Title: " mbtitle))
	  "</a>\n")
	 nil w3m-multibookmarks-file t)
	(message "Appended"))
    (message "Aborted")))
;; error or message?   something like that



;;; replaces w3m-bookmark-add-this-url ()
;;;          w3m-bookmark-add-current-url (&optional arg)
;;;###autoload
(defun w3m-multibookmarks-add-some-url (&optional arg)
  "Add link-under-cursor or current page to bookmarks.
With prefix, ask new url to add instead of current page -
`add-this-url' can still be called directly (usually M-a).
This is the user-interactive entry to w3m-multibookmarks-add."
  (interactive "P")
  (cond
   ((not (null arg)) (w3m-multibookmarks-add (w3m-input-url)))
   ((null (w3m-anchor))
    (let ((myselect (read-quoted-char
		     "Save D)ocument to bookmark file or C)ancel? (d,c): ")))
      (if (eq 100 myselect)
	  (w3m-multibookmarks-add w3m-current-url w3m-current-title)
	(message "Aborted"))))
   ;;  FIXME? was there a reason I used a let statement for the read-char?
   (t (let ((myselect (read-quoted-char
		       "save D)ocument or L)ink to bookmark file or C)ancel? (d,l,c): ")))
	(cond
	 ((eq 108 myselect) (w3m-multibookmarks-add-this-url)) ;; add-link
	 ((eq 100 myselect)
	  (w3m-multibookmarks-add w3m-current-url w3m-current-title))
	 (t (message "Aborted")))))))
;; okay, so I lie about the _c_ancel option - if ya do not match
;; d or l we just drop through



;; w3m-multibookmarks-add-link
;;;###autoload
(defun w3m-multibookmarks-add-this-url ()
  "Add a bookmark for current link.  Separated in the
code to honor pressing  M-a."
  (interactive)
  (if (null (w3m-anchor))
      (message "Not on a link.")
    (let ((url (w3m-anchor))
	       (title (buffer-substring-no-properties
		       (previous-single-property-change
			(1+ (point)) 'w3m-href-anchor)
		       (next-single-property-change
			(point) 'w3m-href-anchor))))
	  (w3m-multibookmarks-add url title))))



(defun w3m-multibookmarks-file-list-autocreate-from-lynxrc (&optional w3m-lynxrcfile)
  "Attempt to read ~/.lynxrc and parse the multi_bookmarks
from there, with a bit of UNIX-oriented sanitizing."
  (setq w3m-multibookmarks-list)
  (if (not w3m-lynxrcfile) (setq w3m-lynxrcfile "~/.lynxrc"))
  (if (not (file-readable-p w3m-lynxrcfile))
      (message "Abort: could not read lynxrc file %s" w3m-lynxrcfile)
    (progn ;; probably not necessary for a progn here in an else
      (with-temp-buffer
	(insert (concat "a "
			(replace-regexp-in-string
			 "^bookmark_file=" ""
			 (replace-regexp-in-string
			  "\n" ""
 			  (shell-command-to-string
			   (concat "grep ^bookmark_file " w3m-lynxrcfile))))
			" default\n"))
	;; need to either remove that default\n or insert it after
	;; the bookmark-file-name and before the \n
	(insert
	 (replace-regexp-in-string
	  "," " "
	  (replace-regexp-in-string
	   "=" " "
	   (replace-regexp-in-string
	    "^multi_bookmark" ""
	    (shell-command-to-string "grep ^multi_book ~/.lynxrc")))))
	(w3m-multibookmarks-file-list-sanitize)))))



(defun w3m-multibookmarks-file-list-sanitize ()
  "Clean-up buffer of lynx-style multi-bookmarks file listings
preparing to save into the variable w3m-bookmarks-list."
  (save-excursion
    (goto-char (point-min))
    ;; lynxrc often has ./myfile instead of ~/myfile
    ;;
    ;;  98 percent rule
    (while (re-search-forward "^[A-Z][ ][.]/" nil t)
      (progn (goto-char (- (point) 2))
	     (delete-char 1 nil)
	     (insert "~")))
    (goto-char (point-min))
    (while (re-search-forward "^[A-Z][ ][.][[:alnum:]]" nil t)
      (progn (goto-char (- (point) 2))
	     (insert "~/")))
    (goto-char (point-min))
    (w3m-multibookmarks-file-list-make)))



(defun w3m-multibookmarks-file-list-make ()
  "Recurse through buffer holding .lynxrc while attempting to select
correct values for ((key  bookmark-filename  optional-comments))."
  (cond
   ((eobp) t)
   ((looking-at "[A-Z][ ][~]?/[.]?[a-z]*[-[:alnum:]/.\\_]*[ ][-[:alnum:]]*")
    (progn (add-to-list 'w3m-multibookmarks-list
			(list (downcase (format "%s" (read (current-buffer))))
			      (format "%s" (read (current-buffer)))
			      (replace-regexp-in-string
			       "[ \t]*$" ""
			       (buffer-substring (1+ (point)) (progn (end-of-line) (point)))))
			t)
	   (w3m-multibookmarks-file-list-make)))
   ((looking-at "[A-Z][ ][~]?/[.]?[a-z]*[-[:alnum:]/.\\_]*")
    (progn (add-to-list 'w3m-multibookmarks-list
			(list (downcase (format "%s" (read (current-buffer))))
			      (format "%s" (read (current-buffer)))))
	   (w3m-multibookmarks-file-list-make)))
   (t (progn (beginning-of-line) (forward-line 1) (w3m-multibookmarks-file-list-make)))))

(add-hook 'w3m-mode-hook
	  (lambda ()
	    (when w3m-multibookmarks-enable
	      (w3m-multibookmarks-keymap)
	      (defvar w3m-multibookmarks-list nil)
	      (unless w3m-multibookmarks-list
		(w3m-multibookmarks-file-list-autocreate-from-lynxrc w3m-lynxrcfile)))))




;; emacspeak needing help
;; (featurep 'emacspeak-w3m
;; (defadvice w3m-bookmark-add-current-url (after emacspeak pre act comp)
;;   "Produce auditory icon."
;;   (when (interactive-p)
;;     (emacspeak-auditory-icon 'save-object)))
;;
;; (defadvice w3m-bookmark-add-this-url (after emacspeak pre act comp)
;;   "Produce auditory icon."
;;   (when (interactive-p)
;;     (emacspeak-auditory-icon 'save-object)))
;;
;;
;; (defadvice w3m-bookmark-view (around emacspeak pre act)
;;   "Speech-enable W3M."
;;   (cond
;;    ((interactive-p)
;;     (emacspeak-auditory-icon 'select-object)
;;     (let ((emacspeak-speak-messages nil))
;;       ad-do-it))
;;    (t ad-do-it))ad-return-value)
;;

(provide 'w3m-multibookmarks)

;;; w3m-multibookmarks.el ends here
