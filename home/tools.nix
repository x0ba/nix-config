{
  lib,
  pkgs,
  repoOutOfStoreSymlink,
  inputs,
  ...
}:
{
  imports = [ inputs.direnv-instant.homeModules.direnv-instant ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.direnv-instant = {
    enable = true;
    # Adds Rex as a supported multiplexer, so direnv runs in the background
    # in Rex terminals instead of blocking the prompt. Also keeps a separate
    # cache per shell so fish never loads a zsh-format env file.
    package = (pkgs.callPackage "${inputs.direnv-instant}/default.nix" { }).overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        ../patches/direnv-instant-rex.patch
        ../patches/direnv-instant-shell-cache.patch
      ];
    });
  };

  programs.bat.enable = true;
  home.sessionVariables.MANPAGER = "sh -c 'col -bx | bat -l man -p'";

  programs.eza.enable = true;
  programs.jq.enable = true;

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Daniel Xu";
        email = "hi@danielx.me";
      };
      ui.default-command = "log";
      aliases = {
        n = [ "new" ];
        tug = [
          "bookmark"
          "move"
          "--from"
          "heads(::@- & bookmarks())"
          "--to"
          "@-"
        ];
        retrunk = [
          "rebase"
          "-d"
          "trunk()"
        ];
      };
      revset-aliases."closest_bookmark(to)" = "heads(::to & bookmarks())";
      template-aliases."format_timestamp(timestamp)" = "timestamp.ago()";
    };
  };

  programs.atuin = {
    enable = true;
    settings = {
      enter_accept = true;
      search_mode = "daemon-fuzzy";
      daemon = {
        enabled = true;
        autostart = true;
      };
      ai.enabled = true;
    };
  };

  programs.zoxide.enable = true;
  programs.fzf.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package =
      if pkgs.stdenv.hostPlatform.isDarwin then pkgs.pinentry_mac else pkgs.pinentry-tty;
  };
  programs.mise.enable = true;
  programs.yazi.enable = true;
  programs.btop.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  xdg.configFile."nvim".source = repoOutOfStoreSymlink "home/config/nvim";
  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;
}
