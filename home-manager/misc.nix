{ config, lib, pkgs, target, ... }:

let
  isDesktopPersonal = target == "desktop-personal";
in
{
  programs.bash = lib.mkIf isDesktopPersonal {
    enable = true;
    shellAliases = {
      ls="ls --color=auto";
      grep="grep --color=auto";
      act="source /home/vega/.venv/bin/activate";
      dis="deactivate";
      aria2rpc="aria2c --enable-rpc --rpc-listen-all";
      repofs="repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags";
      psrs="pkill plasmashell ; kstart plasmashell";
      sss="scrcpy --video-codec=h265 --video-encoder=\"OMX.qcom.video.encoder.hevc\" --turn-screen-off";
      d="aria2c -x16 -s16 -k1M $1";
      ariarpc="aria2c --enable-rpc --rpc-listen-all --save-session=current.a2s --file-allocation=prealloc";
      gitu="git reset HEAD~";
      gitp="git format-patch $1";
      dtcd="dtc -I dtb -O dts -o $1";
      dtcb="dtc -I dts -O dtb -o $1";
      hs="python3 -m http.server";
    };
    initExtra = ''
      TERM="xterm-256color";
      PS1='\u \W '
      PATH=$PATH:${builtins.toPath ./bin}
      ANDROID_SDK_ROOT=/home/${config.user.name}/Android/Sdk
      ANDROID_HOME=/home/${config.user.name}/Android/Sdk
    '';
  };

  programs.foot = lib.mkIf isDesktopPersonal {
    enable = true;
    settings.main = {
      include = "${builtins.toPath ./resources/foot/kitty}";
      dpi-aware = "yes";
      initial-window-size-pixels= "1600x1200";
      font = "jetbrainsmono-regular:size=12";
    };
  };

  home.packages = with pkgs; lib.mkIf isDesktopPersonal [
    jetbrains-mono
  ];
}
