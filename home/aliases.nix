# Aliases shared by all shells.
{ lib, pkgs, ... }:
let
  # eza is the maintained fork of exa and stands in for ls. The flags are
  # spelled out here rather than left to programs.eza's aliases, which only
  # add their options to `eza` itself: bash and zsh don't re-expand `ls` into
  # `eza` into `eza <options>`.
  eza = "eza --group-directories-first --icons=auto";

  aliases = {
    clde = "claude --dangerously-skip-permissions";

    ls = eza;
    ll = "${eza} -l";
    la = "${eza} -a";
    lla = "${eza} -la";
    lt = "${eza} --tree";

    ga = "git add";
    gc = "git commit";
    gco = "git checkout";
    gcp = "git cherry-pick";
    gdiff = "git diff";
    gl = "git prettylog";
    gp = "git push";
    gs = "git status";
    gt = "git tag";

    jd = "jj desc";
    jf = "jj git fetch";
    jn = "jj new";
    jp = "jj git push";
    js = "jj st";
  }
  // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
    pbcopy = "xclip -selection clipboard";
    pbpaste = "xclip -selection clipboard -o";
  };
in
{
  programs.bash.shellAliases = aliases;
  programs.zsh.shellAliases = aliases;
  programs.fish.shellAliases = aliases;
  programs.nushell.shellAliases = aliases;

  home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.xclip ];
}
