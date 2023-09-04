{
  config,
  pkgs,
  ...
}: let
  theme = config.colorScheme;
in {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyFile = "${config.xdg.dataHome}/zsh/history";
    shellAliases = {
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
      v = "${pkgs.neovim}/bin/nvim";
      vim = "${pkgs.neovim}/bin/nvim";
      fcd = "cd $(find -type d | fzf)";
      rm = "${pkgs.trash-cli}/bin/trash-put";
      cat = "${pkgs.bat}/bin/bat --style=plain";
    };
    initExtra = with theme.colors; ''
        export FZF_DEFAULT_OPTS='
        --color fg:#${base06},bg:#${base00},hl:#${base04},fg+:#${base07},bg+:#${base00},hl+:#${base04},border:#${base03}
        --color pointer:#${base08},info:#${base03},spinner:#${base03},header:#${base03},prompt:#${base0B},marker:#${base0B}
        '
      PS1="\[\e[95m\]\u \[\e[94;1m\]\w \[\e[0;91m\]\$ \[\e[0m\]"
      PS2=""
      PS3=""
    '';
  };
}
