;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   ____   _   _   ___  __  __ ;;
;;  / ___| | | | | |_ _| \ \/ / ;;
;; | |  _  | | | |  | |   \  /  ;;
;; | |_| | | |_| |  | |   /  \  ;;
;;  \____|  \___/  |___| /_/\_\ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Personal desktop/server configuration
;; EXWM and XFCE setup with file sharing services

(add-to-load-path (string-append (dirname (current-filename)) "/modules"))

(use-modules (gnu)
             (gnu packages)
             (arisu packages)
             (arisu services)
             (arisu filesystems)
             (nongnu packages linux))

(use-service-modules desktop networking ssh xorg)

(operating-system
  (locale "en_GB.utf8")
  (timezone "Europe/Lisbon")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "wired")
  
  ;; Non-free kernel for hardware compatibility
  (kernel linux)
  (firmware (list linux-firmware))

  ;; User accounts
  (users (cons* (user-account
                 (name "arisu")
                 (comment "arisu")
                 (group "users")
                 (home-directory "/home/arisu")
                 (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; System packages - organized by purpose
  (packages (append arisu-desktop-packages
                    arisu-development-packages  
                    arisu-server-packages
                    %base-packages))

  ;; Services - desktop with server capabilities
  (services (append (list
                     ;; Server services
                     arisu-samba-service
                     arisu-nginx-service
					 ;; error: arisu-mpd-service: unbound variable
                     ;arisu-mpd-service

                     ;; System services
                     (service openssh-service-type)

					 ;; XFCE
                     (service xfce-desktop-service-type)
					 
                     ;; X11 configuration for EXWM
                     (set-xorg-configuration
                      (xorg-configuration 
                       (keyboard-layout keyboard-layout))))

                    ;; Use base desktop services
                    ;; EXWM will override the window manager
                    %desktop-services))

  ;; Boot configuration
  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets (list "/boot/efi"))
               (keyboard-layout keyboard-layout)))

  ;; Swap space
  (swap-devices (list (swap-space
                       (target (uuid "b47f38e0-3f1f-43be-b255-e708127ceccd")))))

  ;; File systems
  (file-systems arisu-file-systems))
