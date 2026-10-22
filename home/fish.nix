{ ... }:
{
  programs.fish = {
    enable = true;
    shellAliases.clde = "claude --dangerously-skip-permissions";
  };
}
