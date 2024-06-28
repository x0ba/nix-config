{inputs, ...}: {
  imports = [inputs.pre-commit-hooks.flakeModule];

  perSystem.pre-commit = {
    check.enable = true;

    settings.excludes = ["flake.lock" "_sources/"];

    settings.hooks = {
      alejandra.enable = true;
      commitizen.enable = true;
      editorconfig-checker.enable = true;
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
}
