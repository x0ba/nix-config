{
  config,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in {
  home.packages = with pkgs; [
    neomutt
    isync
    msmtp
    pass
    notmuch
    lynx
    abook
    mutt-wizard
  ];
}
