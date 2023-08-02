{
  config,
  flakePath,
  ...
}: {
  xdg.configFile."sketchybar" = {
    source = ./config;
    recursive = true;
  };
}
