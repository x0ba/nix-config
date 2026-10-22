{ lib, repoOutOfStoreSymlink, inputs, ... }:
{
  imports = [ inputs.direnv-instant.homeModules.direnv-instant ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.direnv-instant.enable = true;

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
        tug = [ "bookmark" "move" "--from" "closest_bookmark(@-)" "--to" "@-" ];
        retrunk = [ "rebase" "-d" "trunk()" ];
      };
      revset-aliases."closest_bookmark(to)" = "heads(::to & bookmarks())";
      template-aliases."format_timestamp(timestamp)" = "timestamp.ago()";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$username$hostname$directory$git_branch$git_status$character";
      add_newline = false;
      username = {
        show_always = false;
        format = "[$user@]($style)";
      };
      hostname.format = "[$hostname ]($style)";
      directory.truncation_length = 3;
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
  programs.fzf = {
    enable = true;
    historyWidget.command = ""; # atuin owns Ctrl-R
  };
  programs.mise.enable = true;
  programs.yazi.enable = true;
  programs.btop.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  # Link the whole LazyVim config from the repo (writable, so lazy-lock.json
  # updates land in git). Its own init.lua replaces the one Home Manager
  # would generate.
  xdg.configFile."nvim".source = repoOutOfStoreSymlink "home/config/nvim";
  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;
}
