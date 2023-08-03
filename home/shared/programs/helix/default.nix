{ config
, pkgs
, ...
}:

{
  programs.helix = {
    enable = true;
    settings = {
      keys.normal = {
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        "C-d" = [ "half_page_down" "align_view_center" ];
        "C-u" = [ "half_page_up" "align_view_center" ];
        "C-q" = ":bc";
        space.u = {
          f = ":format"; # format using LSP formatter
          w = ":set whitespace.render all";
          W = ":set whitespace.render none";
        };
      };
      keys.select = {
        "%" = "match_brackets";
      };
      editor = {
        color-modes = true;
        cursorline = true;
        idle-timeout = 1;
        line-number = "relative";
        scrolloff = 5;
        bufferline = "never";
        true-color = true;
        lsp.display-messages = true;
        indent-guides = {
          render = true;
        };
        gutters = [ "diagnostics" "line-numbers" "spacer" "diff" ];
        statusline = {
          separator = "|";
          left = [ "mode" "selections" "spinner" "file-name" "total-line-numbers" ];
          center = [ ];
          right = [ "diagnostics" "file-encoding" "file-line-ending" "file-type" "position-percentage" "position" ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        whitespace.characters = {
          space = "·";
          nbsp = "⍽";
          tab = "→";
          newline = "⤶";
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "block";
        };
      };
    };

  };

}
