#!/bin/bash
ctags -R

find $GOPATH/src -name "*.go" -print > cscope.files
if cscope -b -k; then
	echo "Done"
else
	echo "Failed"
fi
