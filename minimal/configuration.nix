{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  # Hostname & networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = false;
  networking.useDHCP = true;

  # Time & locale
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  # User
  users.users.rjun = {
    isNormalUser = true;
    description = "Arjun";
    extraGroups = [ "wheel" ];
  };

  # Allow sudo for wheel
  security.sudo.wheelNeedsPassword = true;

  # Minimal system packages (only essentials)
  environment.systemPackages = with pkgs; [
    git
    neovim
    tmux
  ];

  # Enable SSH
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  # Firewall (recommended ON)
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  # No GUI / desktop services
  services.xserver.enable = false;

  # Enable flakes (optional but common for servers)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System version
  system.stateVersion = "24.11";
}
