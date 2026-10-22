{ config, ... }:
let
  repoRoot = "${config.home.homeDirectory}/nix-config";
  repoOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink "${repoRoot}/${path}";
in
{
  _module.args = { inherit repoOutOfStoreSymlink; };
}
