{
  description = "A collection of flake templates";

  outputs = { self }: {
    templates = {
      rust = {
        path = ./rust;
        description = "Rust template, using Fenix";
      };
      bevy = {
        path = ./bevy;
        description = "Bevy template, using stable Fenix";
      };
    };

    defaultTemplate = self.templates.rust;
  };
}
