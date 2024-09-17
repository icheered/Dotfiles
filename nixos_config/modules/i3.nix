# modules/i3.nix
{ config, pkgs, ... }:
{
  # Configure X11 and window managers
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      # Enable dark theme for GDM
      wayland = true;
    };
    desktopManager.gnome.enable = true;
    windowManager.i3.enable = true;
  };

  # Exclude GNOME Shell and Session
  environment.gnome.excludePackages = with pkgs.gnome; [
    gnome-shell
    gnome-session
  ];

  # Configure i3-GNOME session
  environment.etc = {
    "xdg/gnome-session/sessions/i3-gnome.session".text = ''
      [GNOME Session]
      Name=i3-gnome
      RequiredComponents=org.gnome.SettingsDaemon.A11ySettings;org.gnome.SettingsDaemon.Color;org.gnome.SettingsDaemon.Datetime;org.gnome.SettingsDaemon.Housekeeping;org.gnome.SettingsDaemon.Keyboard;org.gnome.SettingsDaemon.MediaKeys;org.gnome.SettingsDaemon.Power;org.gnome.SettingsDaemon.PrintNotifications;org.gnome.SettingsDaemon.Rfkill;org.gnome.SettingsDaemon.ScreensaverProxy;org.gnome.SettingsDaemon.Sharing;org.gnome.SettingsDaemon.Smartcard;org.gnome.SettingsDaemon.Sound;org.gnome.SettingsDaemon.Wacom;org.gnome.SettingsDaemon.XSettings;
    '';
    "xdg/autostart/i3-gnome.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=i3-gnome
      Exec=i3
      NoDisplay=true
      X-GNOME-WMName=i3
      X-GNOME-Autostart-Phase=WindowManager
      X-GNOME-Provides=windowmanager
      X-GNOME-Autostart-Notify=false
    '';
  };

  # Set GTK theme
  environment.systemPackages = with pkgs; [
    arc-theme
    arc-icon-theme
  ];

  # Configure GTK settings for dark theme
  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.dconf ];
  
  # Set global dark theme preference
  programs.dconf.profiles.user.databases = [{
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "Arc-Dark";
        icon-theme = "Arc";
      };
    };
  }];

  # Set GTK3 settings
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
    gtk-theme-name=Arc-Dark
    gtk-icon-theme-name=Arc
  '';

  # Set GTK4 settings
  environment.sessionVariables = {
    GTK_THEME = "Arc-Dark";
  };
}
