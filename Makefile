DIST_DIR=${PACKAGE_MANAGER}/${GHC_VERSION}
PACKAGE_NAME=${PACKAGE_MANAGER}-${GHC_VERSION}
SHELL_NAME=${PACKAGE_MANAGER}-${GHC_VERSION}

# usage: `make build PACKAGE_MANAGER=cabal GHC_VERSION=ghc8107`
build:
	nix develop .#${SHELL_NAME} -c make cabal-new

# for nix develop environment
cabal-new:
	mkdir -p ${DIST_DIR}
	cd ${DIST_DIR} && cabal init --package-name=${PACKAGE_NAME} --overwrite
	make fix-project

fix-project:
	cat ${DIST_DIR}/${PACKAGE_NAME}.cabal | grep -v "author" | grep -v "maintainer" > tmp.cabal
	cat tmp.cabal > ${DIST_DIR}/${PACKAGE_NAME}.cabal
	rm tmp.cabal
	echo "use flake" > ${DIST_DIR}/.envrc
	echo "$${HASKELL_NIX_FLAKE_CONTENTS}" > ${DIST_DIR}/flake.nix

doctor:
	nix flake show .

define HASKELL_NIX_FLAKE_CONTENTS
{
  description = "A very basic flake";
  inputs.haskellNix.url = "github:input-output-hk/haskell.nix";
  inputs.nixpkgs.follows = "haskellNix/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils, haskellNix }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        overlays = [
          haskellNix.overlay
          (final: prev: {
            # This overlay adds our project to pkgs
            helloProject =
              final.haskell-nix.project' {
                src = ./.;
                compiler-nix-name = "${GHC_VERSION}";
                # This is used by `nix develop .` to open a shell for use with
                # `cabal`, `hlint` and `haskell-language-server`
                shell.tools = {
                  cabal = { };
                  hlint = { };
                  haskell-language-server = { };
                };
                # Non-Haskell shell tools go here
                shell.buildInputs = with pkgs; [
                  nixpkgs-fmt
                ];
                # This adds `js-unknown-ghcjs-cabal` to the shell.
                # shell.crossPlatforms = p: [p.ghcjs];
              };
          })
        ];
        pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
        flake = pkgs.helloProject.flake {
          # This adds support for `nix build .#js-unknown-ghcjs-cabal:hello:exe:hello`
          # crossPlatforms = p: [p.ghcjs];
        };
      in
      flake // {
        # Built by `nix build .`
        defaultPackage = flake.packages."${PACKAGE_NAME}:exe:${PACKAGE_NAME}";
      });
}
endef
export HASKELL_NIX_FLAKE_CONTENTS
