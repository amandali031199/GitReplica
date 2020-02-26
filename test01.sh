#!/bin/dash
#testing for init, add, commit error cases 

if test -d ".legit"
then
	rm -r ".legit"
fi

echo "--init excess arg--"
./legit-init a; echo $?  #shows usage error, also checking exit status ALSO CHECK ITS GOING TO STDERR
./legit-init a >/dev/null #should not be empty (empty if its in stdout)
echo "--add before init--"
./legit-add; echo $? # error
echo "--commit before init--"
./legit-commit 


./legit-init; echo $? #shows success message 
rm -r .legit
./legit-init >/dev/null #should be empty because directed to stdout
echo "--recreating .legit--"
./legit-init; echo $? #shows already created error
echo "--no add file provided--"
./legit-add #error 
echo "--no commit message--"
./legit-commit -m 
echo "--commit excess args--"
./legit-commit -a -m -a
echo "--commit args wrong order--"
./legit-commit -m -a "a"
./legit-commit -a "A"

echo "--commit invalid/unusual message--"
./legit-commit -m -a
./legit-commit -m - #no error
./legit-commit -m -1 #no error
./legit-commit -m "a\n"
./legit-commit -a -m "a\n"

echo "--add invalid filenames--"
touch "^"
./legit-add "^"
./legit-add "-m"
./legit-add -1
./legit-add "-"
./legit-add ".A1"

echo "-- add dealing with multiple files--"
./legit-add "." a #error shouldnt add
./legit-add "*" A #error 
./legit-add a A #error shouldnt add 
./legit-commit -m "a" #should print nothing to commit 
touch c b 
./legit-add c b #no errors

echo "--add valid filenames--"
touch "9._-" "A_-b.c1"
./legit-add "9._-" #no errors
./legit-add "A_-b.c1" #no errors

echo "--add files not found in working dir--"
./legit-add a

echo "--add file is not regular--"
mkdir DIR
./legit-add DIR

rm -r DIR c b "9._-" "A_-b.c1" "^"

