# Install

```
$ nix registry add haskell-nix-templates github:shin-sakata/haskell-nix-templates/master
```

# Usage

```
$ nix flake new my-project -t haskell-nix-templates#{cabal or stack}-ghc{version}
wrote: ./my-project/app/Main.hs
wrote: ./my-project/app
wrote: ./my-project/CHANGELOG.md
wrote: ./my-project/flake.nix
wrote: ./my-project/{cabal or stack}-ghc{version}-template.cabal
```

# Current status of support
| Cabal or Stack \ GHC version | 8.10.7 | 9.0.2 |  9.2.2 |
|---|---|---|---|
| Cabal | ✅ | 🙅‍♀️ | 🙅‍♀️ |
| Stack | 🙅‍♀️ | 🙅‍♀️ | 🙅‍♀️ |

# Future Plans
We will support various baajyon ghc and stacks and cabal.
