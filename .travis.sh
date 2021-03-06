set -uex

if [ "$KIND" = "ocaml" ]; then
	#Multicore OCaml
	sh .travis-ocaml.sh
	export OPAMYES=1
	eval $(opam config env)
	opam install -y ocamlfind ocamlbuild

	#Eff
	opam switch 4.02.3
	eval $(opam config env)
	opam pin add -k git eff https://github.com/matijapretnar/eff.git
	opam install -y eff

	#Make the files
	TRAVIS=true MULTICOREOCAML=$HOME/.opam/4.06.1+multicore/bin/ocaml EFF=$HOME/.opam/4.02.3/bin/eff FRANK= make all
elif [ "$KIND" = "haskell" ]; then
	echo "nothing to do"
else
	echo "Unknown build kind"
	exit 1
fi
