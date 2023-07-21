{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkgs,
}:
rustPlatform.buildRustPackage rec {
  pname = "lutgen";
  name = "lutgen";

  src = fetchFromGitHub {
    owner = "ozwaldorf";
    repo = "lutgen-rs";
    rev = "f2d02ae1fc26eacd03884996ed8e978e605c1a5b";
    sha256 = "sha256-djQMrfQYuvun9dQPe+BCkGUQpQXpdiuBuwFpuiEZuRE=";
  };
  nativeBuildInputs = with pkgs; [
    cargo
    rustc
  ];
  cargoSha256 = "sha256-0skW4peK9o6bq07nUtbqG6uepc5dqnQkuum9oTzq2XE=";
}
