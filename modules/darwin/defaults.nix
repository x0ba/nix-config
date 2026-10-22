{ ... }:
let
  finderListView = "Nlsv";
in
{
  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
    };

    finder.FXPreferredViewStyle = finderListView;

    NSGlobalDomain.AppleInterfaceStyle = null; # null = Light (macOS has no "Light" value)
  };
}
