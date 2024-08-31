{ pkgs, ... }:

{
  # REL
  system.stateVersion = "24.05";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = "iridium";

  # Enable networking
  networking.networkmanager.enable = true;
  user.extraGroups = [ "networkmanager" "wheel" ];

  # Keyboard
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Virt
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Additional packages for this host
  environment.systemPackages = with pkgs; [
     audacity
     jetbrains.idea-community-bin
     android-studio
     androidStudioPackages.canary
     moonlight-qt
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Preferences
  preferences.target = "desktop-personal";
  preferences.kdeDesktop = true;
  preferences.pipewire = true;
  preferences.nvidia = true;
  preferences.impermanence = true;
}
