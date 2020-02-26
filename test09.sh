#!/bin/dash
#tests for successful merge + status, log, rm, commit
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

echo "--merge with rm, status--"
echo "a0">a
echo "b0">b
./legit-add a
./legit-commit -m "second"
./legit-branch b1
./legit-add b
./legit-commit -m "third"
./legit-checkout b1
./legit-add b
./legit-commit -m "fourth"
./legit-rm a
./legit-commit -m "fifth"
./legit-checkout master
./legit-merge b1 -m "sixth"
./legit-status #b same as repo a untracked

rm a b 
echo "--merge with log--"
rm -r .legit
./legit-init
seq 1 4 > a
./legit-add a
./legit-commit -m "first"
./legit-branch b1
seq 1 4 > a
perl -pi -e s/2/22/ a
cat a
./legit-add a
./legit-commit -m "second"
./legit-log #0, 1
./legit-checkout b1
./legit-log #0
seq 1 4 >a
perl -pi -e s/1/11/ a
cat a
./legit-add a
./legit-commit -m "third"
./legit-log #0,2
./legit-checkout master
./legit-merge b1 -m "fourth"
./legit-log #0,1,2,3
./legit-show :a
./legit-show 0:a
./legit-show 1:a
./legit-show 2:a
./legit-show 3:a
./legit-checkout b1
./legit-log 

echo "--merge editing multiple lines--"
perl -pi -e s/1/111/ a
perl -pi -e s/2/222/ a
./legit-add a
./legit-commit -m "fifth"
cat a
./legit-checkout master
perl -pi -e s/3/333/ a
perl -pi -e s/4/444/ a
cat a
./legit-add a
./legit-commit -m "sixth"
echo "--merge into a branch--"
./legit-merge master -m "seventh"
./legit-log
./legit-checkout master
./legit-merge b1 -m "eighth"

rm a
echo "--merging with a commit number and deleted lines--"
rm -r .legit
./legit-init
seq 1 4 > a
./legit-add a
./legit-commit -m "first"
./legit-branch b1
seq 1 4 > a
perl -pi -e s/2/22/ a
./legit-add a
./legit-commit -m "second"
./legit-checkout b1
seq 1 4 >a
perl -pi -e s/1/11/ a
sed -i "/3/d" a
cat a
./legit-add a
./legit-commit -m "third"
./legit-checkout master
./legit-merge 0 -m "fourth" #cannot be merged
./legit-merge 1 -m "fourth" #up to date
./legit-merge 2 -m "fifth" 
./legit-log
rm a


