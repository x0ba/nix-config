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
  };
}
