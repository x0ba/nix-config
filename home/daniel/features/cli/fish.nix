{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = with pkgs; {
      ":q" = "exit";
      git-rebase = "git rebase -i HEAD~2";
      nvim = "${pkgs.neovim}/bin/nvim";
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      bloat = "nix path-info -Sh /run/current-system";
      g = "git";
      gaa = "git add .";
      cls = "clear";
      commit = "git add . && git commit -m";
      nv = "neovide --frame buttonless";
      m = "mkdir -p";
      push = "git push";
      pull = "git pull";
      fcd = "cd $(find -type d | fzf)";
      rm = "${pkgs.trash-cli}/bin/trash-put";
      cat = "${pkgs.bat}/bin/bat --style=plain";
    };
    shellInit = ''
      set fish_greeting
    '';
  };
}
