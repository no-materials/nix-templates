{
  imports = [
    ./bevy.nix
  ];

  perSystem =
    { self', pkgs, ... }:
    {
      formatter = pkgs.nixfmt-rfc-style;
      devShells.default = self'.devShells.bevy;
    };
}
