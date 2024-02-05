{pkgs, ...}: {
  home.packages = with pkgs; [
    (ripgrep.override {withPCRE2 = true;})
    sqlite
    cmake
    pipenv
    cargo
    lua
    nixfmt
    black
    rust-analyzer
    nil
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
    languagetool
    isync
  ];
  programs.emacs = {
    enable = false;
    package = pkgs.emacs;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.sqlite
      epkgs.pdf-tools
      epkgs.mu4e
    ];
  };
}
