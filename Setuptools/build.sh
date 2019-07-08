#!/bin/bash

version=v41.0.1
name=Setuptools

(
    cd ${name} || return
    git clone git@github.com:pypa/setuptools.git
    (
        cd setuptools || return
        git checkout ${version}
        (
            cd docs || return
            make html
            (
                cd _build/html || return
                doc2dash -n ${name} -u https://setuptools.readthedocs.io/en/stable/ -v -f -I index.html -j --destination ../../../../ .
            )
        )
    )
)
tar --exclude='.DS_Store' -cvzf ${name}.tgz ${name}.docset
mkdir versions/${version}
cp ${name}.tgz versions/${version}/
rm -rf setuptools
rm -rf ${name}.docset
