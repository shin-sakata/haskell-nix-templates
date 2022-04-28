PACKAGE_NAME=cabal-ghc902-template
DIST_DIR=./dist

build:
	mkdir -p ${DIST_DIR}
	nix develop . -c make cabal-new

# for nix develop environment
cabal-new:
	cd ${DIST_DIR} && cabal init --package-name=${PACKAGE_NAME} --overwrite
	make fix-cabal

fix-cabal:
	cat ${DIST_DIR}/${PACKAGE_NAME}.cabal | grep -v "author" | grep -v "maintainer" > tmp.cabal
	cat tmp.cabal > ${DIST_DIR}/${PACKAGE_NAME}.cabal
	rm tmp.cabal
