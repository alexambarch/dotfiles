(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib

    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize) 
(require 'use-package)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(global-linum-mode 1)

(use-package avy
    :ensure t
    :bind ("M-s" . avy-goto-char))

(use-package evil
    :ensure t
    :config
    (evil-mode 1))

(use-package company
    :ensure t
    :config
    (add-hook 'after-init-hook 'global-company-mode))

(use-package irony
    :ensure t)

(use-package company-irony
    :ensure t
    :config
    (add-to-list 'company-backends 'company-irony))

(use-package semantic
    :ensure t
    :config
    (add-hook 'company-mode-hook 'semantic-mode))

(use-package smartparens
    :ensure t
    :config
    (smartparens-global-mode 1))

(use-package ggtags
    :ensure t
    :config
    (add-hook 'c-mode-hook ggtags-mode))

(use-package projectile
    :ensure t
    :config
    (projectile-mode +1)
    (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(setq c-basic-offset 4)

(use-package web-mode
    :ensure t
    :config
    (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
    (add-hook 'web-mode-hook #'emmet-mode))

(use-package vue-mode
    :ensure t
    :config
    (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode)))

(use-package magit
    :ensure t
    :bind ("C-x g" . magit-status))

(use-package helm
    :ensure t
    :bind (("C-x C-f" . helm-find-files)
           ("C-x b" . helm-buffers-list)
	   ("C-s" . helm-ag-this-file)
	   ("C-c p h" . helm-projectile)
           ("M-x" . helm-M-x)
	   ("M-y" . helm-show-kill-ring))
    :config
    (helm-mode 1))
