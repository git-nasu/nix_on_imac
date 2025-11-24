{ config, pkgs, lib, ... }:
{
  home.username = "nasu05";
  home.homeDirectory = "/home/nasu05";
  home.stateVersion = "25.05";
  programs.bash.enable = false;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
      la = "eza --icons --all --group-directories-first";
      y = "yazi";
      update = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-imac";
      shut = "sudo shutdown -h now";
    };

    initContent = ''
      source ${./my-bash-function.sh}
      export STARSHIP_CONFIG="/home/nasu05/nixos-dotfiles/config/starship.toml"
    '';

    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ];then
        exec hyprland
      fi
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "ys";
    };
  };

  programs.git = {
    enable = true;
    userName = "nasu05";
    userEmail = "nasu05@icloud.com";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };


  # home.file.".config/qtile".source = ./config/qtile; 
  # home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/rofi".source = ./config/rofi;
  # home.file.".config/hypr".source = ./config/hypr;
  # home.file.".config/waybar".source = ./config/waybar;
  # home.file.".config/foot".source = ./config/foot;


  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/nasu05/nixos-dotfiles/config/nvim";
    recursive = true;
  };

  # xdg.configFile."rofi" = {
  #   source = config.lib.file.mkOutOfStoreSymlink "/home/nasu05/nixos-dotfiles/config/rofi";
  #   recursive = true;
  # };

  xdg.configFile."hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/nasu05/nixos-dotfiles/config/hypr";
    recursive = true;
  };

  xdg.configFile."waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/nasu05/nixos-dotfiles/config/waybar";
    recursive = true;
  };

  xdg.configFile."foot" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/nasu05/nixos-dotfiles/config/foot";
    recursive = true;
  };

  imports = [
    ./modules/neovim.nix
  ];

  home.packages = with pkgs; [
    gcc
    xclip
    xwallpaper
  ];



}
