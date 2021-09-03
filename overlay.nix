final: prev: {
  lotusSrc = prev.callPackage ./pkgs/lotus-src.nix {};
  filcrypto = prev.callPackage ./pkgs/filcrypto.nix {
    # rustPlatform = prev.makeRustPlatform {
    #   cargo = final.rust-bin.beta.latest.cargo;
    #   rustc = final.rust-bin.beta.latest.rustc // {
    #     meta = final.rust-bin.beta.latest.rustc.meta // {
    #       platforms = prev.rustc.meta.platforms;
    #     };
    #   };
    # };
    rustPlatform = prev.makeRustPlatform {
      cargo = final.rust-bin.nightly.latest.default;
      rustc = final.rust-bin.nightly.latest.default;
    };
    # rustPlatform = prev.makeRustPlatform (
    #   final.rust-bin.beta.latest // {
    #     platforms = prev.rustc.meta.platforms;
    #   }
    # );
  };
  filecoin-ffi = prev.callPackage ./pkgs/filecoin-ffi.nix {};
  lotus = prev.callPackage ./pkgs/lotus.nix {};
}
