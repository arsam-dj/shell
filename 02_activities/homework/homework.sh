#!/bin/bash

# On your terminal, input all the commands you have used to create the following:

# 1. How would you create 5 directories? Feel free to use any name for your directories.
mkdir dir{1..5}

# 2. How would you verify the creation of all 5 directories?
ls

# 3. In each directory, how would you create 5 .txt files and write "I love data" into each within the directories?
touch dir{1..5}/text{1..5}.txt
find dir{1..5} -type f -name "text*.txt" -exec bash -c 'echo -n "I love data" > "$1"' _ {} \;
    # find dir{1..5} -type f -name "text*text": get path of all text files within the five directories
    # -exec bash -c ...: execute shell command to append "I love data" to each matched file
        # bash -c 'command' _ arg1 arg2 ...
            # bash -c runs new instance of bash shell to execute 'command'
            # _ is placeholder for $0 (script name)
            # {} represents additional arguments (arg1, arg2, argn) and these become $1, $2, $n in script
                # {} is substituted by find and $1 represents a text file path
    # For example, find finds 'dir1/text1.txt'. The bash -c command becomes bash -c 'echo "I love data" >> "$1"' _ dir1/text1.txt
        # $0: _ (ignored in this case)
        # $1: dir1/text1.txt
    # \; (; escaped by backslash since it's a special character) tells find where -exec command ends
        # always required when doing -exec commands

# 4. How would you verify the presence of all 5 files?
ls dir*

# 5. How would you append to one of the existing files " and machine learning!"?
echo -n " and machine learning" >> dir1/text1.txt
    # -n prevents echo from creating newlines (it was also used in step 3 above)

# 6. How would you verify that the text was indeed appended to the existing file?
less dir1/text1.txt

# 7. How would you delete all files except for the one with the appended text?
find dir{1..5} -type f -name "text*.txt" -not -wholename "dir1/text1.txt" -exec bash -c 'rm "$1"' _ {} \;
    # -not -wholename "dir1/text1.txt" removes dir1/text1.txt from the find list, and then bash command removes everything else

# 8. How would you navigate back to the parent directory containing all the directories?
    # N/A, already in parent directory because I needed to be for step 7 to work. However, if I was in dir1 then I would just
    # do cd ..

# 9. How would you remove each directory along with its contents?
rm -r dir*

# 10. How would you verify that all directories and files have been deleted?
ls 
    # should be blank