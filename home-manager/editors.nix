{ pkgs, ... }:
let
  # lazy.nvim still coordinates LazyVim loading; Nix supplies every plugin.
  plugins = with pkgs.vimPlugins; {
    LazyVim = LazyVim;
    "lazy.nvim" = lazy-nvim;
    "blink.cmp" = blink-cmp;
    "bufferline.nvim" = bufferline-nvim;
    catppuccin = catppuccin-nvim;
    "conform.nvim" = conform-nvim;
    "flash.nvim" = flash-nvim;
    friendly-snippets = friendly-snippets;
    "gitsigns.nvim" = gitsigns-nvim;
    "grug-far.nvim" = grug-far-nvim;
    "lazydev.nvim" = lazydev-nvim;
    "lualine.nvim" = lualine-nvim;
    "mini.ai" = mini-ai;
    "mini.icons" = mini-icons;
    "mini.pairs" = mini-pairs;
    "noice.nvim" = noice-nvim;
    "nui.nvim" = nui-nvim;
    nvim-lint = nvim-lint;
    nvim-lspconfig = nvim-lspconfig;
    nvim-treesitter = nvim-treesitter.withAllGrammars;
    nvim-treesitter-textobjects = nvim-treesitter-textobjects;
    nvim-ts-autotag = nvim-ts-autotag;
    "persistence.nvim" = persistence-nvim;
    "plenary.nvim" = plenary-nvim;
    "snacks.nvim" = snacks-nvim;
    "todo-comments.nvim" = todo-comments-nvim;
    "tokyonight.nvim" = tokyonight-nvim;
    "trouble.nvim" = trouble-nvim;
    "ts-comments.nvim" = ts-comments-nvim;
    "which-key.nvim" = which-key-nvim;
  };
  pluginPaths = pkgs.writeText "lazyvim-nix-plugins.json" (builtins.toJSON plugins);
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
    # Existing Mason helpers, private to the editor wrapper.
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      shfmt
      tree-sitter
    ];
    plugins = [ { plugin = pkgs.vimPlugins.lazy-nvim; } ];
    # Language servers/formatters come from the current project's devShell.
    initLua = ''
      vim.opt.rtp:prepend("${pkgs.vimPlugins.lazy-nvim}")
      local paths = vim.json.decode(table.concat(vim.fn.readfile("${pluginPaths}"), "\n"))
      require("lazy").setup({
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          { "mason-org/mason.nvim", enabled = false },
          { "mason-org/mason-lspconfig.nvim", enabled = false },
          { "neovim/nvim-lspconfig", opts = { servers = { ["*"] = { mason = false } } } },
          { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {}, auto_install = false } },
          { "saghen/blink.cmp", opts = { fuzzy = { prebuilt_binaries = { download = false } } } },
        },
        dev = {
          path = function(plugin)
            return paths[plugin.name] or (vim.fn.stdpath("data") .. "/nix-unavailable/" .. plugin.name)
          end,
          patterns = { "" },
          fallback = false,
        },
        defaults = { lazy = false, version = false },
        install = { missing = false, colorscheme = { "tokyonight", "habamax" } },
        checker = { enabled = false },
        change_detection = { enabled = false },
        readme = { enabled = false },
        performance = { rtp = { reset = false, disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
      })
    '';
  };
}
