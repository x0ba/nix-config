{
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./cli.nix
    ./discord.nix
    ./firefox.nix
    ./fish.nix
    ./fonts.nix
    ./ghostty.nix
    ./git.nix
    ./gpg.nix
    ./lf.nix
    ./mail.nix
    ./media.nix
    ./neovim.nix
    ./starship.nix
    ./sway.nix
    ./tmux.nix
    ./vscode.nix
    ./wezterm.nix
    ./zellij.nix
    ./zsh.nix
  ];

  options.isGraphical = lib.mkOption {
    default = osConfig.isGraphical;
    description = "Whether the system is a graphical target";
    type = lib.types.bool;
  };
}
