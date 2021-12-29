# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  baseconfig = { allowUnfree = true; };
  stable = import <nixos-stable> { config = baseconfig; };
in  
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix 
      /home/nazgul/local-secrets.nix 
    ];


#  services.mullvad-vpn = {
 #   enable = true;
 # };

  deployment.keys = {
    rpcpassword.text = "testpwd1";
    btcpassword.text = "testpwd1";
  };

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    cpu.amd.updateMicrocode = false;
    facetimehd.enable = true;
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
    pulseaudio.daemon.config = {
      flat-volumes = "no";
    };
    bluetooth.enable = true;
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp62s0.useDHCP = true;
  networking.interfaces.wlp63s0.useDHCP = true;

  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  #services.mullvad-vpn.enable = true;


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget
  #   vim
  #   networkmanager
  # ];


  environment.systemPackages = with pkgs; [
    wget vimHugeX sudo
    manpages
    gitAndTools.gitFull
    git-crypt
    iptables nmap tcpdump
    rxvt_unicode
    zlib
    bc
    bash
    htop
    unzip
    ntfs3g

    #vpn
    openvpn

    #univ
    texlive.combined.scheme-full

    #sound
    audacity
    pavucontrol

    # entertainment
    boohu
    brogue
    crawl
    dwarf-fortress
    ghostscript
    gimp
    inkscape
    nethack
    openmw
    quakespasm
    lmms
    
    # prep
    mono

    # coding junk
    gcc
    automake
    cmake
    gnumake
    jmtpfs
    jdk11
    boost159
    libsodium
    ctags

    # nix package for nix-shell etc
    binutils
    nix
    nix-prefetch-git
    nixops
    #virtualboxHardened
    #virtualbox
    #linuxPackages_3_10.virtualbox

    # Haskell related build tools
    ghc
#    haskellPackages.ghc-mod
    haskellPackages.hlint
    haskellPackages.hoogle
   # haskellPackages.xmobar
   # haskellPackages.xmonad
   # haskellPackages.xmonadContrib
   # haskellPackages.xmonadExtras
    cabal-install
    stack
    cabal2nix
    ansible

    # X11 packages
    firefox-bin
    trayer
    # Haskell packages for XMonad
    # xmonad-with-packages
    haskellPackages.xmonad
    haskellPackages.xmobar


    # Chromium
    chromium

    # Comminication programs
    pidginotr
    pidgin
    keybase
    keybase-gui
    discord
    tdesktop

    # Font junk
    xfontsel
    xlsfonts
    arandr

    # Other applications
    aria2
    dmenu
    xscreensaver
    xclip
    atom
    glxinfo
    vlc
    feh
    shutter
    libreoffice
    cmus
    cli-visualizer
    pciutils
    pwgen
    networkmanager 
    wirelesstools
    imagemagick
    ncdu
    syncthing
    maven
    cargo
    rustc
    rustup
    
      
    glibc
    
    pandoc
    python3

    ranger
    mullvad-vpn

    traceroute

    # Ethereum
    stable.openethereum

    # Tor
    #tor
    #torsocks
    #orbrowser
    # need to go about:config page and set browser.tabs.remote.autostart.2 = false
    socat
    python
    wine
    
    #c++
    boost

    #screenshot
    spectacle
    #xorg
    x11
    xorg.libX11
    xorg.libXext
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXrender
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.displayManager.defaultSession = "none+xmonad";

   services.xserver.windowManager = {
   xmonad.enable = true;
   xmonad.enableContribAndExtras = true;
   xmonad.extraPackages = hpkgs: [ 
	hpkgs.xmonad-contrib
	hpkgs.xmonad-extras
	hpkgs.xmonad
	];
   };
  
  services.xserver.desktopManager.xterm.enable = false;

#==================================


  services.openvpn.servers = {
#    spainVPN  = { 
#                 config = "config /home/nazgul/ivpn-openvpn-config/Spain.ovpn";
#                 authUserPass.username = "ivpnhmgPcJhb"; 
#                 authUserPass.password = "no3tOT5761Be9Ash4ame5d";
#                };
#    swedenVPN    = { 
#                 config = "config /home/nazgul/ivpn-openvpn-config/Sweden.ovpn";
#                 authUserPass.username = "ivpnhmgPcJhb"; 
#                 authUserPass.password = "no3tOT5761Be9Ash4ame5d";
#                };
#    netherVPN  = { 
#                 config = "config /home/nazgul/ivpn-openvpn-config/Netherlands.ovpn";
#                 authUserPass.username = "ivpnhmgPcJhb"; 
#                 authUserPass.password = "no3tOT5761Be9Ash4ame5d";
#                };
  };

#==================================

  services.xserver = {

    # Russian layout
    xkbModel = "microsoft";
    layout = "us,ru";
    xkbOptions = "grp:alt_shift_toggle";
  };

#==================================

  services.syncthing = {
    enable = true;
  };

  time.timeZone = "Europe/Moscow";

  console.font = "Lat2-Terminus16";
  console.keyMap = "us";
  i18n = {
    defaultLocale = "ru_RU.UTF-8";
  };
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      table
      table-others
      m17n
    ];
  };
  
  networking.networkmanager.enable = true;

  programs.light.enable = true;
  programs.ssh.startAgent = true;


#==================================


  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  users.extraUsers.nazgul = {
    createHome = true;
    home = "/home/nazgul";
    description = "naz";
    extraGroups = ["wheel" "audio" "sound" "disk" "cdrom" "vboxdusers" "networkmanager"];
    isSystemUser = false;
    isNormalUser = true;
    useDefaultShell = true;
  };
  security.sudo.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

