{
  description = "A collection of flake haskell-nix templates";
  outputs = { self }: {
    templates = {

      default = self.templates.cabal-ghc8107;

      cabal = {
        ghc8107 = {
          path = ./cabal/ghc8107/dist;
          description = "Create a haskell-nix Hello World project using the latest cabal and ghc8107";
        };

        ghc902 = {
          path = ./cabal/ghc902/dist;
          description = "Create a haskell-nix Hello World project using the latest cabal and ghc902";
        };
      };

    };
  };
}
