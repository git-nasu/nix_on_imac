{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-imac"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  #### Ipv6 invalid ####
  networking.enableIPv6 = false;

  boot.kernel.sysctl = {
    "net.ipv6.conf.all.disable_ipv6" = true;
    "net.ipv6.conf.default.disable_ipv6" = true;
    "net.ipv6.conf.lo.disable_ipv6" = true;
  };
  networking.networkmanager.settings = {
    ipv6.method = "disabled";
  };
  boot.kernelParams = [
    "ipv6.disable=1"
  ];

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  programs.hyprland.enable = true;
  programs.thunar.enable = true;
  programs.firefox.enable = true;


  # hardware settings
  hardware.graphics.enable = true;



  #Plasma6
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
      };
      autoRepeatDelay = 150;
      autoRepeatInterval = 10;
      windowManager.qtile.enable = true;
    };
    # Enable CUPS to print documents.
    libinput = {
      enable = true;
    };
    displayManager = {
      sddm.enable = true;
    };

    desktopManager.plasma6.enable = false;
  };

  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nasu05 = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "nasu05";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  programs.zsh.enable = true;


  # Sudo no password
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-emoji
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #devenv settings
  nix.settings.trusted-users = [ "root" "nasu05" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    eza
    foot
    kitty
    waybar
    hyprpaper
    imagemagick
  ];

  # Default terminal settings
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # no sleep settings
  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchDocked = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";
  services.logind.extraConfig = ''
    HandleSuspendKey=ignore
    HandleLidSwitch=ignore
    HandleHibernateKye=ignore
  '';

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernation=no
  '';

  # imac fan for linux
  services.mbpfan.enable = true;

  # sshd
  services.openssh.enable = true;

  #### slow boot settings ####
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/810e0008-c69b-4c36-93d5-1031687fe9dd";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/4DE0-88B3";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  # swap invalid
  # swapDevices = [ ];

  system.stateVersion = "25.05"; # Did you read the comment?

}
