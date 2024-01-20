{pkgs, ...}: {
  home.packages = with pkgs; [
    sqlite
    gopls
    gore
    gotools
    black
    tectonic
    gnuplot
    pandoc
    (aspellWithDicts (ds: with ds; [en en-computers en-science]))
    sdcv
    languagetool
    mu
    isync
  ];
}
