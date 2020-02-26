#!/bin/dash
#testing for add and -a commit correct usage, log and show error cases

if test -d ".legit"
then
	rm -r ".legit"
fi

mkdir DIR
echo "--log before init--"
./legit-log
echo "--show before init--"
./legit-show
./legit-init
echo "--no commits yet--"
./legit-log
./legit-show
touch a
echo b>a
./legit-add a
./legit-add a #no errors, doesn't change anything
./legit-commit -m "first"
echo "--show not enough args--"
./legit-show 
echo "--log excess args--"
./legit-log a #error
./legit-log #shows "0 first"
echo "--show invalid args--"
./legit-show a
./legit-show -1
./legit-show -a
./legit-show -
./legit-show "a:"
./legit-show "-1:"
./legit-show "-a:"
./legit-show "-:"
./legit-show "#:"
./legit-show "#"
./legit-show ";:"
./legit-show ";"
./legit-show ">:"
./legit-show ">"
./legit-show "<:"
./legit-show "<"
touch "9._-" "A_-b.c1"
echo hi>"9._-"
echo world>"A_-b.c1"
./legit-show "0:"
./legit-show "2:"
./legit-show "a:-A9."
./legit-show "0:.A."
./legit-show ":."
echo "--show not found--"
./legit-show ":9._-"
./legit-show ":c"
./legit-add "A_-b.c1"
./legit-show "0:9._-"
./legit-show "0:c"
echo "--show test when file is in index but not in commit--"
./legit-show ":A_-b.c1"
./legit-show "0:A_-b.c1"
echo "--show test when file is in commit but not in index--"
echo "a">a
./legit-commit -a -m "second"
./legit-rm --cached "A_-b.c1"
./legit-show ":A_-b.c1"
./legit-show "1:A_-b.c1"
echo "--show test different commits--"
./legit-show "0:A_-b.c1"
./legit-show "0:a"
./legit-show "1:a"
echo "--showing a dir--"
./legit-show "1:DIR"


rm -r "a" "9._-" "A_-b.c1" "DIR"


#add: 2 cases, if file is in working dir or not
#commit: 2 cases, if file is in index or not
