{
  config,
  flakePath,
  ...
}: {
  xdg.configFile."ranger" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/config/ranger";
    recursive = true;
  };
}
