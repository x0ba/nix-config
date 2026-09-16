{ ... }:
{
  programs.ghostty = {
    enable = true;
    package = null; # Native macOS application is installed by the cask.
    settings = {
      shell-integration-features = true;
      theme = "Vesper";
      auto-update = "off";
    };
  };
}
