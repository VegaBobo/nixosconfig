{ lib, config, ... }:

let
  cfg = config.preferences;
in
{
  options.preferences = {
    nvidia = lib.mkEnableOption "Defines if target will use nvidia graphics";
  };

  config = lib.mkIf cfg.nvidia {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };
  };
}
