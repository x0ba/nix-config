{ inputs, ... }:
{
  imports = [ inputs.pre-commit-hooks.flakeModule ];

  perSystem =
    { self', ... }:
    {
      pre-commit = {
        check.enable = true;

        settings.excludes = [
          "flake.lock"
          ".git-crypt/"
        ];

        settings.hooks = {
          nixfmt.enable = true;
          nixfmt.package = self'.formatter;
          commitizen.enable = true;
          deadnix.enable = true;
          nil.enable = true;
          editorconfig-checker.enable = true;
          prettier = {
            enable = true;
            excludes = [
              ".js"
              ".md"
              ".ts"
            ];
          };
        };
      };
    };
}
