{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellAliases = with pkgs; {
      ":q" = "exit";
      git-rebase = "git rebase -i HEAD~2";
      nv = "${pkgs.neovim}/bin/nvim";
      cleanup = "nix-collect-garbage --delete-older-than 7d";
      gaa = "git add .";
      bloat = "nix path-info -Sh /run/current-system";
      g = "git";
      cls = "clear";
      commit = "git add . && git commit -m";
      m = "mkdir -p";
      push = "git push";
      pull = "git pull";
      fcd = "cd $(find -type d | fzf)";
      rm = "${pkgs.trash-cli}/bin/trash-put";
      cat = "${pkgs.bat}/bin/bat --style=plain";
    };
    shellInit = ''
      set fish_greeting
      fish_vi_key_bindings
    '';
  };
}
