#!/bin/bash
#
#
# Date:
# Author: riptide <riptide766@gmail.com>

action=$1
build_dir=build
rdirs=("_images" "_static" "_sources")
#source_list=("ubuntu" "index.rst")

# cleanup
_sourcescleanup(){
rm -rf source/ubuntu
rm -rf source/index.rst
cp -R ../books/ubuntu source/ubuntu
cp -R ../books/ubuntubook.rst source/index.rst
echo sources cleanup... done
}

_buildcleanup(){
rm -rf build/*
echo build cleanup... done
}

# make
_make(){
	make html
	echo make... done
}

# fix by sed
_fixlink(){
for crtdir in ${rdirs[*]} ; do
find build/html -name "*.html" -exec sed -i "s/$crtdir/b$crtdir/g" {} \;
rm -rf ./build/html/b$crtdir
mv ./build/html/$crtdir ./build/html/b$crtdir
done;
echo fixlink... done
}

cd $build_dir
for act in $@ ; do
	_$act
done

