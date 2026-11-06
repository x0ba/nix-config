{ ... }:
let
  finderListView = "Nlsv";
in
{
  system.defaults = {
    dock = {
      autohide = false;
      orientation = "bottom";
      show-recents = true;
      tilesize = 56;
    };

    finder.FXPreferredViewStyle = finderListView;
  };
}
