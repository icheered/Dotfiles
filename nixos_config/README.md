# Nixos Configuration
Clone the repo in `/etc/nixos`. 

Update the `/etc/nixos/configuration.nix` file import statement to be the following:
```nix
  imports =
    [ 
      ./hardware-configuration.nix
      ./nixos-config/shared.nix
      ./nixos-config/hardware-specific/laptop.nix # Or desktop.nix
    ];
```

And update the system!
```bash
sudo nixos-rebuild switch
sudo reboot now
```