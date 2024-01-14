{
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./graphical
    ./cli
    ./terms
  ];

  options.isGraphical = lib.mkOption {
    default = osConfig.isGraphical;
    description = "Whether the system is a graphical target";
    type = lib.types.bool;
  };
}
