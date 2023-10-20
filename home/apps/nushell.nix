{
  pkgs,
  inputs,
  ...
}: {
  programs.nushell = {
    enable = true;
    shellAliases = {
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      bloat = "nix path-info -Sh /run/current-system";
      g = "git";
      tree = "${pkgs.eza}/bin/eza --tree";
      gaa = "git add .";
      cls = "clear";
      push = "git push";
      pull = "git pull";
      cat = "${pkgs.bat}/bin/bat";
      nv = "${pkgs.neovim}/bin/nvim";
      rm = "${pkgs.trash-cli}/bin/trash-put";
    };
    configFile = {
      text = ''
        show_banner = false
      '';
    };
  };
}
