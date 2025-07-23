# systemd alternative to crontab
# https://wiki.archlinux.org/title/Systemd/Timers
{ config, pkgs, pkgs-unstable, lib, ... }:
# systemctl list-timers --all

{
  environment.systemPackages = with pkgs; [
    firefox
  ];
  systemd.services."firefox_autostart" = {
    # TODO figure out how to handle display not being :0 
    script = ''
      DISPLAY=:0 ${lib.getExe pkgs.firefox} 
    '';
    # after = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      # Type = "oneshot";
      User = "${config.users.users.anna.name}";

    };
  };
    systemd.timers."firefox_autostart" = {
    wantedBy = [ "timers.target" ]; 
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };

    systemd.services."codium_autostart" = {
    # TODO not autostarting
    script = ''
      DONT_PROMPT_WSL_INSTALL="asdfasdf"  ${lib.getExe  pkgs.vscodium} 
    '';
    # after = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      # Type = "oneshot";
      User = "${config.users.users.anna.name}";

    };
  };
    systemd.timers."codium_autostart" = {
    wantedBy = [ "timers.target" ]; 
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  
}