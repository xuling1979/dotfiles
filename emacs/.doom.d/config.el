;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "flycat"
      user-mail-address "flyxcat@outlook.com")

 (setq package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
                           ("melpa" . "http://elpa.zilongshanren.com/melpa/")))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; `doom-font'
;;`doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 20)
 doom-big-font (font-spec :family "monospace" :size 36)
 doom-variable-pitch-font (font-spec :family "monospace" :size 18)

      )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/Nutstore Files/Nutstore/org")
(setq deft-directory "~/logseq/pages")
(setq deft-use-filename-as-title t)


;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;;(setq +lsp-company-backend '(company-lsp :with company-tabnine :separate))
(setq-default global-visual-line-mode t)

(use-package! awesome-tab
  :config
  (awesome-tab-mode t)
  (setq awesome-tab-style 'slant)
  ;; winum users can use `winum-select-window-by-number' directly.
  (defun my-select-window-by-number (win-id)
    "Use `ace-window' to select the window by using window index.
WIN-ID : Window index."
    (let ((wnd (nth (- win-id 1) (aw-window-list))))
      (if wnd
          (aw-switch-to-window wnd)
        (message "No such window."))))

  (defun my-select-window ()
    (interactive)
    (let* ((event last-input-event)
           (key (make-vector 1 event))
           (key-desc (key-description key)))
      (my-select-window-by-number
       (string-to-number (car (nreverse (split-string key-desc "-")))))))

  (when (not (display-graphic-p))
    (setq frame-background-mode 'dark))
  (defun awesome-tab-buffer-groups ()
    "`awesome-tab-buffer-groups' control buffers' group rules.

Group awesome-tab with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
All buffer name start with * will group to \"Emacs\".
Other buffer group by `awesome-tab-get-group-name' with project name."
    (list
     (cond
      ((or (string-equal "*" (substring (buffer-name) 0 1))
           (memq major-mode '(magit-process-mode
                              magit-status-mode
                              magit-diff-mode
                              magit-log-mode
                              magit-file-mode
                              magit-blob-mode
                              magit-blame-mode
                              )))
       "Emacs")
      ((derived-mode-p 'eshell-mode)
       "EShell")
      ((derived-mode-p 'emacs-lisp-mode)
       "Elisp")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(org-mode org-agenda-mode diary-mode))
       "OrgMode")
      (t
       (awesome-tab-get-group-name (current-buffer))))))



;;   (defhydra awesome-fast-switch (:hint nil)
;;     "
;;  ^^^^Fast Move             ^^^^Tab                    ^^Search            ^^Misc
;; -^^^^--------------------+-^^^^---------------------+-^^----------------+-^^---------------------------
;;    ^_k_^   prev group    | _C-a_^^     select first | _b_ search buffer | _C-k_   kill buffer
;;  _h_   _l_  switch tab   | _C-e_^^     select last  | _g_ search group  | _C-S-k_ kill others in group
;;    ^_j_^   next group    | _C-j_^^     ace jump     | ^^                | ^^
;;  ^^0 ~ 9^^ select window | _C-h_/_C-l_ move current | ^^                | ^^
;; -^^^^--------------------+-^^^^---------------------+-^^----------------+-^^---------------------------
;; "
;;     ("h" awesome-tab-backward-tab)
;;     ("j" awesome-tab-forward-group)
;;     ("k" awesome-tab-backward-group)
;;     ("l" awesome-tab-forward-tab)
;;     ("0" my-select-window)
;;     ("1" my-select-window)
;;     ("2" my-select-window)
;;     ("3" my-select-window)
;;     ("4" my-select-window)
;;     ("5" my-select-window)
;;     ("6" my-select-window)
;;     ("7" my-select-window)
;;     ("8" my-select-window)
;;     ("9" my-select-window)
;;     ("C-a" awesome-tab-select-beg-tab)
;;     ("C-e" awesome-tab-select-end-tab)
;;     ("C-j" awesome-tab-ace-jump)
;;     ("C-h" awesome-tab-move-current-tab-to-left)
;;     ("C-l" awesome-tab-move-current-tab-to-right)
;;     ("b" ivy-switch-buffer)
;;     ("g" awesome-tab-counsel-switch-group)
;;     ("C-k" kill-current-buffer)
;;     ("C-S-k" awesome-tab-kill-other-buffers-in-current-group)
;;     ("q" nil "quit"))
;;   )
(setq awesome-tab-style "bar")
(setq awesome-tab-set-icons t)
(setq awesome-tab-set-bar t)
(setq awesome-tab-set-bar 'over)
(setq awesome-tab-set-modified-marker t)
(setq awesome-tab-set-close-button nil)
(setq awesome-tab-modified-marker "*")
(global-set-key (kbd "C-c j") 'awesome-tab-forward-tab)
(global-set-key (kbd "C-c k") 'awesome-tab-backward-tab)
(global-set-key (kbd "C-c o") 'awesome-tab-switch-group)

(use-package! rainbow-delimiters
  :config
  (custom-set-faces
   '(rainbow-delimiters-mismatched-face ((t (:foreground "white" :background "red" :weight bold))))
   '(rainbow-delimiters-unmatched-face ((t (:foreground "white" :background "red" :weight bold))))

   ;; show parents (in case of rainbow failing !)
   '(show-paren-match ((t (:foreground "white" :background "green" :weight bold))))
   '(show-paren-mismatch ((t (:foreground "white" :background "red" :weight bold)))))
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; highlight brackets
  )
(use-package! eyebrowse
  :config
  (progn
    (define-key eyebrowse-mode-map (kbd "M-1") 'eyebrowse-switch-to-window-config-1)
    (define-key eyebrowse-mode-map (kbd "M-2") 'eyebrowse-switch-to-window-config-2)
    (define-key eyebrowse-mode-map (kbd "M-3") 'eyebrowse-switch-to-window-config-3)
    (define-key eyebrowse-mode-map (kbd "M-4") 'eyebrowse-switch-to-window-config-4)
    (define-key eyebrowse-mode-map (kbd "M-5") 'eyebrowse-switch-to-window-config-5)
    (eyebrowse-mode t)
    (setq eyebrowse-new-workspace t)))

(use-package! ctrlf
  :config
  (add-hook! 'after-init-hook #'ctrlf-mode)
  )

(use-package! imenu-list
  :config
  (setq imenu-list-auto-resize t)
  (setq imenu-list-focus-after-activation t)
  (setq imenu-list-after-jump-hook nil)
  (add-hook 'menu-list-after-jump-hook #'recenter-top-bottom)
  )

(use-package! undo-fu
  :after-call doom-switch-buffer after-find-file
  :init
  (after! undo-tree
    (global-undo-tree-mode -1))
  :config
  ;; Store more undo history to prevent loss of data
  (setq undo-limit 400000
        undo-strong-limit 3000000
        undo-outer-limit 3000000)

  (define-minor-mode undo-fu-mode
    "Enables `undo-fu' for the current session."
    :keymap (let ((map (make-sparse-keymap)))
              (define-key map [remap undo] #'undo-fu-only-undo)
              (define-key map [remap redo] #'undo-fu-only-redo)
              (define-key map (kbd "C-_")     #'undo-fu-only-undo)
              (define-key map (kbd "M-_")     #'undo-fu-only-redo)
              (define-key map (kbd "C-M-_")   #'undo-fu-only-redo-all)
              (define-key map (kbd "C-x r u") #'undo-fu-session-save)
              (define-key map (kbd "C-x r U") #'undo-fu-session-recover)
              map)
    :init-value nil
    :global t)

  (undo-fu-mode +1))


(use-package! undo-fu-session
  :hook (undo-fu-mode . global-undo-fu-session-mode)
  :preface
  (setq undo-fu-session-directory (concat doom-cache-dir "undo-fu-session/")
        undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))

  ;; HACK We avoid `:config' here because `use-package's `:after' complicates
  ;;      the load order of a package's `:config' block and makes it impossible
  ;;      for the user to override its settings with merely `after!' (or
  ;;      `eval-after-load'). See jwiegley/use-package#829.
  (after! undo-fu-session
    ;; HACK Use the faster zstd to compress undo files instead of gzip
    (when (executable-find "zstd")
      (defadvice! doom--undo-fu-session-use-zstd-a (filename)
        :filter-return #'undo-fu-session--make-file-name
        (if undo-fu-session-compression
            (concat (file-name-sans-extension filename) ".zst")
          filename)))))


(use-package! undo-tree
  :disabled
  ;; Branching & persistent undo
  :after-call doom-switch-buffer-hook after-find-file
  :config
  (setq undo-tree-visualizer-diff t
        undo-tree-auto-save-history t
        undo-tree-enable-undo-in-region t
        ;; Increase undo-limits by a factor of ten to avoid emacs prematurely
        ;; truncating the undo history and corrupting the tree. See
        ;; https://github.com/syl20bnr/spacemacs/issues/12110
        undo-limit 800000
        undo-strong-limit 12000000
        undo-outer-limit 120000000
        undo-tree-history-directory-alist
        `(("." . ,(concat doom-cache-dir "undo-tree-hist/"))))

  ;; Compress undo-tree history files with zstd, if available. File size isn't
  ;; the (only) concern here: the file IO barrier is slow for Emacs to cross;
  ;; reading a tiny file and piping it in-memory through zstd is *slightly*
  ;; faster than Emacs reading the entire undo-tree file from the get go (on
  ;; SSDs). Whether or not that's true in practice, we still enjoy zstd's ~80%
  ;; file savings (these files add up over time and zstd is so incredibly fast).
  (when (executable-find "zstd")
    (defadvice! doom--undo-tree-make-history-save-file-name-a (file)
      :filter-return #'undo-tree-make-history-save-file-name
      (concat file ".zst")))

  ;; Strip text properties from undo-tree data to stave off bloat. File size
  ;; isn't the concern here; undo cache files bloat easily, which can cause
  ;; freezing, crashes, GC-induced stuttering or delays when opening files.
  (defadvice! doom--undo-tree-strip-text-properties-a (&rest _)
    :before #'undo-list-transfer-to-tree
    (dolist (item buffer-undo-list)
      (and (consp item)
           (stringp (car item))
           (setcar item (substring-no-properties (car item))))))

  ;; Undo-tree is too chatty about saving its history files. This doesn't
  ;; totally suppress it logging to *Messages*, it only stops it from appearing
  ;; in the echo-area.
  (advice-add #'undo-tree-save-history :around #'doom-shut-up-a)

  (global-undo-tree-mode +1))


(use-package! counsel
    :hook
    (after-init . ivy-mode)
    (counsel-grep-post-action . better-jumper-set-jump)
    :diminish ivy-mode
    :config
    (setq counsel-find-file-ignore-regexp "\\(?:^[#.]\\)\\|\\(?:[#~]$\\)\\|\\(?:^Icon?\\)"
          counsel-describe-function-function #'helpful-callable
          ncounsel-describe-variable-function #'helpful-variable
          ;; Add smart-casing (-S) to default command arguments:
          counsel-rg-base-command "rg -S --no-heading --line-number --color never %s ."
          counsel-ag-base-command "ag -S --nocolor --nogroup %s"
          counsel-pt-base-command "pt -S --nocolor --nogroup -e %s"
          counsel-find-file-at-point t)
       )

     (use-package! ivy-rich
       :config
       (ivy-rich-mode 1)
       (setq ivy-format-function #'ivy-format-function-line))
     ;;[[https://github.com/gilbertw1/better-jumper][gilbertw1/better-jumper: A configurable jump list implementation for Emacs]]
     ;;
;; (use-package! company-lsp)
(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2
        company-transformers nil)
  (setq company-show-numbers t)
  ;; (define-key company-active-map (kbd "C-j") 'company-select-next-or-abort)
  ;; (define-key company-active-map (kbd "C-k") 'company-select-previous-or-abort)

  )

(defun ora-company-number ()
  "Forward to `company-complete-number'.
Unless the number is potentially part of the candidate.
In that case, insert the number."
  (interactive)
  (let* ((k (this-command-keys))
         (re (concat "^" company-prefix k)))
    (if (or (cl-find-if (lambda (s) (string-match re s))
                        company-candidates)
            (> (string-to-number k)
               (length company-candidates))
            (looking-back "[0-9]+\\.[0-9]*" (line-beginning-position)))
        (self-insert-command 1)
      (company-complete-number
       (if (equal k "0")
           10
         (string-to-number k))))))

(defun ora--company-good-prefix-p (orig-fn prefix)
  (unless (and (stringp prefix) (string-match-p "\\`[0-9]+\\'" prefix))
    (funcall orig-fn prefix)))
(advice-add 'company--good-prefix-p :around #'ora--company-good-prefix-p)

;; (let ((map company-active-map))
;;   (mapc (lambda (x) (define-key map (format "%d" x) 'ora-company-number))
;;         (number-sequence 0 9))
;;   (define-key map " " (lambda ()
;;                         (interactive)
;;                         (company-abort)
;;                         (self-insert-command 1)))
;;   )
)


(use-package! company-tabnine
  :when (featurep! :completion company)
  :config
  (setq company-tabnine--disable-next-transform nil)
  (defun my-company--transform-candidates (func &rest args)
    (if (not company-tabnine--disable-next-transform)
        (apply func args)
      (setq company-tabnine--disable-next-transform nil)
      (car args)))

  (defun my-company-tabnine (func &rest args)
    (when (eq (car args) 'candidates)
      (setq company-tabnine--disable-next-transform t))
    (apply func args))

  (advice-add #'company--transform-candidates :around #'my-company--transform-candidates)
  (advice-add #'company-tabnine :around #'my-company-tabnine)
  ;; Trigger completion immediately.
  ;; (setq company-idle-delay 0)

  ;; Number the candidates (use M-1, M-2 etc to select completions).
  (setq company-show-numbers t)

  ;; Use the tab-and-go frontend.
  ;; Allows TAB to select and complete at the same time.
  ;;(company-tng-configure-default)
  ;;(setq company-frontends
  ;;      '(company-tng-frontend
  ;;        company-pseudo-tooltip-frontend
  ;;        company-echo-metadata-frontend))
  )

;;  (set-company-backend! 'sh-mode nil) ; unsets backends for sh-mode
(set-company-backend! '(c-mode
                        c++-mode
                        ess-mode
                        haskell-mode
                        ;;emacs-lisp-mode
                        lisp-mode
                        sh-mode
                        php-mode
                        python-mode
                        go-mode
                        ruby-mode
                        rust-mode
                        js-mode
                        css-mode
                        org-mode
                        web-mode
                        )
  '(:separate company-tabnine
              company-files
              company-yasnippet))

(setq +lsp-company-backend '(company-lsp :with company-tabnine :separate))

(use-package! highlight-indent-guides
:config
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-auto-enabled nil)
(set-face-background 'highlight-indent-guides-even-face "dimgray")
(set-face-foreground 'highlight-indent-guides-character-face "dimgray")
)

;;; -*- lexical-binding: t; -*-
;; we will call `blink-matching-open` ourselves...

(remove-hook 'post-self-insert-hook
             #'blink-paren-post-self-insert-function)
;; this still needs to be set for `blink-matching-open` to work
(setq blink-matching-paren 'show)

(let ((ov nil)) ; keep track of the overlay
  (advice-add
   #'show-paren-function
   :after
    (defun show-paren--off-screen+ (&rest _args)
      "Display matching line for off-screen paren."
      (when (overlayp ov)
        (delete-overlay ov))
      ;; check if it's appropriate to show match info,
      ;; see `blink-paren-post-self-insert-function'
      (when (and (overlay-buffer show-paren--overlay)
                 (not (or cursor-in-echo-area
                          executing-kbd-macro
                          noninteractive
                          (minibufferp)
                          this-command))
                 (and (not (bobp))
                      (memq (char-syntax (char-before)) '(?\) ?\$)))
                 (= 1 (logand 1 (- (point)
                                   (save-excursion
                                     (forward-char -1)
                                     (skip-syntax-backward "/\\")
                                     (point))))))
        ;; rebind `minibuffer-message' called by
        ;; `blink-matching-open' to handle the overlay display
        (cl-letf (((symbol-function #'minibuffer-message)
                   (lambda (msg &rest args)
                     (let ((msg (apply #'format-message msg args)))
                       (setq ov (display-line-overlay+
                                 (window-start) msg ))))))
          (blink-matching-open))))))

(defun display-line-overlay+ (pos str &optional face)
  "Display line at POS as STR with FACE.

FACE defaults to inheriting from default and highlight."
  (let ((ol (save-excursion
              (goto-char pos)
              (make-overlay (line-beginning-position)
                            (line-end-position)))))
    (overlay-put ol 'display str)
    (overlay-put ol 'face
                 (or face '(:inherit default :inherit highlight)))
    ol))

(setq show-paren-style 'paren
      show-paren-delay 0.03
      show-paren-highlight-openparen t
      show-paren-when-point-inside-paren nil
      show-paren-when-point-in-periphery t)
(show-paren-mode 1)



(use-package! awesome-pair)

(setq default-tab-width 2)
(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist
             '(ns-appearance . dark))

(global-auto-revert-mode t)

(add-hook 'org-mode-hook #'auto-fill-mode)

(setq
 web-mode-markup-indent-offset 2
 web-mode-code-indent-offset 2
 web-mode-css-indent-offset 2
 org-agenda-skip-scheduled-if-done t
 js-indent-level 2
 typescript-indent-level 2
 json-reformat:indent-width 2
 prettier-js-args '("--single-quote")
 projectile-project-search-path '("~/dev/")
 dired-dwim-target t
 org-ellipsis " ▾ "
 org-bullets-bullet-list '("·")
 org-tags-column -80
 css-indent-offset 2
                                  )

(add-hook! reason-mode
  (add-hook 'before-save-hook #'refmt-before-save nil t))

(add-hook!
  js2-mode 'prettier-js-mode
  (add-hook 'before-save-hook #'refmt-before-save nil t))


(after! ruby
  (add-to-list 'hs-special-modes-alist
               `(ruby-mode
                 ,(rx (or "def" "class" "module" "do" "{" "[")) ; Block start
                 ,(rx (or "}" "]" "end"))                       ; Block end
                 ,(rx (or "#" "=begin"))                        ; Comment start
                 ruby-forward-sexp nil)))

(after! web-mode
  (add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode)))

(defun +data-hideshow-forward-sexp (arg)
  (let ((start (current-indentation)))
    (forward-line)
    (unless (= start (current-indentation))
      (require 'evil-indent-plus)
      (let ((range (evil-indent-plus--same-indent-range)))
        (goto-char (cadr range))
        (end-of-line)))))

(add-to-list 'hs-special-modes-alist '(yaml-mode "\\s-*\\_<\\(?:[^:]+\\)\\_>" "" "#" +data-hideshow-forward-sexp nil))

(remove-hook 'enh-ruby-mode-hook #'+ruby|init-robe)

;; (use-package company
;;     :bind (
;;          :map company-active-map
;;          (("C-n"   . company-select-next)
;;           ("C-p"   . company-select-previous)
;;           ("C-d"   . company-show-doc-buffer)
;;           ("<tab>" . company-complete))
;;          )
;; )
