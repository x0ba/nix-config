{
  config,
  lib,
  ...
}:
let
  inherit (lib) getExe mkOrder;

  # `tool init zsh` prints a static script, but generating it costs 20-30ms of
  # process startup on every shell. Cache the output under ~/.cache/zsh/init,
  # keyed by the immutable Nix store path of the binary, so it is regenerated
  # only when the tool itself changes.
  #
  # mise is the one tool that bakes the current $PATH into its output; the sed
  # rewrites that line so the cached copy keeps whatever PATH the shell already
  # has, which is exactly what the live `eval "$(mise activate zsh)"` captures.
  cachedInit = ''
    _cached_init() {
      emulate -L zsh
      local name=$1
      shift
      local bin=$1
      shift
      if [[ $bin != /* ]]; then
        bin=''${commands[$bin]-}
        [[ -n $bin ]] || return 1
      fi
      local argkey=''${(j:_:)@}
      argkey=''${argkey//\//_}
      local cache=$HOME/.cache/zsh/init/$name-''${bin//\//_}-$argkey.zsh
      if [[ ! -s $cache ]]; then
        mkdir -p -- ''${cache:h} || return 1
        local tmp=$cache.$$.$RANDOM
        if "$bin" "$@" 2>/dev/null |
          sed -e 's|^export PATH=.*$|export PATH="$PATH"|' >| $tmp && [[ -s $tmp ]]
        then
          mv -f -- $tmp $cache
        else
          rm -f -- $tmp
          return 1
        fi
      fi
      _init_cache=$cache
    }
  '';
in
{
  programs.zsh = {
    enable = true;

    defaultKeymap = "emacs";
    autocd = true;

    enableCompletion = true;

    # nix-darwin's /etc/zshrc runs a full `compinit` (plus promptinit) before
    # .zshrc on every interactive shell. Skip it and do the equivalent here:
    # this file owns history, keybindings and completion already.
    envExtra = "export NOSYSZSHRC=1";

    # Load the completion dump instead of rebuilding it on every shell: that
    # skips the `compaudit` security sweep and the function rescan (~15ms).
    # Rebuild once a day so newly installed completions still get picked up.
    completionInit = ''
      autoload -U compinit
      if [[ -n $HOME/.zcompdump(N.mh-24) ]]; then
        compinit -C
      else
        compinit
      fi
    '';

    autosuggestion.enable = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
        "line"
        "cursor"
        "root"
      ];
    };

    historySubstringSearch.enable = true;

    history = {
      size = 10000;
      save = 10000;
      extended = true;
      share = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
    };

    initContent = lib.mkMerge [
      (mkOrder 500 ''
        ${cachedInit}

        # The rest of what /etc/zshrc would have done (see envExtra above).
        if [[ -n $REX_BIN_DIR ]]; then
          export PATH="$REX_BIN_DIR:$PATH"
        fi
        setopt prompt_sp
      '')

      # bashcompinit used to come from /etc/zshrc; it must run after compinit.
      (mkOrder 580 "autoload -U bashcompinit && bashcompinit")

      # Ordering mirrors what Home Manager emitted for these integrations:
      # zoxide after compinit, fzf before atuin so atuin owns C-r.
      (mkOrder 851 ''
        _cached_init zoxide ${getExe config.programs.zoxide.package} init zsh &&
          source -- "$_init_cache" ||
          eval "$(${getExe config.programs.zoxide.package} init zsh)"
      '')

      (mkOrder 910 ''
        if [[ $options[zle] = on ]]; then
          _cached_init fzf ${getExe config.programs.fzf.package} --zsh &&
            source -- "$_init_cache" ||
            eval "$(${getExe config.programs.fzf.package} --zsh)"
        fi
      '')

      (mkOrder 920 ''
        _cached_init direnv-instant direnv-instant hook zsh &&
          source -- "$_init_cache" ||
          eval "$(direnv-instant hook zsh)"
      '')

      (mkOrder 1000 ''
        if [[ $TERM != dumb ]]; then
          _cached_init starship ${getExe config.programs.starship.package} init zsh &&
            source -- "$_init_cache" ||
            eval "$(${getExe config.programs.starship.package} init zsh)"
        fi

        _cached_init mise ${getExe config.programs.mise.package} activate zsh &&
          source -- "$_init_cache" ||
          eval "$(${getExe config.programs.mise.package} activate zsh)"

        if [[ $options[zle] = on ]]; then
          _cached_init atuin ${getExe config.programs.atuin.package} init zsh &&
            source -- "$_init_cache" ||
            eval "$(${getExe config.programs.atuin.package} init zsh)"
        fi
      '')

      (mkOrder 1000 ''
        setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT PUSHD_TO_HOME
        setopt EXTENDED_GLOB INTERACTIVE_COMMENTS

        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      '')
    ];
  };
}
