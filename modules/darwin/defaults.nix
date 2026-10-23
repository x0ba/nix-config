{ ... }:
let
  finderListView = "Nlsv";
in
{
  system.defaults = {
    dock = {
      autohide = false;
      show-recents = true;
      tilesize = 64;
    };

    finder.FXPreferredViewStyle = finderListView;
  };
}
