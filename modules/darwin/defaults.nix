{ ... }:
let
  finderListView = "Nlsv";
in
{
  system.defaults = {
    dock = {
      autohide = true;
      show-recents = true;
      tilesize = 64;
    };

    finder.FXPreferredViewStyle = finderListView;
  };
}
