{
  lib,
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation {
  pname = "skl";
  version = "0.4.3";
  src = fetchurl {
    url = "https://github.com/x0ba/skl/releases/download/v0.4.3/skl-aarch64-apple-darwin";
    hash = "sha256-JUckFAGbIg4Ck64Z7QbeKFnA5qhu34UPnXox/HYYPtk=";
  };
  dontUnpack = true;
  installPhase = ''
    install -Dm755 "$src" "$out/bin/skl"
  '';
  meta = {
    description = "Daniel's agent skill manager";
    homepage = "https://github.com/x0ba/skl";
    license = lib.licenses.mit;
    platforms = [ "aarch64-darwin" ];
    mainProgram = "skl";
  };
}
