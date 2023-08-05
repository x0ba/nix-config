{...}: {
  programs.helix = {
    enable = true;
    themes = {
      base16 = let
        transparent = "none";
        gray = "#4c4c4c";
        dark-gray = "#4c4c4c";
        white = "#f0f0f0";
        black = "#0f0f0f";
        red = "#ac8a8c";
        green = "#8aac8b";
        yellow = "#aca98a";
        orange = "#fe8019";
        blue = "#83a598";
        magenta = "#d3869b";
        cyan = "#8ec07c";
      in {
        "ui.menu" = transparent;
        "ui.menu.selected" = {modifiers = ["reversed"];};
        "ui.linenr" = {
          fg = gray;
          bg = dark-gray;
        };
        "ui.popup" = {modifiers = ["reversed"];};
        "ui.linenr.selected" = {
          fg = white;
          bg = black;
          modifiers = ["bold"];
        };
        "ui.selection" = {
          fg = black;
          bg = blue;
        };
        "ui.selection.primary" = {modifiers = ["reversed"];};
        "comment" = {fg = gray;};
        "ui.statusline" = {
          fg = white;
          bg = dark-gray;
        };
        "ui.statusline.inactive" = {
          fg = dark-gray;
          bg = white;
        };
        "ui.help" = {
          fg = dark-gray;
          bg = white;
        };
        "ui.cursor" = {modifiers = ["reversed"];};
        "variable" = red;
        "variable.builtin" = orange;
        "constant.numeric" = orange;
        "constant" = orange;
        "attributes" = yellow;
        "type" = yellow;
        "ui.cursor.match" = {
          fg = yellow;
          modifiers = ["underlined"];
        };
        "string" = green;
        "variable.other.member" = red;
        "constant.character.escape" = cyan;
        "function" = blue;
        "constructor" = blue;
        "special" = blue;
        "keyword" = magenta;
        "label" = magenta;
        "namespace" = blue;
        "diff.plus" = green;
        "diff.delta" = yellow;
        "diff.minus" = red;
        "diagnostic" = {modifiers = ["underlined"];};
        "ui.gutter" = {bg = black;};
        "info" = blue;
        "hint" = dark-gray;
        "debug" = dark-gray;
        "warning" = yellow;
        "error" = red;
      };
    };
    settings = {
      theme = "base16";
      keys.normal = {
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        "C-d" = ["half_page_down" "align_view_center"];
        "C-u" = ["half_page_up" "align_view_center"];
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
        gutters = ["diagnostics" "line-numbers" "spacer" "diff"];
        statusline = {
          separator = "|";
          left = ["mode" "selections" "spinner" "file-name" "total-line-numbers"];
          center = [];
          right = ["diagnostics" "file-encoding" "file-line-ending" "file-type" "position-percentage" "position"];
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
