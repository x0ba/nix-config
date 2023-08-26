{ config
, lib
, pkgs
, ...
}:
let
  inherit (config) colorscheme;
in
{
  home.sessionVariables.COLORTERM = "truecolor";
  programs.helix = {
    enable = true;
    settings = {
      theme = colorscheme.slug;
      editor = {
        color-modes = true;
        line-number = "relative";
        indent-guides.render = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          formatter = { command = "${lib.getExe pkgs.alejandra}"; };
          config.nil.nix.flake.autoEvalInputs = true;
        }
      ];
    };
    themes = import ./theme.nix { inherit colorscheme; };
  };
}
