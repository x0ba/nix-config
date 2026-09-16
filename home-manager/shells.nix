{
  config,
  lib,
  pkgs,
  ...
}:
let
  aliases = {
    ls = "eza --icons=auto --group-directories-first";
    l = "eza --icons=auto --group-directories-first";
    ll = "eza -lah --icons=auto --group-directories-first --git";
    la = "eza -a --icons=auto --group-directories-first";
    tree = "eza --tree --icons=auto --group-directories-first";
    cat = "bat --paging=never";
    pn = "pnpm";
    pnx = "pnpm dlx";
    agent = "cursor-agent";
  };
in
{
  programs.zsh = {
    enable = true;
    dotDir = config.home.homeDirectory;
    shellAliases = aliases;
    defaultKeymap = "emacs";
    enableCompletion = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
    # Keep the completion UI declarative through Home Manager's zsh module.
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];
    # Put the Nix profiles first when shell integrations add PATH entries.
    profileExtra = lib.mkAfter ''
      path=(/etc/profiles/per-user/daniel/bin /run/current-system/sw/bin $path)
    '';
    initContent = lib.mkOrder 1100 ''
      if [[ -t 0 || -t 1 ]]; then
        export GPG_TTY="$(tty)"
        ${pkgs.gnupg}/bin/gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
      fi
      [[ -r "$HOME/.orbstack/shell/init.zsh" ]] && source "$HOME/.orbstack/shell/init.zsh"
    '';
  };
  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };
  programs.fish = {
    enable = true;
    shellAliases = aliases;
    interactiveShellInit = ''
      set -g fish_greeting
      if test -r "$HOME/.orbstack/shell/init2.fish"
        source "$HOME/.orbstack/shell/init2.fish"
      end
    '';
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = false;
    enableFishIntegration = false;
    enableBashIntegration = false;
  };
  programs.fzf = {
    enable = true;
    historyWidget.command = "";
  };
  programs.zoxide.enable = true;
  programs.atuin = {
    enable = true;
    settings = {
      enter_accept = true;
      search_mode = "daemon-fuzzy";
      update_check = false;
      daemon = {
        enabled = true;
        autostart = true;
      };
      # Atuin's interactive AI opt-in writes this setting itself.  The config is
      # managed by Home Manager (and therefore read-only in the Nix store), so
      # declare the opt-in here instead.
      ai.enabled = true;
    };
    daemon.enable = true;
  };
  programs.starship = {
    enable = true;
    enableTransience = true;
    settings = fromTOML (builtins.readFile ./starship.toml);
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
