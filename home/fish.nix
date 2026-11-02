{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) getExe mkOrder;

  # Cache the static output of `tool init fish` under ~/.cache/fish/init,
  # keyed by the Nix store path of the binary. mise bakes the current PATH
  # into its script, so that line is stripped and the shell's PATH is kept.
  #
  # The cache path is handed back in $_init_cache instead of sourcing from
  # inside the function, so the scripts still run in config.fish's scope.
  cachedInit = ''
    function _cached_init
        set -l name $argv[1]
        set -l bin $argv[2]
        if not string match -q '/*' -- "$bin"
            set bin (command -v -- "$bin")
            or return 1
        end
        set -l argkey (string join _ -- $argv[3..-1])
        set -l key (string replace -a / _ -- "$name-"(string replace -a / _ -- "$bin")"-$argkey")
        set -l cache $HOME/.cache/fish/init/$key.fish
        if not test -s $cache
            mkdir -p -- (path dirname $cache)
            or return 1
            set -l tmp "$cache.$fish_pid"(random)
            if $bin $argv[3..-1] 2>/dev/null | sed -e 's|^set -gx PATH .*$||' >$tmp; and test -s $tmp
                mv -f -- $tmp $cache
            else
                rm -f -- $tmp
                return 1
            end
        end
        set -g _init_cache $cache
    end
  '';
in
{
  programs.fish = {
    enable = true;

    # No greeting on startup.
    functions.fish_greeting = "";

    # Start a nix-shell that drops into fish, e.g. `fnix -p go`.
    shellAliases.fnix = "nix-shell --run fish";

    # Order 100 keeps this before atuin (default order), so atuin still owns
    # C-r the way it did when fzf was emitted at order 200.
    interactiveShellInit = mkOrder 100 ''
      ${cachedInit}

      set -g SHELL ${pkgs.fish}/bin/fish

      if _cached_init zoxide ${getExe config.programs.zoxide.package} init fish
          source $_init_cache
      else
          ${getExe config.programs.zoxide.package} init fish | source
      end

      if _cached_init fzf ${getExe config.programs.fzf.package} --fish
          source $_init_cache
      else
          ${getExe config.programs.fzf.package} --fish | source
      end

      if _cached_init direnv-instant direnv-instant hook fish
          source $_init_cache
      else
          direnv-instant hook fish | source
      end

      if test "$TERM" != dumb
          # `starship init fish` only prints a psub wrapper that runs
          # starship again; cache the real script instead.
          if _cached_init starship ${getExe config.programs.starship.package} init fish --print-full-init
              source $_init_cache
          else
              ${getExe config.programs.starship.package} init fish --print-full-init | source
          end
      end

      if _cached_init mise ${getExe config.programs.mise.package} activate fish
          source $_init_cache
      else
          ${getExe config.programs.mise.package} activate fish | source
      end
    '';
  };
}
