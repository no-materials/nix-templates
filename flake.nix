{
  description = "A collection of flake templates";

  inputs = {
    rust = {
      url = "path:./rust";
    };
    bevy = {
      url = "path:./bevy";
    };
  };

  outputs = { self, rust, bevy }:
  let
    system = "x86_64-linux"; # Adjust if necessary
  in {
      
  # Templates definition
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

  # Set the default template
  defaultTemplate = self.templates.rust;

  # Dev shells
  rust = rust.devShells.${system}.default;
  bevy = bevy.devShells.${system}.default;
  };
}
