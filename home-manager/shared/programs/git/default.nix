{ config, lib, pkgs, ... }:

{
  programs.gh = {
    enable = true;

    extensions = lib.attrValues {
      inherit (pkgs)
        gh-cal
        gh-dash
        gh-eco;
    };

    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      editor = "${pkgs.neovim}/bin/nvim";
    };
  };


  programs.git = {

    signing = {
      signByDefault = true;
      key = "E8325E515382CDE43B9FBE12DDC4DDB3D659ED62";
    };
    ignores = [
      # general
      "*.log"
      ".DS_Store"
      # editors
      "*.swp"
      ".gonvim/"
      ".idea/"
      "ltex.dictionary*.txt"
      # nix-specific
      ".direnv/"
    ];
    # disable the macOS keychain, only use gopass
    package = pkgs.git.override { osxkeychainSupport = false; };
    enable = true;
    userName = "Daniel Xu";
    userEmail = "heavydenial@proton.me";
  };
}
