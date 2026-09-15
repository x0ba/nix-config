{ vscode-utils, fetchurl }:
let
  extension =
    name: version: id: hash:
    vscode-utils.buildVscodeExtension {
      pname = "anysphere-${name}";
      inherit version;
      vscodeExtPublisher = "anysphere";
      vscodeExtName = name;
      vscodeExtUniqueId = "anysphere.${name}";
      src = fetchurl {
        url = "https://marketplace.cursorapi.com/downloads/production/extensions/${id}/${version}/Microsoft.VisualStudio.Services.VSIXPackage";
        inherit hash;
        name = "anysphere-${name}-${version}.vsix";
      };
    };
in
[
  (extension "remote-ssh" "1.1.14" "73a45d83-83c7-4b22-bebf-c9130b0ab3f3"
    "sha256-rRAVuBdU2z0TnobJ9Q+6MAARGNKHvampAyalkOBvvUo="
  )
  (extension "remote-containers" "1.0.39" "94d8b289-9db0-4c3c-b4f3-a3294c789678"
    "sha256-y3rMm9gY5XTVFj/hSTv0a8wXUb0IU8wQ1goXTLvxwUI="
  )
]
