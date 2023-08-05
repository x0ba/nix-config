{pkgs}:
with pkgs;
  writeScriptBin "appmenu" ''
    #!/usr/bin/env bash

      rofi -show drun \
          -modi drun,run \
          -show-icons \
          -theme ~/.config/rofi/appmenu.rasi
  ''
