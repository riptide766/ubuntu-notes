#! /bin/bash

target="../ubuntubooks_pages"
source="build/build/html"

git st | grep -q "nothing to commit" 

if [ $? -eq 0 ] ; then
	rm -vrf $target/books
	cp -vR $source $target/books
	cd $target 
	git add .
	git commit -a -m "例行发布"
	git push origin gh-pages
else
	git status
fi

