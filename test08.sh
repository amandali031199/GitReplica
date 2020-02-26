#!/bin/dash
#tests for cases that currently am not able to account for and merge cases 
if test -d ".legit"
then
	rm -r ".legit"
fi
./legit-merge #need to init first
echo "--init--"
./legit-init 
./legit-merge # need to commit first
echo "--commit--"
touch a
./legit-add a
./legit-commit -m "first"

echo "--merge wrong args---"
./legit-merge a -m s d #usage
./legit-merge #usage
./legit-merge -m #usage
./legit-merge a #missing message error
./legit-merge a -m #usage
./legit-merge -m s #usage
./legit-merge a s #usage

echo "--unable to find commit or branch--"
./legit-merge b1 -m s
./legit-merge 1 -m s

echo "--merging with current--"
./legit-merge master -m "s" #already up to date 

echo "--merging when same last comm--"
./legit-branch b1
./legit-merge b1 -m s #already up to date

echo "--checkout when new file in created and committed in branch--"
echo "a0">a
./legit-add a
./legit-commit -a -m "second"
./legit-log #first, second
./legit-checkout b1

touch b #unable to checkout because file content in commit for a is different to file content in branch
./legit-add b
./legit-commit -m "third"
./legit-log #first, third
./legit-show 1:a
./legit-checkout master

echo "--fastforward--"
rm -r .legit
rm a b
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
./legit-branch b1
./legit-checkout b1
touch b
echo "a0">a
./legit-commit -a -m "second"
./legit-checkout master
./legit-merge b1 -m "third" 

echo "--merge conflicts same number of lines in file--"
rm -r .legit
./legit-init
rm a
echo "hello">a
./legit-add a
./legit-commit -m "first"
./legit-branch b1
./legit-checkout b1
echo "world">a
./legit-add a
./legit-commit -m "second"
./legit-merge master -m "third" #already up to date
./legit-checkout master
echo "word">a
./legit-add a
./legit-commit -m "third"
./legit-merge b1 -m "fourth" #fails, conflict error
./legit-checkout b1
./legit-merge master -m "fourth"

echo "--merge conflict different number of lines in file--"
rm -r .legit
./legit-init
rm a
echo "hello">a
./legit-add a
./legit-commit -m "first"
echo "world">>a
./legit-commit -a -m "second"
./legit-branch b1
./legit-checkout b1
echo "hello">a
echo "bye">>a
./legit-add a
./legit-commit -m "third"
./legit-merge master -m "fourth" #error
./legit-checkout master
./legit-merge b1 -m "fourth" #error

echo "--merge conflict file not in first commit of branch --"
rm -r .legit
./legit-init
rm a
echo "hello">a
./legit-add a
./legit-commit -m "first"
echo "hello">b
./legit-add b
./legit-commit -m "second"
./legit-branch b1
./legit-checkout b1
echo "world">b
./legit-add b
./legit-commit -m "third"
./legit-merge master -m "fourth" #error
./legit-checkout master
./legit-merge b1 -m "fifth" #error
rm a b

