(require 'package)
;;(package-initialize)
;; Add package archives
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
			 ("elpa"  . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)

;; Check if use-package is installed; if not, install it
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Load use-package
(eval-when-compile
  (require 'use-package))


(dolist (package '(use-package))
   (unless (package-installed-p package)
       (package-install package)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(all-the-icons-nerd-fonts company-box copilot dap-mode dashboard
			      doom-modeline doom-themes eglot elpy
			      eshell-toggle go-mode goggles hl-todo
			      lsp-pyright lsp-ui magit marginalia
			      material-theme orderless org-bullets
			      python-black rust-mode sphinx-doc
			      vertico vterm-toggle))
 '(package-vc-selected-packages
   '((copilot :url "https://github.com/copilot-emacs/copilot.el" :branch
	      "main"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; line numbers
(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)
(keymap-global-set "C-x C-r" 'recentf-open)
(keymap-global-set "C-c s g" 'grep-find)

(use-package dashboard
  :ensure t
  :config
  ;; Set the banner to display
  (setq dashboard-banner-logo-title "Welcome to Emacs!") ;; Set a custom welcome message
  (setq dashboard-startup-banner 'official) ;; Use 'official' for Emacs logo or specify your own image file path
  ;; Set the footer message
  (setq dashboard-footer-messages '("Happy hacking!"))
  (setq dashboard-show-shortcuts t)
  (setq dashboard-set-file-icons t)
  
  ;; Set the items to display
  (setq dashboard-items '((recents  . 10) ;; Show the 10 most recent files
                          (projects . 5) ;; Show 5 recent projects
                          (bookmarks . 5) ;; Show bookmarks
                          (agenda . 5))) ;; Show 5 agenda items
  ;; Set the dashboard center content
  (setq dashboard-center-content t)
  ;; Activate dashboard
  (dashboard-setup-startup-hook)
  ;; Set a custom footer
  (setq dashboard-footer "Configured by Joe"))


(use-package all-the-icons
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; Vterm does not work on Windows
;; (use-package vterm
;;     :ensure t)
;;  (use-package vterm-toggle
;;   :ensure t
;;   :bind (("C-c t" . vterm-toggle)
;;          ("C-c T" . vterm-toggle-cd))
  
;;   :config
;;   ;; Show vterm in a popup window
;;   (add-to-list 'display-buffer-alist
;;                '((lambda (buffer-or-name _)
;;                    (let ((buffer (get-buffer buffer-or-name)))
;;                      (with-current-buffer buffer
;;                        (or (equal major-mode 'vterm-mode)
;;                            (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
;;                  (display-buffer-reuse-window display-buffer-at-bottom)
;;                  (reusable-frames . visible)
;;                  (window-height . 0.3))))

(use-package eshell-toggle
  :ensure t ;; Automatically install from package archives
  :bind (("C-x t" . eshell-toggle)) ;; Example keybinding
  :config
  (setq eshell-toggle-size 30) ;; Optional: Configure eshell size
  (setq eshell-toggle-use-projectile-root t) ;; Example option
  :bind
  ("C-c t" . eshell-toggle))


(use-package company
  :commands company-mode
  :init
  (add-hook 'prog-mode-hook #'company-mode)
  :ensure t)

(use-package company-box
             :ensure t
  :hook (company-mode . company-box-mode))

;; Enable Vertico.
(use-package vertico
  :init
  (vertico-mode)
  :ensure t)

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode)
  :ensure t)

;; Emacs minibuffer configurations.
(use-package emacs
  :custom
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion))))
  :ensure t)


(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status)))

(use-package hl-todo
       :ensure t
       :custom-face
       (hl-todo ((t (:inherit hl-todo :italic t))))
       :hook ((prog-mode . hl-todo-mode)
              (yaml-mode . hl-todo-mode)))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package rust-mode
  :ensure t)

(use-package go-mode
  :ensure t)

(use-package python-black
  :ensure t
  )
(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright") ;; or basedpyright
  :hook (python-ts-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp)))  ; or lsp-deferred
)

;; save the old format buffer to run as default
(defalias 'default-lsp-format-buffer (symbol-function 'lsp-format-buffer))
(defun lsp-format-buffer ()
  "Format the current buffer using a custom formatting function."
  (interactive)
  (if (eq major-mode 'python-ts-mode)
      (python-black-buffer)
  (default-lsp-format-buffer))
  )


(use-package lsp-mode
  :init
  :hook (
         (go-mode . lsp)
         (rust-mode . lsp)
         (python-ts-mode . lsp)
         (js-ts-mode . lsp)
         (tsx-ts-mode . lsp)
         (typescript-ts-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . (lambda ()
                       (let ((lsp-keymap-prefix "C-c l"))
                         (lsp-enable-which-key-integration))))
	 )
  :config
  (setq lsp-ui-doc-show-with-mouse nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (define-key lsp-mode-map (kbd "C-c a") 'lsp-execute-code-action)
  (define-key lsp-mode-map (kbd "C-c e") 'flymake-show-buffer-diagnostics)
  (define-key lsp-mode-map (kbd "C-c C-e") 'flymake-goto-next-error)
  :ensure t)
(add-hook 'before-save-hook #'lsp-format-buffer)
(setq lsp-signature-auto-activate nil)

(add-hook 'lsp-mode-hook #'hs-minor-mode)
(unbind-key "C-z")
  (bind-keys :prefix-map personal-ops-map
             :prefix "C-z"
             :prefix-docstring "Personal key bindings"
             ("C-a" . hs-toggle-hiding)
             ("a" . hs-toggle-hiding))

(use-package lsp-ui
  :ensure t 
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t
        ;; lsp-ui-doc-use-childframe t	
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-include-signature t
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-imenu-enable t
        lsp-ui-imenu-kind-position 'top
        lsp-ui-peek-enable t
        lsp-ui-peek-always-show t
        lsp-ui-peek-peek-height 20
        lsp-ui-peek-list-width 50
	lsp-ui-peek-fontify 'always
	lsp-ui-imenu-enable t
	lsp-ui-imenu-kind-position 'top)
  (define-key lsp-ui-mode-map (kbd "C-c r") 'lsp-ui-peek-find-references)
  (define-key lsp-ui-mode-map (kbd "C-c k") 'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map (kbd "C-c C-k") 'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map (kbd "C-c h") 'lsp-ui-doc-focus-frame)
  (define-key lsp-ui-mode-map (kbd "C-c j") 'lsp-ui-doc-toggle)
  ;(add-hook 'lsp-ui-doc-unfocus-frame 'lsp-ui-doc-toggle)
  )
(eval-after-load "lsp-ui" 
                 '(defun lsp-ui-doc-unfocus-frame ()
  "Unfocus from lsp-ui-doc-frame."
  (interactive)
  (-some-> (frame-parent) select-frame-set-input-focus)
  (when-let* ((frame (lsp-ui-doc--get-frame)))
    (set-frame-parameter frame 'lsp-ui-doc--no-focus t)
    (set-frame-parameter frame 'cursor-type nil)
    (lsp-ui-doc--with-buffer
      (setq cursor-type nil))
    (when lsp-ui-doc--from-mouse
      (make-frame-invisible frame))
  )
  (if (lsp-ui-doc--visible-p)
     (lsp-ui-doc--hide-frame)
  )
))


(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-ts-mode))
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; I don't want to use semgrep
(setq lsp-disabled-clients '(semgrep-ls))

(use-package goggles
  :ensure t 
  :hook ((prog-mode text-mode) . goggles-mode)
  :config
  (setq-default goggles-pulse t)) ;; set to nil to disable pulsing

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :ensure t
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))
;; optionally
(use-package lsp-treemacs 
             :commands lsp-treemacs-errors-list
             :ensure t)

;; optionally if you want to use debugger
(use-package dap-mode
    :ensure t)

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode)
    :ensure t)



;; (use-package copilot
;;   :vc (:url "https://github.com/copilot-emacs/copilot.el"
;;             :rev :newest
;;             :branch "main"))

(use-package copilot
  :ensure t
  :hook (prog-mode . copilot-mode)
  :init
  (setq copilot-indent-offset-warning-disable t)
  :config
  ;;(with-eval-after-load 'company
  ;;  (define-key company-active-map (kbd "<C-return>") 'copilot-accept-completion))
  (define-key copilot-mode-map (kbd "<C-return>") 'copilot-accept-completion)
  ;;(define-key copilot-mode-map (kbd "C-c C-p") 'copilot-next-completion)
  ;;(define-key copilot-mode-map (kbd "C-c C-n") 'copilot-previous-completion)
  ;;(define-key copilot-mode-map (kbd "C-c C-d") 'copilot-clear-overlay)
  
  ;; Optional: Configure copilot server installation
  ;;(setq copilot-install-server-command "npm install -g copilot-cli")
  ;;(setq copilot-log-level 'debug)) ;; Debug mode for troubleshooting
  )
