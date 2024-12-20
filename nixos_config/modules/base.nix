# modules/base.nix
{
  config,
  pkgs,
  lib,
  ...
}:
let
  username = "tjbakker";
in
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "mem_sleep_default=deep"
    "acpi.sleep_rev=0"
  ];

  networking = {
    networkmanager.enable = true;
    #networkmanager.unmanaged = [ "wlp6s0" ];
    #networkmanager.logLevel = "DEBUG";
    wireless.enable = false;
  };


  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Prevent wakeups
  #boot.kernelParams = [ "noacpi" ];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        i3status
        i3lock
        i3blocks
        dmenu
        picom
      ];
    };
  };

  # Configure console keymap
  console.keyMap = "us";

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.${username} = {
    isNormalUser = true;
    description = "Tjeerd Bakker";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "users"
      "audio"
    ];
    shell = pkgs.zsh;
  };

  # Enable firefox
  programs.firefox.enable = true;

  # This line prevents nix from messing with your Git repo
  environment.etc."/nixos/nixos-config/.git".enable = false;

  # Enable OpenGL, required for some graphics programs
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ rocmPackages.clr.icd ];
  };

  # Enable nix-ld
  programs.nix-ld.enable = true;

  # Set environment variables system-wide
  environment.variables = {
    NIX_LD = lib.mkForce (lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker");
    NIX_LD_LIBRARY_PATH = lib.mkForce (
      lib.makeLibraryPath [
        pkgs.stdenv.cc.cc
        pkgs.openssl
        pkgs.zlib
        # Add other libraries your binaries might need, for example:
        # pkgs.glib
        # pkgs.libGL
      ]
    );
  };
}
