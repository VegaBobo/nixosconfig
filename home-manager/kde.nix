{ config, lib, pkgs, isKde, target, ... }:

let
  isPersonal = target == "desktop-personal";
in
{
  gtk.theme.name = lib.mkIf isKde "Breeze";

  programs.plasma = lib.mkIf isKde {
    enable = true;

    kwin.titlebarButtons.left = [
      "close"
      "minimize"
      "maximize"
      "keep-above-windows"
    ];
    kwin.titlebarButtons.right = [ "more-window-actions" ];

    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        powerButtonAction = "nothing";
        whenSleepingEnter = "standby";
        whenLaptopLidClosed = "doNothing";
        turnOffDisplay.idleTimeout = 600;
      };
    };

    configFile = {
      dolphinrc = {
        PlacesPanel.IconSize = 32;
        PlacesPanel.RememberOpenedTabs = false;
      };
      kdeglobals.KDE.SingleClick = true;
      kdeglobals.General.TerminalApplication = lib.mkIf isPersonal "foot";
      kdeglobals.General.TerminalService =
        lib.mkIf isPersonal "org.codeberg.dnkl.foot.desktop";
      kcminputrc.Keyboard.NumLock.value = 0;
    };

    workspace = {
      iconTheme = "Papirus";
    };

    panels = [
      {
        location = "bottom";
        height = 64;
        lengthMode = "fit";
        hiding = "dodgewindows";
        widgets = [
          { name = "org.kde.plasma.kickerdash"; }
          {
            iconTasks = {
              launchers = if isPersonal then [
                "applications:firefox.desktop"
                "applications:org.codeberg.dnkl.foot.desktop"
                "applications:systemsettings.desktop"
                "applications:org.telegram.desktop.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.kate.desktop"
                "applications:org.strawberrymusicplayer.strawberry.desktop"
                "applications:audacity.desktop"
                "applications:com.obsproject.Studio.desktop"
                "applications:org.kde.kcalc.desktop"
                "applications:sublime_text.desktop"
                "applications:org.kde.spectacle.desktop"
                "applications:gimp.desktop"
                "applications:org.kde.partitionmanager.desktop"
                "applications:org.kde.plasma-systemmonitor.desktop"
                "applications:android-studio-canary.desktop"
                "applications:idea-community.desktop"
                "applications:davinci-resolve.desktop"
              ] else [
                "applications:firefox.desktop"
                "applications:systemsettings.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.kate.desktop"
                "applications:org.kde.kcalc.desktop"
                "applications:org.kde.spectacle.desktop"
                "applications:org.kde.partitionmanager.desktop"
                "applications:org.kde.plasma-systemmonitor.desktop"
              ];
            };
          }
        ];
      }
      {
        location = "top";
        height = 36;
        lengthMode = "fill";
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "${builtins.toPath resources/plasma/plasma_logo.png}";
              };
            };
          }
          {
            applicationTitleBar = {
              layout = {
                elements = ["windowTitle" ];
              };
              windowTitle = {
                undefinedWindowTitle = "Plasma Desktop";
                hideEmptyTitle = true;
                source = "appName";
              };
            };
          }
          { name = "org.kde.plasma.appmenu"; }
          { name = "org.kde.plasma.panelspacer"; }
          { plasmusicToolbar = { }; }
          { name = "org.kde.plasma.colorpicker"; }
          { systemTray.items = { }; }
          { digitalClock = {
              date = { enable = false; };
            };
          }
          { name = "org.kde.milou"; }
        ];
      }
    ];
  };

  home.packages = with pkgs; lib.mkIf isKde [
    papirus-icon-theme
    noto-fonts
    noto-fonts-cjk
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
}
