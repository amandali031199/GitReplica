#!/bin/dash
#testing branch and checkout error messages 

if test -d ".legit"
then
	rm -r ".legit"
fi

./legit-branch
./legit-checkout
echo "--init--"
./legit-init
./legit-branch
./legit-checkout
echo "--commit--"
touch a
./legit-add a
./legit-commit -m "first"

echo "--branch arg errors--"
./legit-branch a b c 
./legit-branch #only prints master
./legit-branch master #error already exists
./legit-branch a b #usage
./legit-branch a -d #branch a does not exist
./legit-branch a -d b #error
./legit-branch -d #error branch name required

echo "--branch invalid branchnames--"
./legit-branch -
./legit-branch - -d
./legit-branch -m
./legit-branch -m -d
./legit-branch -1
./legit-branch -1 -d
./legit-branch 012
./legit-branch 012 -d
./legit-branch a1.s
./legit-branch a1.s -d
./legit-branch _a1
./legit-branch _a1 -d

echo "--branch valid names--"
./legit-branch a012

echo "--branch delete doesn't exist--"
./legit-branch -d a

echo "--branch delete master --"
./legit-branch -d master 

echo "--branch delete check unmerge and if committed--"

echo "--branch same as repo same as master--"
touch a
./legit-add a
./legit-commit -m "a"
./legit-branch b1
./legit-branch b1 -d #no errors
echo "--branch different to repo different to master --"
touch b
./legit-branch b1
echo "b0">b
./legit-add b
./legit-commit -m "b"
echo "b1">b
./legit-branch b1 -d #no errors (mine says unmerge)

rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
echo "--branch same as repo, master diff--"
touch c
./legit-add c
./legit-commit -m "c"
./legit-branch b2
echo "c0">c 
./legit-branch b2 -d #no errors (mine says unmerge)
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
echo "--branch same as master, repo diff--"
touch d
./legit-add d
./legit-commit -m "d"
echo "d0">d
./legit-branch b3
./legit-branch b3 -d #no errors (mine says unmerge)
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"

echo "--repo same as master, branch diff--"
touch e
./legit-branch b4
echo "e0">e
./legit-add e
./legit-commit -m "e"
./legit-branch b4 -d #no errors (mine says unmerge)
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
echo "--file in branch and master, not in repo, diff--"
touch f
./legit-branch b5
echo "f0">f
./legit-branch b5 -d #no errors 
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
echo "--file in branch and master, not in repo, same-"
touch g
./legit-branch b6
./legit-branch b6 -d #no errors 
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
echo "--file in branch and repo, not in master, diff--"
touch h
./legit-branch b7
echo "h0">h
./legit-add h
./legit-commit -m "h"
rm h
./legit-branch b7 -d #no errors 
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
echo "--file in branch and repo, not in master, same--"
touch i
./legit-branch b8
./legit-add i
./legit-commit -m "i"
rm i
./legit-branch b8 -d #no errors 
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
echo "--file in repo and master, not in branch, diff--"
./legit-branch b9
touch j
./legit-add j
./legit-commit -m "j"
echo "j0">j
./legit-branch b9 -d #no errors
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
echo "--file in repo and master, not in branch, same--"
./legit-branch b10
touch j
./legit-add j
./legit-commit -m "j"
./legit-branch b10 -d #no errors
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"

echo "--file in branch, not in repo or master--"
touch k
./legit-branch b11 
rm k 
./legit-branch b11 -d #no errors
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
echo "--file in repo, not in branch or master--"
./legit-branch b12
touch l
./legit-add l
./legit-commit -m "l"
rm l
./legit-branch b12 -d #no errors
rm -r .legit
./legit-init
touch a
./legit-add a
./legit-commit -m "first"
echo "--file in master, not in branch or repo--"
./legit-branch b13
touch m
./legit-branch b13 -d #no errors

rm a b c d e f g h i j k l m



