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
    # The shells use direnv-instant's hook instead, added from the cached
    # init scripts in zsh.nix/bash.nix/fish.nix.
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
  };
  programs.direnv-instant = {
    enable = true;
    # Hooks are sourced from the per-shell cached init scripts instead.
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
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

  # Installs eza (the maintained fork of exa); the ls/ll/la/lla/lt aliases
  # every shell uses are defined in aliases.nix.
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
    # fish's integration is a static file and costs nothing to source, so keep
    # it. zsh/bash go through the cached init scripts in zsh.nix/bash.nix.
    enableBashIntegration = false;
    enableZshIntegration = false;
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

  # Shell integrations for the tools below are sourced from the cached init
  # scripts in zsh.nix/bash.nix/fish.nix instead of being eval'd on every
  # startup; the modules' own init lines are disabled here.
  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = false;
  programs.zoxide.enableFishIntegration = false;
  programs.zoxide.enableZshIntegration = false;

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = false;
  programs.fzf.enableFishIntegration = false;
  programs.fzf.enableZshIntegration = false;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package =
      if pkgs.stdenv.hostPlatform.isDarwin then pkgs.pinentry_mac else pkgs.pinentry-tty;
  };
  programs.mise.enable = true;
  programs.mise.enableBashIntegration = false;
  programs.mise.enableFishIntegration = false;
  programs.mise.enableZshIntegration = false;
  programs.yazi.enable = true;
  programs.btop.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  xdg.configFile."nvim".source = repoOutOfStoreSymlink "home/config/nvim";
  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;
}
