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
	echo "use flake" >  ${DIST_DIR}/.envrc

doctor:
	nix flake show .
