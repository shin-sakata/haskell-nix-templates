# Install

```shell
$ nix registry add haskell-nix-templates github:shin-sakata/haskell-nix-templates/6a8370483892d854e0f2b9b1b0e58acd09a81431
```

# Uninstall

```shell
$ nix registry remove haskell-nix-templates
```

# Quick start

```
$ nix flake new my-project -t haskell-nix-templates
```

# Usage

This example is for specifying the GHC version and package manager.

```
$ nix flake new my-project -t haskell-nix-templates#{cabal or stack}-ghc{version}
```

# Current status of support
| Cabal or Stack \ GHC version | 8.10.7 | 9.0.2 |  9.2.2 |
|---|---|---|---|
| Cabal | ✅ | ✅ | 🙅‍♀️ |
| Stack | 🙅‍♀️ | 🙅‍♀️ | 🙅‍♀️ |

# Future Plans
We will support various baajyon ghc and stacks and cabal.
