{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in {
  imports = [./apps ./xdg.nix ./secrets/sops.nix];

  home = {
    packages = with pkgs; [
      _1password
      age
      age-plugin-yubikey
      comma
      fd
      ffmpeg
      file
      gh
      gh-dash
      git-crypt
      git-lfs
      glow
      gocryptfs
      imagemagick
      just
      lazygit
      lutgen
      mosh
      yq
      nix-output-monitor
      gitmux
      nil
      nur.repos.x0ba.icat
      nvd
      ranger
      ripgrep
      sops
      trash-cli
      wakatime
      watchexec
    ];

    sessionVariables = lib.mkIf isDarwin {
      SSH_AUTH_SOCK = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
    };
    stateVersion = "23.05";
  };

  home.file.".ideavimrc".text = ''
    " settings
    set ignorecase
    set smartcase
    set scrolloff=3 " 3 lines above/below cursor when scrolling
    set nonumber
    set clipboard+=unnamed
    set multiple-cursors
    set numberwidth=2
    set expandtab=true
    set shiftwidth=4

    " plugins
    set easymotion
    set NERDTree
    set surround
    set highlightedyank


    " bindings
    let mapleader = " "
    nmap <leader>. :action GotoFile<cr>
    nmap <leader>fr :action RecentFiles<cr>
    nmap <leader>ww <Plug>(easymotion-w)
    nmap <leader>tz :action Enter Zen Mode<cr>
    nmap <leader>op :NERDTreeToggle<cr>
    nmap <leader>ot :Terminal<cr>
    nmap <leader>: :action SearchEverywhere<cr>
    nmap <leader>/ :action Find<cr>

    " use ; to enter command
    nmap ; :

    " use jk for escaping
    inoremap jk <Esc>
    cnoremap jk <Esc>

    " move by visual lines"
    nmap j gj
    nmap k gk

    " use C-hjkl to navigate splits
    nmap <C-h> <c-w>h
    nmap <C-l> <c-w>l
    nmap <C-k> <c-w>k
    nmap <C-j> <c-w>j

    nmap <leader>E :action Tool_External Tools_emacsclient<cr>
  '';

  colorScheme = {
    slug = "oxocarbon";
    name = "Oxocarbon";
    author = "Nyoom Engineering";
    colors = {
      base00 = "161616";
      base01 = "262626";
      base02 = "393939";
      base03 = "525252";
      base04 = "dde1e6";
      base05 = "f2f4f8";
      base06 = "ffffff";
      base07 = "08bdba";
      base08 = "3ddbd9";
      base09 = "78a9ff";
      base0A = "ee5396";
      base0B = "33b1ff";
      base0C = "ff7eb6";
      base0D = "42be65";
      base0E = "be95ff";
      base0F = "82cfff";
    };
  };

  programs = {
    home-manager.enable = true;
    man.enable = true;
    taskwarrior.enable = true;
  };

  sops.secrets."sshconfig".path = "${config.home.homeDirectory}/.ssh/config";
  sops.secrets."wakatime-cfg".path = "${config.xdg.configHome}/wakatime/.wakatime.cfg";
}
