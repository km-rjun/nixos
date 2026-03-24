{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  # User
  users.users.rjun = {
    isNormalUser = true;
    description = "Arjun";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  # Core packages
  environment.systemPackages = with pkgs; [
    neovim gcc git lazygit kitty tmux btop brave
    zsh fzf starship wireguard-tools

    niri
    waybar
    fuzzel
    wl-clipboard
    xdg-utils
    grim
    slurp
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  # Enable Wayland compositor (Niri)
  programs.niri.enable = true;

  # Enable seat/session management (required for Wayland)
  services.seatd.enable = true;

  # XDG portal (needed for screenshots, browsers, etc.)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable OpenSSH
  services.openssh.enable = true;

  # Optional but recommended for Wayland apps
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Chromium/Brave Wayland support
  };

  system.stateVersion = "24.11";
}
