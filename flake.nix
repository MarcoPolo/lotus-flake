{
  description = "Lotus Daemon (filecoin) flake";
  inputs = {
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, rust-overlay }:

    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in

      {
        overlay = import ./overlay.nix;

        defaultPackage = forAllSystems (
          system: (
            import nixpkgs {
              inherit system;
              overlays = [ self.overlay (import rust-overlay) ];
            }
          ).lotus
        );

        packages = forAllSystems (
          system: (
            let
              pkgs = import nixpkgs {
                inherit system;
                overlays = [ self.overlay (import rust-overlay) ];
              };
            in
              {
                lotus = pkgs.lotus;
                filcrypto = pkgs.filcrypto;
                filecoin-ffi = pkgs.filecoin-ffi;
              }
          )
        );

        nixosModules.lotus = import ./module.nix;

      };
}
