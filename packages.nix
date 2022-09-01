{ config, pkgs, ... }:

{
  
    environment.systemPackages = with pkgs; [
    picom
    git
    qutebrowser
    feh
    w3m
    pipe-viewer
    alsa-tools
    mpv
    scrot
    viewnior
    lxappearance
    catppuccin-gtk
    dino
    fluffychat
    translate-shell
    ];
    
}
