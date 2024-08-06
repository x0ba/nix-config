{ pkgs, lib, ... }:
{
  imports = [
    ./vscode.nix
    ./cli.nix
    ./git.nix
    ./nu.nix
    ./zsh.nix
    ./ghostty.nix
    ./discord.nix
    ./fonts.nix
    ./emacs.nix
    ./spicetify.nix
  ];

  cli.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  nu.enable = lib.mkDefault true;

  catppuccin.flavor = "mocha";

  home = {
    packages = with pkgs; [
      rs-git-fsmonitor
      nixd
      watchman
      yubikey-personalization
      yubikey-manager
      borgmatic
      gopass
      ripgrep
    ];
    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man! -c 'nnoremap i <nop>'";
    };
  };
}
