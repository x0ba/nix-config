{pkgs, ...}: {
  home.packages = with pkgs; [
    lite-xl
  ];
}
