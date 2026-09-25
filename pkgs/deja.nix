{
  lib,
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation rec {
  pname = "deja";
  version = "0.4.2";
  src = fetchurl {
    url = "https://github.com/Giammarco-Ferranti/deja/releases/download/v${version}/deja_${version}_darwin_arm64.tar.gz";
    hash = "sha256-zZpVQzxLbDf8g/AAlZko14W2XqaAWduI+ER3jb1rU+w=";
  };
  sourceRoot = ".";
  installPhase = ''
    install -Dm755 deja "$out/bin/deja"
  '';
  meta = {
    description = "Predictive inline shell autosuggestions for zsh";
    homepage = "https://github.com/Giammarco-Ferranti/deja";
    license = lib.licenses.mit;
    platforms = [ "aarch64-darwin" ];
    mainProgram = "deja";
  };
}
