#! /bin/bash

trap "echo '*** BUILD FAILED! ***' 1>&2" ERR
set -ex -o pipefail
umask 022
export PATH='/bin:/usr/bin:/usr/local/bin'
export CFLAGS=${CFLAGS:--Os}
export CXXFLAGS=${CXXFLAGS:--Os}

rebuild () {
    tar xzf ipkg-utils-1.7.tar.gz
    pushd ipkg-utils-1.7
    bunzip2 -c ../ipkg-utils-1.7-wildcardfix.patch.bz2 | patch -p1 -b
    bunzip2 -c ../ipkg-utils-1.7-unbuildfix.patch.bz2 | patch -p1 -b
    make
    sudo make install
    popd
}

#while read FN; do
#    eval "[ -e $FN ] || rebuild"
#done < MANIFEST
rebuild

