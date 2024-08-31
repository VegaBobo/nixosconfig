{ config, lib, pkgs, ... }:

let
  cfg = config.preferences;
in
{
  options.preferences = {
    target = lib.mkOption {
      default = "desktop-personal";
      description = "Defines target name";
    };
  };

  config = lib.mkIf (cfg.target == "desktop-personal") {
    # Firefox
    programs.firefox.enable = true;

    # Android platform tools
    programs.adb.enable = true;

    # Sublime Text
    preferences.sublimeText = true;

    environment.systemPackages = with pkgs; [
      ffmpeg
      vim
      parted
      wget
      aria2
      git
      python3
      python3.pkgs.pip
      htop
      foot
      telegram-desktop
      strawberry-qt6
      obs-studio
      gimp
      mpv
      okteta
      meld
      fastfetch
      scrcpy
    ];
  };

}
