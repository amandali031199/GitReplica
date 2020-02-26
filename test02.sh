#!/bin/dash
#testing add, commit, log, show cases
if test -d ".legit"
then
	rm -r ".legit"
fi

echo "--init--"
./legit-init 

echo "--commit -a when it doesn't exist in index--"
touch a b
./legit-commit -a -m "first" #nothing to commit
./legit-add a
echo "--commit -a when it exists in index and modified--"
echo "a0">a
./legit-commit -a -m "first" #commits 
./legit-log
./legit-show 0:a
./legit-show 0:b #error b isnt in commit or index 

echo "--commit when no change--"
./legit-commit -a -m "second" #nothing to commit 
./legit-add a
./legit-commit -m "second" #nothing to commit 

echo "--commit -a doesn't exist in index but modified--"
echo "b0">b
./legit-commit -a -m "second" #nothing to commit
./legit-add b
./legit-show 0:b #error b is in index but not in commit 
./legit-show :b #b0
./legit-rm --cached b
./legit-commit -m "second" #nothing to commit 

echo "--commit when it exists in index and modified but not added--"
echo "a1">>a
./legit-commit -m "second" #nothing to commit 


echo "--commit a different file--"
./legit-add b
./legit-commit -m "second" #commits 
./legit-log #0,1
./legit-show 0:b #error b doesnt exist
./legit-show 1:b #exists 
./legit-show 1:a #exists but not changed 
./legit-commit -a -m "third" #commits 
./legit-log #0,1,2
./legit-show 2:a #updated
./legit-show 2:b #no change 

echo "--commit and add changes to multiple files at once--"
echo "b1">b
echo "a2">a
./legit-commit -a -m "fourth" #commits
./legit-log #0,1,2,3
./legit-show 3:a #updated
./legit-show 3:b #updated

echo "--show swapping filename and commit number--"
./legit-show a:3 #error unknown commit a

echo "--commit changing file back to original--"
echo "a1">a
./legit-commit -a -m "fifth" #commits 
./legit-log #0,1,2,3,4
./legit-show 4:a #updated shows a1
./legit-show 3:a #shows a2

echo "--add file, remove from working dir, commit --"
echo "a2">a
./legit-add a
rm a
./legit-show :a #still exists a2
./legit-add a #works, removes a from index
./legit-show :a #error doesnt exist
./legit-add a #error cannot open a
./legit-commit -a -m "sixth" #commits because index is diff now 
./legit-log #0,1,2,3,4,5
./legit-show 5:a #doesnt exist 
./legit-show 5:b #exists

echo "--change file, add, change file, show--"
echo "b2">b
./legit-add b
echo "b3">b
./legit-show 5:b #no change b1
./legit-show :b #b2
./legit-add b
./legit-show :b #b3

rm b

