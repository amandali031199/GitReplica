#!/bin/dash
#testing all cases for status 
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

echo "--file exists only in working, never added, never committed--"
touch b
./legit-status #b untracked

echo "--file add, commit, change, add, exists only in commit--"
echo "a0">a
./legit-add a
./legit-rm --force a
./legit-status #a deleted

echo "--file add, commit, change, add, exists only in index--"
echo "a0">a
./legit-add a
./legit-commit -m "a"
echo "a1">a
./legit-add a
rm a
./legit-status #a deleted, different changes staged for commit 

echo "--file add, commit, change, add, exists only in working--"
echo "a0">a
./legit-add a
./legit-commit -m "a"
echo "a1">a
./legit-add a
./legit-rm --cached --force a
./legit-status #a untracked

echo "--file add, commit, change, add, exists only in working and index NORMAL--"
echo "a0">a
./legit-add a
./legit-commit -m "a"
echo "a1">a
./legit-add a
./legit-status #a changed, changes staged for commit

echo "--file add, commit, exists only in commit--"
touch c
./legit-add c
./legit-commit -m "c"
./legit-rm --force c
./legit-status #c deleted

echo "--file add, commit, exists only in working and commit--"
touch c
./legit-add c
./legit-commit -m "c"
./legit-rm --cached --force c
./legit-status #c untracked

echo "--file add, commit, exists only in index and commit--"
touch c
./legit-add c
./legit-commit -m "c"
rm c
./legit-status #c file deleted

echo "--file add, commit, exists in all NORMAL--"
touch c
./legit-add c
./legit-commit -m "c"
./legit-status #c same as repo

echo "--file add, exists only in index--"
touch d
./legit-add d
rm d
./legit-status #d added to index

echo "--file add, exists only in working--"
touch d
./legit-add d
./legit-rm --cached --force d
./legit-status #d untracked

echo "--file add, exists only in index and working NORMAL--"
touch d
./legit-add d
./legit-status #d added to index

echo "--file add, commit, change, exists only in commit--"
touch e
./legit-add e
./legit-commit -m "e"
echo "e0">e
./legit-rm --force e
./legit-status #e deleted
echo "--file add, commit, change, exists only in index--"
touch e
./legit-add e
./legit-commit -m "e"
echo "e0">e
rm e
./legit-status #e file deleted
echo "--file add, commit, change, exists only in working NORMAL--"
touch e
./legit-add e
./legit-commit -m "e"
echo "e0">e
./legit-status #e file changed, not staged for commit
echo "--file add, commit, change, exists only in working, remove from index--"
touch e
./legit-add e
./legit-commit -m "e"
echo "e0">e
./legit-rm --cached --force e
./legit-status #e untracked

echo "--file add, commit, change, add, change, remove index --"
touch f
./legit-add f
./legit-commit -m "f"
echo "f0">f
./legit-add f
echo "f1">f
./legit-rm --cached --force f
./legit-status #f untracked

echo "--file add, commit, change, add, change, remove working --"
touch f
./legit-add f
./legit-commit -m "f"
echo "f0">f
./legit-add f
echo "f1">f
rm f
./legit-status #f file deleted, different changes staged for commit

echo "--file add, commit, change, add, change, remove index and working --"
touch f
./legit-add f
./legit-commit -m "f"
echo "f0">f
./legit-add f
echo "f1">f
./legit-rm --force f
./legit-status #f deleted

echo "--file add, commit, change, add, change --"
touch f
./legit-add f
./legit-commit -m "f"
echo "f0">f
./legit-add f
echo "f1">f
./legit-status #f file changed different changes staged for commit

rm -r a b c d e f
