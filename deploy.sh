#! /bin/bash

git st | grep -q "nothing to commit" 

if [ $? -eq 0 ] ; then
	rm -vrf ../ubuntubooks_pages/books
	cp -vR build/build/html ../ubuntubooks_pages/books
	cd ../ubuntubooks/ 
	git add .
	git commit -a -m "例行发布"
	git status
	git push origin gh-pages
else
	echo "还不能发布"
fi

