{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    shellAbbrs = with pkgs; {
      ":q" = "exit";
      git-rebase = "git rebase -i HEAD~2";
      cat = "bat --paging=never";
      gaa = "git add .";
      cls = "clear";
      commit = "git add . && git commit -m";
      m = "mkdir -p";
      push = "git push";
      pull = "git pull";
      nv = "nvim";
      fcd = "cd $(find -type d | fzf)";
      rm = "trash-put";
    };
    shellInit = ''
      set fish_greeting
    '';
  };
}
