{ config, home-manager, lib, pkgs, plasma-manager, ... }:

{
  imports = [
    home-manager.nixosModules.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
    users = { ${config.user.name} =
      import ./home.nix {
        config = config;
        pkgs = pkgs;
        lib = lib;
      };
    };
  };
}
