{...}: {
  services.espanso = {
    enable = true;
    matches = {
      base = {
        matches = [
          {
            trigger = ":mail";
            replace = "hey@aspectsides.site";
          }
        ];
      };
    };
  };
}
