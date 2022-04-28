{
  description = "A collection of flake haskell-nix templates";
  outputs = { self, nixpkgs }: {
    devShells.x86_64-darwin.default = let pkgs = import nixpkgs { system = "x86_64-darwin"; }; in
      pkgs.mkShell {
        packages = [
          pkgs.gnumake
          pkgs.cabal-install
          pkgs.haskell.compiler.ghc8107
        ];
      };

  };
}
