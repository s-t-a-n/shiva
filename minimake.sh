#!/bin/bash

project=shiva
build_dir=build
targets=("${project}-debugger")

if [ $# -eq 1 ] && [ "$1" == "test" ]; then
	# compile and test
	cmake -S . -B $build_dir -DBUILD_TESTING=ON -DCMAKE_BUILD_TYPE=Debug && ( cd $build_dir && make ) \
	&& ( cd $build_dir && ctest --output-on-failure ./) \
	&& echo -e "Tests ran: \e[92mok\e[39m." \
	|| { echo -e "Tests ran: \e[91mNOPE\e[39m."; false; }
elif [ $# -eq 1 ] && [ "$1" == "testOpt" ]; then
	# compile and test with optimisation
	cmake -S . -B $build_dir -DBUILD_TESTING=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo && ( cd $build_dir && make ) \
	&& ( cd $build_dir && ctest --output-on-failure ./) \
	&& echo -e "Tests ran: \e[92mok\e[39m." \
	|| { echo -e "Tests ran: \e[91mNOPE\e[39m."; false; }
elif [ $# -eq 1 ] && [ "$1" == "debug" ]; then
	# compile with debugging flags
	cmake -S . -B $build_dir -DBUILD_TESTING=OFF -DCMAKE_BUILD_TYPE=Debug && ( cd $build_dir && make ) \
	&& echo -e "You can add target \e[92m${targets[*]}\e[39m to your library." \
	|| { echo -e "Compilation ran: \e[91mNOPE\e[39m."; false; }
elif [ $# -eq 1 ] && [ "$1" == "clean" ]; then
	# clean all files which are specified in .gitignore 
	git clean -d -f -X
elif [ $# -eq 0 ] || [[ $# -eq 1  &&  "$1" == "release" ]]; then
	# compile and copy ${project} binary and lib to root folder
	cmake -S . -B $build_dir -DBUILD_TESTING=OFF -DCMAKE_BUILD_TYPE=RelWithDebInfo && ( cd $build_dir && make ) \
	&& echo -e "You can add target \e[92m${targets[*]}\e[39m to your library." \
	|| { echo -e "Compilation ran: \e[91mNOPE\e[39m."; false; }
else
	cat<<-EOF
	usage:
	  $0         -> compile for release
	  $0 release -> compile for release
	  $0 debug   -> compile for debugging
	  $0 test    -> compile for debugging and test
	  $0 testOpt -> compile for debugging (with optimization flags) and test
	  $0 clean   -> remove build files 
	EOF
fi

