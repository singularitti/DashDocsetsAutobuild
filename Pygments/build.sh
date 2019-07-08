#!/bin/bash

version=2.4.1

rm Pygments.tgz
wget https://bitbucket.org/birkenfeld/pygments-main/get/${version}.tar.gz .
tar -xzvf ${version}.tar.gz
(
    cd birkenfeld-pygments* || return
    (
        cd doc || return
        make html
        (
            cd _build/html || return
            doc2dash -n Pygments -u http://pygments.org -v -i ./_static/logo_only.png -f -I index.html -j --destination ../../../../ .
        )
    )
)
tar --exclude='.DS_Store' -cvzf Pygments.tgz Pygments.docset
mkdir versions/${version}
cp Pygments.tgz versions/${version}/
rm -rf birkenfeld-pygments*
rm -rf Pygments.docset
rm ${version}.tar.gz
