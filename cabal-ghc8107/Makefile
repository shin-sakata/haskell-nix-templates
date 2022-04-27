TEMPLATE_NAME=cabal-ghc8107-template

new:
	mkdir -p ${TEMPLATE_NAME}
	nix develop . -c make cabal-new

# for nix develop environment
cabal-new:
	cd ${TEMPLATE_NAME} && cabal init --overwrite
	make fix-cabal

fix-cabal:
	cat ${TEMPLATE_NAME}/${TEMPLATE_NAME}.cabal | grep -v "author" | grep -v "maintainer" > tmp.cabal
	cat tmp.cabal > ${TEMPLATE_NAME}/${TEMPLATE_NAME}.cabal
