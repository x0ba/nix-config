{pkgs, ...}: {
  home.packages = with pkgs; [
    sqlite
    cmake
    gopls
    gore
    gotools
    tree-sitter
    pipenv
    nixfmt
    black
    rust-analyzer
    shellcheck
    tectonic
    (texlive.combine {
      inherit
        (texlive)
        scheme-small
        dvipng
        dvisvgm
        l3packages
        xcolor
        soul
        adjustbox
        collectbox
        amsmath
        siunitx
        cancel
        mathalpha
        capt-of
        chemfig
        wrapfig
        mhchem
        fvextra
        cleveref
        latexmk
        tcolorbox
        environ
        arev
        amsfonts
        simplekv
        alegreya
        sourcecodepro
        newpx
        svg
        catchfile
        transparent
        hanging
        ;
    })
    gnuplot
    pandoc
    (aspellWithDicts (ds: with ds; [en en-computers en-science]))
    sdcv
    mu
    languagetool
    isync
  ];
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.pdf-tools
      epkgs.mu4e
      epkgs.editorconfig
    ];
  };
}
