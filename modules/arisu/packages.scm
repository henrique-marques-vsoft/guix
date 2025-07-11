(define-module (arisu packages)
  #:use-module (gnu packages)
  #:export (arisu-desktop-packages
            arisu-development-packages
            arisu-server-packages))

;;; Desktop environment packages
;; Emacs with EXWM
(define arisu-desktop-packages
  (list (specification->package "emacs")
        (specification->package "emacs-exwm")
        (specification->package "xfce")		
        (specification->package "emacs-desktop-environment")
        (specification->package "kitty")
        (specification->package "flameshot")
        ;; Music
        (specification->package "mpv")
        (specification->package "ncmpcpp")
        (specification->package "mpc")
        (specification->package "rhythmbox")))

;; Dev tools
(define arisu-development-packages  
  (list (specification->package "git")
        (specification->package "gimp")))

;; Server and system tools
(define arisu-server-packages
  (list (specification->package "btop")
        (specification->package "deluge")
        (specification->package "nicotine+")))
