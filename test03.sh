#!/bin/dash
# error cases for rm and status 
if test -d ".legit"
then
	rm -r ".legit"
fi

echo "--rm before init--"
./legit-rm 
echo "--status before init--"
./legit-status
echo "--init but no commits yet--"
./legit-init
./legit-rm
./legit-status
echo "--commit a file--"
touch a 
./legit-add a
./legit-commit -m "first"
echo "--rm no file supplied--"
./legit-rm --cached
./legit-rm --force
./legit-rm --force --cached 
./legit-rm
echo "--status args--"
./legit-status a b c #still works 
./legit-status -1
echo "--status dir--"
mkdir DIR
./legit-status -m #should not print DIR
./legit-status - #all still works and should print the same
echo "--rm dir--"
./legit-add DIR #can't add non-reg files
./legit-rm --cached DIR #error not in index (cant be added to index)
./legit-rm DIR #error
./legit-rm --force --cached DIR  #error
./legit-rm --force DIR #error 
echo "--rm invalid filename--"
./legit-rm -1
./legit-rm -
./legit-rm -a
./legit-rm -m
./legit-rm .

echo "--rm invalid flags--"
./legit-rm --a a
./legit-rm --forced a
./legit-rm --cache a
./legit-rm --force --cache a
./legit-rm --1 a
./legit-rm -force a
./legit-rm -cached a
./legit-rm -force -cached a

rm -r DIR a 
