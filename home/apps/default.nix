{
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./ghostty.nix
    ./discord.nix
    ./firefox.nix
    ./fonts.nix
    ./git.nix
    ./gpg.nix
    ./lf.nix
    ./media.nix
    ./neovim.nix
    ./starship.nix
    ./sway.nix
    ./tmux.nix
    ./vscode.nix
    ./wezterm.nix
    ./zsh.nix
  ];

  options.isGraphical = lib.mkOption {
    default = osConfig.isGraphical;
    description = "Whether the system is a graphical target";
    type = lib.types.bool;
  };
}
