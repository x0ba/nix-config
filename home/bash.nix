{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) getExe mkOrder;

  # Same idea as the zsh cache: `tool init bash` output is static, so cache it
  # under ~/.cache/bash/init keyed by the Nix store path of the binary.
  # mise's PATH line is rewritten to keep the shell's current PATH.
  cachedInit = ''
    _cached_init() {
      local name=$1 bin=$2
      shift 2
      if [[ $bin != /* ]]; then
        bin=$(command -v -- "$bin") || return 1
      fi
      local argkey="$*"
      argkey=''${argkey//\//_}
      argkey=''${argkey// /_}
      local cache=$HOME/.cache/bash/init/$name-''${bin//\//_}-$argkey.sh
      if [[ ! -s $cache ]]; then
        mkdir -p -- "''${cache%/*}" || return 1
        local tmp=$cache.$$.$RANDOM
        if "$bin" "$@" 2>/dev/null |
          sed -e 's|^export PATH=.*$|export PATH="$PATH"|' >"$tmp" && [[ -s $tmp ]]
        then
          mv -f -- "$tmp" "$cache"
        else
          rm -f -- "$tmp"
          return 1
        fi
      fi
      _init_cache=$cache
    }
  '';
in
{
  programs.bash = {
    enable = true;

    # Ordering matches what Home Manager used: fzf before atuin so atuin owns
    # C-r, zoxide after bash-completion so its cd hook can compdef.
    initExtra = lib.mkMerge [
      (mkOrder 100 cachedInit)

      (mkOrder 200 ''
        if [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
          _cached_init fzf ${getExe config.programs.fzf.package} --bash &&
            source "$_init_cache" ||
            eval "$(${getExe config.programs.fzf.package} --bash)"
        fi
      '')

      (mkOrder 900 ''
        _cached_init direnv-instant direnv-instant hook bash &&
          source "$_init_cache" ||
          eval "$(direnv-instant hook bash)"
      '')

      (mkOrder 950 ''
        _cached_init mise ${getExe config.programs.mise.package} activate bash &&
          source "$_init_cache" ||
          eval "$(${getExe config.programs.mise.package} activate bash)"
      '')

      (mkOrder 1000 ''
        if [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
          source "${pkgs.bash-preexec}/share/bash/bash-preexec.sh"
          _cached_init atuin ${getExe config.programs.atuin.package} init bash &&
            source "$_init_cache" ||
            eval "$(${getExe config.programs.atuin.package} init bash)"
        fi
      '')

      (mkOrder 2000 ''
        _cached_init zoxide ${getExe config.programs.zoxide.package} init bash &&
          source "$_init_cache" ||
          eval "$(${getExe config.programs.zoxide.package} init bash)"
      '')
    ];
  };
}
