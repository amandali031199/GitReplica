#!/bin/dash
#testing checkout error cases, working with checkout and branch's interaction with log,show, commit, status, rm


if test -d ".legit"
then
	rm -r ".legit"
fi

echo "--init--"
./legit-init
echo "--commit--"
touch a
./legit-add a
./legit-commit -m "first"

echo "--excess args--"
./legit-checkout a b
./legit-checkout

echo "--branch doesnt exist--"
./legit-checkout a
echo "--already on--"
./legit-checkout master

echo "--correct usage--"
./legit-branch b2 #com, branch, check, edit
./legit-checkout b2
echo "a0">a
touch c
./legit-checkout master #files updated
cat a
echo "--merge error when overwriting--"
./legit-branch b3 #branch, com, check, edit merge error
./legit-add a
./legit-commit -m "a"
./legit-checkout b3
cat a #a0 
echo "a1">a
./legit-checkout master 

rm -r a  c 
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
#making branch of branch
#deleting a branch when you're on a branch
#log: only print branches commits, maybe skip ones e.g. 0, 2
./legit-branch b1
echo "a0">a
./legit-add a
./legit-commit -a -m "second"
./legit-log #first, second
./legit-checkout b1
./legit-log #first
./legit-show 1:a
./legit-show :a
cat a
echo "a1">a
./legit-add a
./legit-commit -m "third"
./legit-log #first, third
./legit-show 1:a
./legit-checkout master
./legit-log #first, second
./legit-show 2:a  ##if ur adding a new file here: unmerge is activated

rm -r a
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
echo "--rm and checkout--"
./legit-branch b1
./legit-checkout b1
echo "a0">a
./legit-add a
rm a #current program unable to distinguish between removed files, and files that just weren't created in the branch
./legit-checkout master
./legit-status #file deleted, different changes staged for commit
./legit-commit -m "first"
./legit-status #file deleted



rm -r a b c d e f g h i j k l m
