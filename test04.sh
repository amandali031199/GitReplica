#!/bin/dash
#testing cases for rm 

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
echo "--file doesn't exist already in workin dir, has been committed, index same as commit--"
rm a
./legit-rm --cached a #no errors
./legit-show :a #doesn't exist
touch a
./legit-add a
./legit-rm --force a #same
./legit-show :a #doesn't exist
touch a
./legit-add a
./legit-rm --cached --force a #same
./legit-show :a #doesn't exist
touch a
./legit-add a
./legit-rm a #no errors, removes from index 
./legit-show :a #doesn't exist
echo "--file doesn't exist already in workin dir, has been committed, index not same as commit--"
touch a
./legit-add a
./legit-commit -m "second" #nothing to commit
echo "a0">a
./legit-add a
rm a
echo "##finished setting up##"
./legit-rm a #no errors
./legit-show :a
touch a
./legit-add a
./legit-commit -m "second"
echo "a0">a
./legit-add a
rm a
echo "##finished setting up##"
./legit-rm --cached a #no errors
./legit-show :a
touch a
./legit-add a
./legit-commit -m "second"
echo "a0">a
./legit-add a
rm a
echo "##finished setting up##"
./legit-rm --force a
./legit-show :a
touch a
./legit-add a
./legit-commit -m "second"
echo "a0">a
./legit-add a
rm a
echo "##finished setting up##"
./legit-rm --force --cached a
./legit-show :a
echo "--file doesn't exist already in workin dir, has not been committed--"
echo "b0">b
./legit-add b
rm b
echo "##finished setting up##"
./legit-rm b #no errors
./legit-show :b
echo "b0">b
./legit-add b
rm b
echo "##finished setting up##"
./legit-rm --cached b
./legit-show :b
echo "b0">b
./legit-add b
rm b
echo "##finished setting up##"
./legit-rm --force b
./legit-show :b
echo "b0">b
./legit-add b
rm b
echo "##finished setting up##"
./legit-rm --cached --force b
./legit-show :b
echo "--file doesn't exist already in index, has been committed, working same as commit--"
echo "b0">b
./legit-add b
./legit-commit -m "second"
./legit-rm --cached b
echo "##finished setting up##"
./legit-rm b #error 
./legit-rm --cached b #error
./legit-rm --force b #error
./legit-rm --cached --force b #error
echo "--file doesn't exist already in index, has been committed, working not same as commit--"
echo "b1">b
echo "##finished setting up##"
./legit-rm b #error 
./legit-rm --cached b #error
./legit-rm --force b #error
./legit-rm --cached --force b #error
echo "--file doesn't exist already in index, has not been committed --"
touch c
./legit-add c
./legit-rm --cached c
echo "##finished setting up##"
./legit-rm c #error
./legit-rm --cached c
./legit-rm --force c
./legit-rm --cached --force c
echo "--file doesn't exist in both, has been committed--"
./legit-add c
./legit-commit -m "third"
./legit-rm c
./legit-show :c
echo "##finished setting up##"
./legit-rm c #errors
./legit-rm --cached c
./legit-rm --force c
./legit-rm --cached --force c
echo "--file doesn't exist in both, has not been committed--"
touch c
./legit-add c
./legit-rm c
echo "##finished setting up##"
./legit-rm c #errors
./legit-rm --cached c
./legit-rm --force c
./legit-rm --cached --force c
echo "--file exists in both, has been committed, index commit working all same --"
touch c a b d
./legit-add c a b d
./legit-commit -m "fourth"
./legit-rm a
./legit-show :a
./legit-rm --cached b
./legit-show :b
./legit-rm --force c
./legit-show :c
./legit-rm --cached --force d
./legit-show :d
echo "--file exists in both, has been committed, index commit working all not same --"
touch a b c d 
./legit-add a b c d
./legit-commit -m "fifth"
echo "1">a
echo "1">b
echo "1">c
echo "1">d
./legit-add a b c d
echo "2">a
echo "2">b
echo "2">c
echo "2">d
./legit-rm a #error changes in all diff
./legit-rm --cached b #error changes in all diff
./legit-rm --force c
./legit-show :c
./legit-rm --force --cached d
./legit-show :d
echo "--file exists in both, has been committed, index same as working, commit diff --"
echo "0">a
echo "0">b
echo "0">c
echo "0">d
./legit-add a b c d
./legit-commit -m "sixth"
echo "1">a
echo "1">b
echo "1">c
echo "1">d
./legit-add a b c d
./legit-rm a
./legit-rm --cached b 
./legit-show :b #exists still in working but deleted from index
ls b
./legit-rm --force c #deleted from both
./legit-show :c
ls c
./legit-rm --cached --force d #deleted from index still in working
./legit-show :d
ls d
echo "--file exists in both, has been committed, index same as commit, working diff --"
echo "0">a
echo "0">b
echo "0">c
echo "0">d
./legit-add a b c d
./legit-commit -m "seventh"
echo "1">a
echo "1">b
echo "1">c
echo "1">d
./legit-rm a #error working dir file diff to repo
./legit-rm --cached b #no error, still in working
./legit-show :b
ls b
./legit-rm --force c #no error, deleted from both
./legit-show :c
ls c
./legit-rm --cached --force d # no error, still in working
./legit-show :d
ls d
echo "--file exists in both, has been committed, working same as commit, index diff --"
echo "0">a
echo "0">b
echo "0">c
echo "0">d
./legit-add a b c d
./legit-commit -m "eighth"
echo "1">a
echo "1">b
echo "1">c
echo "1">d
./legit-add a b c d 
echo "0">a
echo "0">b
echo "0">c
echo "0">d
./legit-rm a # error
./legit-rm --cached b #error
./legit-rm --force c #remove from both
./legit-show :c
ls c
./legit-rm --cached --force d #remove only from index
./legit-show :d
ls d
echo "--file exists in both, has not been committed, same--"
echo "0">e
echo "0">f
echo "0">g
echo "0">h
./legit-add e f g h
./legit-rm e #error 
./legit-rm --cached f  #deleted from index
./legit-show :f
ls f
./legit-rm --force g #delete from both
./legit-show :g
ls g
./legit-rm --cached --force h #delete from index
./legit-show :h
ls h
echo "--file exists in both, has not been committed, diff--"
echo "0">e
echo "0">f
echo "0">g
echo "0">h
./legit-add e f g h
echo "1">e
echo "1">f
echo "1">g
echo "1">h
./legit-rm e #error
./legit-rm --cached f #delete from index
./legit-show :f
ls f
./legit-rm --force g #delete from both
./legit-show :g
ls g
./legit-rm --cached --force h #delete from index
./legit-show :h
ls h

echo "--remove from working and index, add, has been committed--"
touch i
./legit-add i
./legit-commit -m "i"
./legit-rm i
./legit-add i #unable to open file
./legit-show :i



rm -r a b d e f h 
