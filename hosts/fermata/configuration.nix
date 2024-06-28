{
  lib,
  pkgs,
  system,
  ...
}: {
  imports = [./brew.nix];
  environment = {
    shells = lib.attrValues {inherit (pkgs) fish;};

    systemPackages = lib.attrValues {
      inherit (pkgs) gawk;
    };
  };

  programs.fish.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
  system.defaults.alf.stealthenabled = 1;
  services.nix-daemon.enable = true;

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly" "IBMPlexMono" "JetBrainsMono"];})
      ibm-plex
      iosevka
      hack-font
      monaspace
      commit-mono
      cascadia-code
      atkinson-hyperlegible
      jetbrains-mono
    ];
  };
}
