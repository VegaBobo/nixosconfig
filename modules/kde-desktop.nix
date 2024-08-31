{ lib, config, pkgs, ... }:

let
  cfg = config.preferences;
in
{
  options.preferences = {
    kdeDesktop = lib.mkEnableOption "Defines if target will use KDE Desktop";
  };

  config = lib.mkIf cfg.kdeDesktop {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    # Partition manager
    programs.partition-manager.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.kate
      kdePackages.kcalc
      kdePackages.spectacle
      kdePackages.plasma-systemmonitor
      kdePackages.okular
    ];

  };
}
