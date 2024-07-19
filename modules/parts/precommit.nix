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
          "_sources/"
          ".git-crypt/"
        ];

        settings.hooks = {
          nixfmt.enable = true;
          nixfmt.package = self'.formatter;
          commitizen.enable = true;
          deadnix.enable = true;
          nil.enable = true;
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
