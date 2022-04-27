# Install

```
$ nix registry add haskell-nix-templates github:shin-sakata/haskell-nix-templates/master
```

# Usage

```
$ nix flake new my-project -t haskell-nix-templates#cabal-ghc8107
wrote: ./my-project/app/Main.hs
wrote: ./my-project/app
wrote: ./my-project/CHANGELOG.md
wrote: ./my-project/flake.nix
wrote: ./my-project/cabal-ghc8107-template.cabal
```
