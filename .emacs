;; EMACS-WIDE SETUP

;; run this file with M-x eval-buffer
;; no dumb startup message
;; (setq inhibit-startup-message t)
;; define home
(defvar home (getenv "HOME"))
;; emacs will always look for files here
(add-to-list 'load-path (concat (expand-file-name (getenv "HOME")) "/emacs/"))
(setq warning-suppress-types nil)
(defconst use-backup-dir t)

;; Interlock symlinks are bad for dropbox when they remain on the
;; disk. Goodbye interlock symlinks.
(setq create-lockfiles nil)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; this is where we install packages from
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;; uncompress files on the fly so you can transparently edit compressed files
(auto-compression-mode 1)

;;;;;;;;;;; GENERAL STYLING AND FILE FORMATTING

;; automatically wrap around after 80 characters
(setq-default fill-column 80)

;; Enable Ido. It allows for emacs to do on the fly completion for opening files/navigating
;; can be customized more, see https://www.masteringemacs.org/article/introduction-to-ido-mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
;; set the order in which it presents the buffers. Always show python first.
(setq ido-file-extensions-order '(".py"))
;; when switching buffers (with C-x b), don't show the weird buffers such as *Messages* or *buffer*
(setq ido-ignore-buffers '(".*\*.*\*"))


;; make it so when you highlight a section, you can just hit delete or type and you will replace the region
(delete-selection-mode 1)

;; always use linum-mode. Always show line numbers on the side
;; (when (version<= "26.0.50" emacs-version )
;;   (global-display-line-numbers-mode))

;; (defun my-python-mode-hook () 
;;   (linum-mode 1)) 
;; (add-hook 'python-mode-hook 'my-python-mode-hook) 

;; PYTHON CONFIGS

;; install Jedi for smart code completion, import assist, showing method signatures
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)  


;; ;; CONDA RELATED THINGS
;; ;; M-x conda activate
;; ;; M-x conda deactivate
;; ;; M-x conda-env-activate-for-buffer to autodetect the right conda env to use
;; ;; use conda-env-autoactivate-mode minor mode auto-activate conda always


;; ;; define path so emacs can find conda
;; ;; WARNING! Change this for every machine.
;; (custom-set-variables
;;  '(conda-anaconda-home "/Users/julianalverio/code/conda/"))
;; ;; (custom-set-variables
;; ;;  '(conda-env-home-directory "/Users/julianalverio/code/conda"))

;; ;; (setq conda-env-home-directory  "/Users/julianalverio/code/conda/envs")

;; (require 'conda)
;; ;; if you want interactive shell support, include:
;; (conda-env-initialize-interactive-shells)
;; ;; if you want eshell support, include:
;; ;; (conda-env-initialize-eshell)
;; ;; if you want auto-activation (see below for details), include:
;; (conda-env-autoactivate-mode t)

;; PYTHON STUFF

;; on-the-fly syntax check for python
;; a hook is a set of functions the get executed upon a certain event. When python-mode starts, flycheck-mode starts
(require 'flycheck)
(add-hook 'python-mode-hook 'flycheck-mode)

;; block commenting in python
;; (defun comment-or-uncomment-line-or-region ()
;;   "comment-or-uncomment-line-or-region"
;;   (interactive)
;; (save-excursion (if (region-active-p) (comment-dwim nil)
;;   (select-current-line) (comment-dwim nil)
;;   )))


;; provides standard highlighting behavior from other text editors
;; (transient-mark-mode 1)

;; highlight the current line
;; (defun select-current-line ()
;;   "Select the current line"
;;   (interactive)
;;   (end-of-line) ; move to end of line
;;   (set-mark (line-beginning-position)))

;; 
;; (defun comment-or-uncomment-line-or-region ()
;;   "comment-or-uncomment-line-or-region"
;;   (interactive)
;;   (save-excursion (if (region-active-p) (comment-dwim nil)
;;   (select-current-line) (comment-dwim nil)
;;   )))


;; (eval-after-load "python"
;;   '(define-key python-mode-map (kbd "C-;") #'comment-or-uncomment-line-or-region))
;; (eval-after-load "python"
;; '(define-key python-mode-map (kbd "M-;") #'comment-or-uncomment-line-or-region))



(defun smart-comment ()
    (interactive)
    (let (beg end)
      (if (region-active-p)
	  (setq beg (save-excursion (goto-char (region-beginning)) (line-beginning-position)) end (save-excursion (goto-char (region-end)) (line-end-position)))
	  (setq beg (line-beginning-position) end (line-end-position)))
      ;; (setq end (save-excursion (goto-char (region-end)) (line-end-position)))
      
      (comment-or-uncomment-region beg end))) 
(eval-after-load "python"
  '(define-key python-mode-map (kbd "C-;") 'smart-comment))
(eval-after-load "python"
  '(define-key python-mode-map (kbd "M-;") 'smart-comment))

(defun smart-kill ()
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
        (setq beg 0 end 0))
    (if (region-active-p)
        (kill-region beg end)
        (kill-line))))

;; (defun smart-kill ()
;;   (interactive)
;;   (let (beg end)
;;     (setq beg (region-beginning) end (region-end))
;;     (if (region-active-p)
;; 	(kill-region beg end)
;;       (kill-line))))

;; (defun current-line-empty-p ()
;;   (string-match-p "\\`\\s-*$" (thing-at-point 'line)))

;; (defun smart-kill-region-or-blank-lines (beg end &optional region)
;;   (interactive)
;;   (if (current-line-empty-p)
;;       (delete-blank-lines)
;;       (kill-region(beg end region))))
	  
       
(global-set-key (kbd "C-k") 'smart-kill)
(global-set-key (kbd "M-k") 'smart-kill)
(global-set-key (kbd "C-t") 'window-swap-states)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-j") 'keyboard-quit)
(global-set-key (kbd "C-g") 'goto-line)
(global-set-key (kbd "M-j") 'keyboard-quit)

(global-set-key (kbd "C-DEL") 'kill-word)
(global-set-key (kbd "M-DEL") 'kill-word)
(global-set-key (kbd "C-z") 'nil)
(global-set-key (kbd "C-x f") 'ido-find-file)
(global-set-key (kbd "C-x s") 'save-buffer)
(global-set-key (kbd "C-x C-k") 'ido-kill-buffer)

(global-set-key (kbd "C-M-h") 'backward-kill-word)
(eval-after-load "python"
  '(define-key python-mode-map (kbd "M-m") 'python-mark-defun))
(global-set-key (kbd "C-x C-o") 'other-window)
(global-set-key (kbd "C-w") 'kill-ring-save)
(global-set-key (kbd "C-x C-d") 'ido-dired)

(global-set-key (kbd "C-b") 'backward-char)

(define-key minibuffer-local-map (kbd "C-j") 'minibuffer-keyboard-quit)
(define-key minibuffer-local-map (kbd "C-g") 'nil)
(define-key minibuffer-local-map (kbd "M-s") 'save-buffer)

;; always refresh buffer when file has changed on disk
(global-auto-revert-mode t)

;; ssh mode is faster than scp for tramp
(setq tramp-default-method "ssh")



				
















(require 'flyspell)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(conda-anaconda-home "/Users/julianalverio/code/conda/")
 '(conda-env-home-directory "/Users/julianalverio/code/conda")
 '(package-selected-packages
   (quote
    (tramp-term tramp buffer-move pylint jedi anaconda-mode highlight-symbol flx flx-ido projectile auctex company-anaconda auto-complete bash-completion color-theme anaconda-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )





;; SHELL CUSTOMIZATION
;; make it so you can't delete your shell prompt
(setq comint-prompt-read-only t)

