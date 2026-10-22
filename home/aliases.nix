# Aliases shared by all shells.
{ lib, pkgs, ... }:
let
  aliases = {
    clde = "claude --dangerously-skip-permissions";
    ll = "ls -lh";
    la = "ls -lAh";

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

  home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.xclip ];
}
