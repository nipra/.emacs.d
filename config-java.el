;; (setq additional-paths-java '("/home/nipra/.emacs.d"
;;                               "/home/nipra/.emacs.d/java"
;;                               "/home/nipra/.emacs.d/java/elib-1.0"
;;                               "/home/nipra/.emacs.d/java/jdee-2.4.0.1/lisp"))

;; (setq load-path (append additional-paths-java load-path))

;; ;; If you want Emacs to defer loading the JDE until you open a 
;; ;; Java file, edit the following line
;; (setq defer-loading-jde nil)
;; ;; to read:
;; ;;
;; ;;  (setq defer-loading-jde t)
;; ;;

;; (if defer-loading-jde
;;     (progn
;;       (autoload 'jde-mode "jde" "JDE mode." t)
;;       (setq auto-mode-alist
;;             (append
;;              '(("\\.java\\'" . jde-mode))
;;              auto-mode-alist)))
;;   (require 'jde))




;;;


(provide 'config-java)
