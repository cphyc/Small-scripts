;;; .emacs -- Summary
;;; Commentary:
; the following code is an agregate of many snippets mostly from
; emacswiki.org.
; Please contact contact@cphyc.me for any question

;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t t)
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 ;; '(TeX-view-program-list (quote (("Okular" "okular --unique %o#src:%n%b"))))
 ;; '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "Okular") (output-html "xdg-open"))))
 ;; '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(cua-enable-cua-keys nil)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (whiteboard)))
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(inhibit-startup-screen t)
 '(org-CUA-compatible nil)
 '(org-agenda-files nil)
 '(recentf-mode t)
 '(safe-local-variable-values (quote ((require-final-newline . t))))
 '(send-mail-function (quote smtpmail-send-it))
 '(shift-select-mode nil)
 '(show-paren-mode t)
 '(smtpmail-smtp-server "clipper.ens.fr")
 '(smtpmail-smtp-service 465)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(uniquify-buffer-name-style (quote forward)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;{{{ Launches a server for faster file opening }-{
(require 'server)
(unless (server-running-p)
  (server-start))
;;}}}

;;{{{ Load semantic and ede mode }-{
(semantic-mode 1)
(global-ede-mode 1)
(speedbar 1)


;;{{{ Assign f keys to compile }-{
(global-set-key [f5] 'compile)
(global-set-key [f6] 'recompile)
(global-set-key [f7] 'next-error)
;}}} 

;;{{{ Find lisps files within ~/.emacs.d/ and its subdirectories }-{
(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))
;}}} 


;;;{{{ OCaml Mode
;; make OCaml-generated files invisible to filename completion}-{
(setq auto-mode-alist (cons '("\\.ml[iylp]?\\'" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'ocamldebug "ocamldebug" "Run the Caml debugger t" t)

(mapc #'(lambda (ext) (add-to-list 'completion-ignored-extensions ext))
  '(".cmo" ".cmx" ".cma" ".cmxa" ".cmi" ".cmxs" ".cmt" ".annot"))
;}}}

;;{{{ Default speller }-{
(setq-default ispell-program-name "aspell")
;}}} 

;;; Latex configuration
; Unicode
(setq ac-math-unicode-in-math-p t)
;; Auctex
(load "auctex.el" nil t t)
;;{{{ Set default output to PDF }-{
(setq TeX-PDF-mode t)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
;}}} {{{ Set default viewer to okular }-{
'(LaTeX-command "latex -synctex=1")
'(TeX-output-view-style '(("^pdf$" "." "okular %s.pdf")))
;}}}{{{ Automatically guess LaTeX master file }-{
;; (setq TeX-master (guess-TeX-master (buffer-file-name)))

;; (defun guess-TeX-master (filename)
;;   "Guess the master file for FILENAME from currently open .tex files."
;;   (let ((candidate nil)
;; 	(filename (file-name-nondirectory filename)))
;;     (save-excursion
;;       (dolist (buffer (buffer-list))
;; 	(with-current-buffer buffer
;; 	  (let ((name (buffer-name))
;; 		(file buffer-file-name))
;; 	    (if (and file (string-match "\\.tex$" file))
;; 		(progn
;; 		  (goto-char (point-min))
;; 		  (if (re-search-forward (concat "\\\\input{" filename "}") nil t)
;; 		      (setq candidate file))
;; 		  (if (re-search-forward (concat "\\\\include{" (file-name-sans-extension filename) "}") nil t)
;; 		      (setq candidate file))))))))
;;     (if candidate
;; 	(message "TeX master document: %s" (file-name-nondirectory candidate)))
;;     candidate))
;}}}

;;{{{ What is that ?}-{
(defun ac-latex-mode-setup ()
  (setq ac-sources
	(append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
		ac-sources)))
;}}}{{{ And that? }-{
(add-hook 'latex-mode-hook 'ac-latex-mode-setup)
;}}}{{{ what about this ? }-{
(setq reftex-plug-into-AUCTeX t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)

(setq reftex-plug-into-AUCTeX t)
;}}}{{{ Use predictive to predict input }-{
(require 'predictive)
(autoload 'predictive-mode "predictive" "predictive" t)
(set-default 'predictive-auto-add-to-dict t)
(setq predictive-main-dict 'rpg-dictionary
      predictive-auto-learn t
      predictive-add-to-dict-ask nil
      predictive-use-auto-learn-cache nil
      predictive-which-dict t)
;;}}} 

;;{{{Code to support MESA (commented out) }-{
;; (autoload 'mesa-minor-mode "mesa minor mode")
;; (setq auto-mode-alist  (cons '("/inlist[^/]*$" . (lambda () (f90-mode) (mesa-minor-mode))) auto-mode-alist))
;; (setq auto-mode-alist  (cons '("\\.defaults\\'" . (lambda () (f90-mode) (view-mode))) auto-mode-alist))
;; (setq auto-mode-alist  (cons '("\\.list\\'" . (lambda () (f90-mode) (view-mode))) auto-mode-alist))
;; (put 'downcase-region 'disabled nil)
;; (put 'scroll-left 'disabled nil)
;}}}

;; web-mode
(add-to-list 'load-path "/usr/share/emacs/site-lisp/web-mode")

;;{{{Autosaves into ~/.emacs.d/saves in place of the current directory}-{
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs.d/saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)
;}}}

;;{{{ Recent files saved.
;    TODO: work out a way to make it work with ido }-{
(autoload 'recentf "recentf")
(setq recentf-max-saved-items 200
      recentf-max-menu-items 15)
(recentf-mode +1)
;}}}

;;{{{ Maps C-Tab and C-S-T to next/prev. window}-{
(defun frame-bck()
  (interactive)
  (other-window -1))
(define-key (current-global-map) (kbd "C-<tab>") 'other-window)
(define-key (current-global-map) (kbd "<C-S-iso-lefttab>") 'frame-bck)
(put 'upcase-region 'disabled nil)
;}}}


;;{{{ gnuplot mode, mostly useless :)}-{
;; (autoload 'gnuplot-mode "gnuplot mode")
;; (setq gnuplot-program "/usr/bin/gnuplot")
;; (setq auto-mode-alist 
;; (append '(("\\.\\(gp\\|gnuplot\\)$" . gnuplot-mode)) auto-mode-alist))
;}}}


;; python
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)
;(add-to-list 'company-backends 'company-anaconda)

;;{{{ 'Quickly' parse the local folder to look for .h, .hpp, .cpp, .hpp }-{
(defadvice find-tag (before c-tag-file activate)
  "Automatically create tags file."
  (let ((tag-file (concat default-directory "TAGS")))
    (unless (file-exists-p tag-file)
      (shell-command "etags *.[ch]{pp,} -o TAGS 2>/dev/null"))
    (visit-tags-table tag-file)))
;}}}


;;org mode
(autoload 'org-install "org install")
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(autoload 'org-caldav "org caldav")
(setq org-caldav-url "https://nuage.cphyc.me/remote.php/caldav/calendars/cphyc")
(setq org-caldav-calendar-id "defaultcalendar")
(setq org-caldav-inbox "~/org/org-mode-calendar.org")
(setq org-caldav-inbox "~/org/org-mode-calendar.org")

;; Load langages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)))
(autoload 'ob-C "")
(autoload 'ob-dot "ob-dot")
(autoload 'ob-gnuplot "ob-gnuplot")
(autoload 'ob-screen "ob-screen")
(autoload 'ob-sh "ob-sh")
(autoload 'ob-python "ob-python")
(autoload 'ob-org "ob-org")
(autoload 'ob-ocaml "ob-ocaml")
(autoload 'ob-latex "ob-latex")
(setq org-ditaa-jar-path "/usr/bin/ditaa")

;; C
(autoload 'cc-mode "cc mode")
(autoload 'csharp-mode "csharp-mode" "Major mode for editing Csharp mode;" t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

(require 'compile)
; I have no idea what this is
(push '("^\\(.*\\)(\\([0-9]+\\),\\([0-9]+\\)): error" 1 2 3 2)
      compilation-error-regexp-alist)
(push '("^\\(.*\\)(\\([0-9]+\\),\\([0-9]+\\)): warning" 1 2 3 1)
      compilation-error-regexp-alist)

;; (push '(csharp-mode
;; 	"\\(^\\s *#\\s *region\\b\\)\\|{"
;; 	"\\(^\\s *#\\s *endregion\\b\\)\\|}"
;; 	"/[*/]"
;; 	nil
;; 	hs-c-like-adjust-block-beginning)
;;       hs-special-modes-alist)

(with-no-warnings
  (autoload 'cl "cl"))
(autoload 'files "files")
(autoload 'ido "ido")
(autoload 'thingatpt "thingatpt")
(autoload 'dash "dash")
(autoload 'compile "compile")
(autoload 'dired "dired")
(autoload 'popup "popup")
(autoload 'etags "etags")

(defgroup omnisharp ()
  "Omnisharp-emacs is a port of the awesome OmniSharp server to
the Emacs text editor. It provides IDE-like features for editing
files in Csharp solutions in Emacs, provided by an OmniSharp server
instance that works in the background."
  :group 'external
  :group 'csharp)
(add-hook 'csharp-mode-hook 'omnisharp-emacs)
(setq omnisharp-server-executable-path "~/.bin/OmniSharpServer.sh")

;; MELPA
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives 
	     '("marmalade" . "http://marmalade-repo.org/packages/"))

;;{{{ Interactively Do Things -- major mode for nice completion}-{
(autoload 'ido "ido")
(ido-mode t)
(global-set-key
 "\M-x"
 (lambda ()
   (interactive)
   (call-interactively
    (intern
     (ido-completing-read
      "M-x "
      (all-completions "" obarray 'commandp))))))

(defun my-ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapatoms (lambda (x)
		(push (prin1-to-string x t) tag-names))
	      tags-completion-table)
    (find-tag (ido-completing-read "Tag: " tag-names))))

(defvar ido-enable-replace-completing-read t
  "If t, use ido-completing-read instead of completing-read if possible.
    
    Set it to nil using let in around-advice for functions where the
    original completing-read is required.  For example, if a function
    foo absolutely must use the original completing-read, define some
    advice like this:
    
    (defadvice foo (around original-completing-read-only activate)
      (let (ido-enable-replace-completing-read) ad-do-it))")
;}}}
(add-hook 'after-init-hook 'global-company-mode)

;; Replace completing-read wherever possible, unless directed otherwise
(defadvice completing-read
  (around use-ido-when-possible activate)
  (if (or (not ido-enable-replace-completing-read) ; Manual override disable ido
	  (and (boundp 'ido-cur-list)
	       ido-cur-list)) ; Avoid infinite loop from ido calling this
      ad-do-it
    (let ((allcomp (all-completions "" collection predicate)))
      (if allcomp
	  (setq ad-return-value
		(ido-completing-read prompt
				     allcomp
				     nil require-match initial-input hist def))
	ad-do-it))))

;;{{{ flycheck}-{
(add-hook 'after-init-hook 'global-flycheck-mode)
;}}}
;;{{{ Very nice mode that compiles on the go the file and underline the errors
;    while you write them !}-{
(autoload 'flymake "flymake")
;}}}


;;; Lisp programming
(require 'slime-autoloads)
(setq inferior-lisp-program "clisp")
(setq slime-contribs '(slime-fancy))
(global-set-key "\C-cs" 'slime-selector)

;;; topcoder
(autoload 'topcoder-set-problem "~/.emacs.d/topcoder/topcoder.el")

;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")


;;{{{ Some customization:
; automatically complete opening brackets
; show line number
; don't highlight current line}-{
(electric-pair-mode 1)
(global-linum-mode 1)
(global-hl-line-mode 0)
;}}}{{{ Reset the opening/closing quote for emacs (located here to
; prevent the electric quotes) }-{
(setq TeX-open-quote "``")
(setq TeX-close-quote "''")
;}}}{{{ Customize scroll }-{
(defun scroll-up-2-lines ()
  "Scroll up 2 lines"
  (interactive)
  (scroll-up 2))

(defun scroll-down-2-lines ()
  "Scroll down 2 lines"
  (interactive)
  (scroll-down 2))

(global-set-key (kbd "<mouse-4>") 'scroll-down-2-lines) ;
(global-set-key (kbd "<mouse-5>") 'scroll-up-2-lines) ;
;}}}{{{ Map C-c i to imenu to quickly find item in source code 
;; Map C-c o to find next occurence}-{
(global-set-key (kbd "C-,") 'ido-imenu-anywhere)
(global-set-key (kbd "C-c i") 'imenu)
(global-set-key (kbd "C-c o") 'multi-occur)
(eval-when-compile
  (require 'cl))

(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
   (dolist (buf (buffer-list))
     (with-current-buffer buf
       (if (eq mode major-mode)
           (add-to-list 'buffer-mode-matches buf))))
   buffer-mode-matches))

(defun multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (car (occur-read-primary-args))))

;; global key for `multi-occur-in-this-mode'
(global-set-key (kbd "M-s o") 'multi-occur-in-this-mode)
(global-set-key (kbd "M-s n") 'next-match)
;; this is ridiculous, I need to use "previous-error" for previous occurence …
(global-set-key (kbd "M-s p") 'previous-error)
;}}}

;;{{{ Fold and unfold with C-c , , (requires hs-minor-mode activated))}-{
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'python-mode-hook     'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(global-set-key (kbd "C-c , ,") 'hs-toggle-hiding)
;}}}{{{ Simply emacs' most usefull mode : create snippets and insert them
; very easily using TAB and a keyword}-{
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ))
(yas-global-mode 1)
(setq yas/triggers-in-field t) ; triggers expansion in nested snippets
;}}}
;;{{{ Provide a command to show the equivalent of the Unix command 'tree'}-{
(require 'dirtree)
;}}}

;;{{{ Markdown support for syntax highlighting }-{
(autoload 'markdown-mode "markdown-mode")
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)) ;}}}
; {{{ Tabbar mode activated!}-{
(require 'tabbar)
(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)
;}}}

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "ctags -e -R %s" (directory-file-name dir-name)))
  )

(provide '.emacs)
;;; .emacs end here
