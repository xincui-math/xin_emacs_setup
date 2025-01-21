;;; init.el --- Emacs Configuration

;; -------------------------------
;; 1. Package Management
;; -------------------------------
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "https://orgmode.org/elpa/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; -------------------------------
;; 2. Performance Optimizations
;; -------------------------------
(setq gc-cons-threshold (* 50 1000 1000)) ;; Increase garbage collection threshold
(setq read-process-output-max (* 1 1024 1024)) ;; Increase subprocess output buffer size

;; -------------------------------
;; 3. UI Enhancements
;; -------------------------------
;; Theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

;; Line numbers
(global-display-line-numbers-mode t)

;; Which-key: Help for keybindings
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Smooth Scrolling
(setq scroll-conservatively 101)

;; -------------------------------
;; 4. Keybindings
;; -------------------------------
(global-set-key (kbd "C-x C-b") 'ibuffer) ;; Better buffer list
(global-set-key (kbd "M-x") 'counsel-M-x) ;; Use counsel for M-x
(global-set-key (kbd "C-x f") 'counsel-find-file) ;; Better file finder
(global-set-key (kbd "C-c s") 'counsel-rg) ;; Search with ripgrep
(global-set-key (kbd "C-S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-S-<down>") 'shrink-window)
(global-set-key (kbd "C-S-<up>") 'enlarge-window)

;; -------------------------------
;; 5. Mouse Configuration
;; -------------------------------
;; Enable mouse-based resizing
(global-set-key (kbd "<down-mouse-1>") 'mouse-drag-mode-line) ;; Resize vertically
(global-set-key (kbd "<down-mouse-3>") 'mouse-drag-vertical-line) ;; Resize horizontally

;; Enable mouse support in terminal
(unless (display-graphic-p)
  (xterm-mouse-mode 1)) ;; Basic mouse support for terminal

;; -------------------------------
;; 6. Programming Features
;; -------------------------------
;; Company: Autocompletion
(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t))

;; Optional: Better autocomplete UI for GUI
(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;; Ivy and Counsel: Enhanced minibuffer completion
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t
        ivy-initial-inputs-alist nil)) ;; Disable ^ regex in ivy prompts

(use-package counsel
  :ensure t
  :after ivy
  :config
  (counsel-mode 1))

;; Flycheck: Syntax checking
(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode))

;; Projectile: Project management
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))


(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode))

;; LSP Mode: Language Server Protocol
(use-package lsp-mode
  :ensure t
  :hook ((c++-mode python-mode) . lsp-deferred) ;; Add more modes as needed
  :commands lsp
  :config
  (setq lsp-completion-provider :capf)) ;; Use lsp-mode's completion with company

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-show-with-cursor t
        lsp-ui-sideline-enable t))

;; -------------------------------
;; 7. Language-Specific Configurations
;; -------------------------------

;; Python
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(use-package blacken
  :ensure t
  :hook (python-mode . blacken-mode))

(setq elpy-rpc-python-command "/home/choihsin/anaconda3/envs/py310/bin/python") ;; Or "python", or the full path to an interpreter

;; R
(use-package ess
  :ensure t
  :config
  (require 'ess-site))

;; LaTeX
(use-package auctex
  :ensure t
  :defer t)

(use-package tex
  :ensure auctex
  :hook (LaTeX-mode . auto-fill-mode)
  :config
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-PDF-mode t))

;; C++
(use-package lsp-mode
  :ensure t
  :hook (c++-mode . lsp-deferred)
  :commands lsp)

;; -------------------------------
;; 8. Miscellaneous
;; -------------------------------
;; Org-Mode
(use-package org
  :ensure t
  :config
  (setq org-startup-indented t
        org-hide-leading-stars t))

;; Recent Files
(use-package recentf
  :ensure nil ;; Built-in
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 25
        recentf-max-saved-items 100))

(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; Dired Sidebar
(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :config
  (setq dired-sidebar-theme 'nerd
        dired-sidebar-use-term-integration t
        dired-sidebar-use-custom-font t))

(global-set-key (kbd "C-x d") 'dired-sidebar-toggle-sidebar)

;; -------------------------------
;; End of Configuration
;; -------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(python-shell-interpreter "/home/choihsin/anaconda3/envs/py310/bin/python"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
