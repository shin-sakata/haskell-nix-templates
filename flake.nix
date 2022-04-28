{
  description = "A collection of flake haskell-nix templates";
  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-darwin"; };
      eachToOjb = xs: f: builtins.foldl' (l: r: l // r) { } (builtins.map f xs);
      ghcVersions = [ "ghc8107" "ghc902" "ghc922" ];
      packageManagers = [ "cabal" ];
      eachGhcVersions = eachToOjb ghcVersions;
    in
    {
      templates = eachGhcVersions
        (ghcVersion: {
          "cabal-${ghcVersion}" = {
            path = ./cabal/${ghcVersion}/dist;
            description = "Create a haskell-nix Hello World project using the latest cabal and ${ghcVersion}";
          };
        }) // {
        default = self.templates.cabal-ghc8107;
      };

      # usage
      # `$ nix develop .#${packageManager}-${ghcVersion}`
      # example:
      # `$ nix develop .#cabal-ghc8107`
      devShells.x86_64-darwin = eachGhcVersions (ghcVersion: {
        "cabal-${ghcVersion}" = pkgs.mkShell {
          packages = [
            pkgs.gnumake
            pkgs.cabal-install
            pkgs.haskell.compiler.${ghcVersion}
          ];
        };
      });
    };
}
