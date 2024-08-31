{ config, pkgs, lib, ... }:

let
  cfg = config.preferences;
  isKde = cfg.kdeDesktop;
  target = cfg.target;
in
{
  # general home-manager setup
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
  home.username = config.user.name;
  home.homeDirectory = "/home/${config.user.name}";

  # preferences applied to everything
  home.file = {
    ".vimrc".source = ./resources/vim/vimrc;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # other preferences
  imports = [
    (import ./kde.nix ({
        config = config;
        lib = lib;
        pkgs = pkgs;
        isKde = isKde;
        target = target;
      }))

    (import ./misc.nix ({
        config = config;
        lib = lib;
        pkgs = pkgs;
        target = target;
      }))

    (import ./private.nix ({
        config = config;
        lib = lib;
        pkgs = pkgs;
        target = target;
      }))
  ];
}
