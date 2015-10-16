(add-to-list 'load-path "~/.emacs.d/sammy/")
(require 'python-mode)
(require 'pycomplete)
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))
(add-to-list 'load-path "~/.emacs.d/elpa/ecb-20140215.114")

;;;;;;;;;;;;;;;;;;;; begin yasnippet ;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0/")
(require 'yasnippet)
(setq yas/prompt-functions 
   '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt   
    yas/ido-prompt yas/no-prompt))
(yas/global-mode 1)
(yas/minor-mode-on)
;;;;;;;;;;;;;;;;;;;; end yasnippet ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;; begin elpy ;;;;;;;;;;;;;;;;;;;;;;;
(package-initialize)
(elpy-enable)
;;;;;;;;;;;;;;;;;;;;;;;;; end elpy ;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ecb)
(setq ecb-auto-activate t ecb-tip-of-the-day nil)
(setq auto-mode-alist

 (cons '("//.py$" . python-mode) auto-mode-alist))

(setq interpreter-mode-alist

 (cons '("python" . python-mode)

 interpreter-mode-alist))

(autoload 'python-mode "python-mode" "Python editing mode." t)

;;; add these lines if you like color-based syntax highlighting

(global-font-lock-mode t)

(setq font-lock-maximum-decoration t)

(set-language-environment 'Chinese-GB)

(set-keyboard-coding-system 'euc-cn)

(set-clipboard-coding-system 'euc-cn)

(set-terminal-coding-system 'euc-cn)

(set-buffer-file-coding-system 'euc-cn)

(set-selection-coding-system 'euc-cn)

(modify-coding-system-alist 'process "*" 'euc-cn)

(setq default-process-coding-system 

 '(euc-cn . euc-cn))

(setq-default pathname-coding-system 'euc-cn)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;;;;;;;;;;;;;;;;;;;;;;; begin python ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
( require 'python )
;; use ipython 
(setq python-command "ipython") 
(setq 
      python-shell-interpreter "ipython" 
      python-shell-interpreter-args "" 
      python-shell-prompt-regexp "In \\[[0-9]+\\]: " 
      python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: " 
      python-shell-completion-setup-code "from IPython.core.completerlib import module_completion" 
      python-shell-completion-string-code "‘;‘.join(__IP.complete(‘‘‘%s‘‘‘p))\n" 
      python-shell-completion-module-string-code "" ) 
( add-hook 'python-mode-hook
    ( lambda ()
        ( set-variable 'indent-tabs-mode nil )
      ( define-key python-mode-map ( kbd "RET" ) 'newline-and-indent ) ) )
;;;;;;;;;;;;;;;;;;;;;;;; end python ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
