{ config, pkgs, callPackage, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./packages.nix
    ];
 
  #zram   
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };  

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true; #Enables NetworkManager.  

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
   };
  
  #nix
  
  
  nix = {
      package = pkgs.nixFlakes;
      extraOptions = ''experimental-features = nix-command flakes'';
  };


  #kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Enable the X11 windowing system.
  
   services.xserver = {
    enable = true;
    layout = "us";
    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+exwm";
    windowManager.exwm.enable = true;
    videoDrivers = [ "intel" ];
  };

   
  # Enable sound.
  sound.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lina = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   };

  system.stateVersion = "22.05";
}

