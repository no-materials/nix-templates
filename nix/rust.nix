{ inputs, ... }:
{
  perSystem =
    {
      self',
      pkgs,
      system,
      ...
    }:
    let
      fnx = inputs.fenix.packages.${system};

      mkRustDeriv =
        fnx-version: extra-components:
        let
          std-components = [
            fnx-version.cargo
            fnx-version.clippy
            fnx-version.rust-src
            fnx-version.rustc
            fnx-version.rust-analyzer

            # it's generally recommended to use nightly rustfmt
            fnx.complete.rustfmt
          ];
          all-components = std-components ++ extra-components;
        in
        fnx.combine all-components;

      stableRust = mkRustDeriv fnx.stable [ ];
      nightlyRust = mkRustDeriv fnx.complete [ ];
      wasmRust = mkRustDeriv fnx.stable [ fnx.targets.wasm32-unknown-unknown.stable.rust-std ];

      # Rust packages
      generalPkgs = with pkgs; [
        pkg-config
        alsaLib
        udev
        protobuf
        openssl
      ];
      nightlyPkgs = [ ];
      wasmPkgs = [ ];

      # Bevy packages
      bevyPackages = with pkgs; [
        # vulkan
        vulkan-loader

        # wayland
        wayland
        libxkbcommon

        # X
        xorg.libX11
        xorg.libXrandr
        xorg.libXcursor
        xorg.libXi
      ];

      mkName = name: name + "-dev-shell";
      mkPersonalShell =
        { shellName, shellPackages }:
        pkgs.mkShell rec {
          name = mkName shellName;
          packages = generalPkgs ++ shellPackages;
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath packages;
        };
    in
    {

      devShells = {
        rust-stable = mkPersonalShell {
          shellName = "rust-stable";
          shellPackages = [ stableRust ];
        };
        rust-nightly = mkPersonalShell {
          shellName = "rust-nightly";
          shellPackages = nightlyPkgs ++ [ nightlyRust ];
        };
        rust-wasm = mkPersonalShell {
          shellName = "rust-wasm";
          shellPackages = wasmPkgs ++ [ wasmRust ];
        };
        bevy-stable = mkPersonalShell {
          shellName = "bevy-stable";
          shellPackages = bevyPackages ++ [ stableRust ];
        };

      };
    };
}
