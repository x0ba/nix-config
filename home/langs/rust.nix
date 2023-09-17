{
  config,
  pkgs,
  ...
}: let
  inherit (config.xdg) dataHome;
in {
  home = rec {
    packages = [
      pkgs.cargo
      pkgs.rustc
    ];
    sessionVariables = {
      CARGO_HOME = "${dataHome}/cargo";
      CARGO_REGISTRIES_CRATES_IO_PROTOCOL = "sparse";
      CARGO_UNSTABLE_SPARSE_REGISTRY = "true";
      RUSTC_WRAPPER = "sccache";
      RUSTUP_HOME = "${dataHome}/rustup";
    };
    sessionPath = [
      "${sessionVariables.CARGO_HOME}/bin"
    ];
  };
}
