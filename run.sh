#! /bin/bash

FILE=$1
FILE_BACKUP=file-output.txt

if [ -f "$FILE" ]; then
    # 1. How many lines in this file?
    NUMBER_LINES=`awk 'END { print NR }' $FILE`
    echo -e "File has ${NUMBER_LINES} lines\n"

    # 2. How many “Z” Characters in this file?
    CHARACTER_Z_UPPER=`grep -o 'Z' $FILE | wc -l | awk '{print $1}'`
    echo -e "File has ${CHARACTER_Z_UPPER} Z characters - upper case"

    CHARACTER_Z_LOWER=`grep -o 'z' $FILE | wc -l | awk '{print $1}'`
    echo -e "File has ${CHARACTER_Z_LOWER} z characters - lower case"

    CHARACTER_Z_ALL=`grep -o -i 'Z' $FILE | wc -l | awk '{print $1}'`
    echo -e "File has ${CHARACTER_Z_ALL} Z characters in total - not case sensitive\n"

    # 3. Find on which line is “Junior”, “Platform” and “Engineer”, not case sensitive.
    FIND_WORD_LINES=`grep -E -hnr -i 'junior|platform|engineer' $FILE --color=always`
    echo -e "Finding the lines with strings: Junior, Platform and Engineer:\n$FIND_WORD_LINES\n"

    # 4. Change “Junior” to “Senior”
    OS_TYPE=`uname`
    DIR=`pwd`
    cp $FILE $DIR/$FILE_BACKUP
    if [[ "$OS_TYPE" == "Darwin" ]]; then
        echo -e "Replacing string Junior to Senior"
        sed -i '' 's/Junior/Senior/g' $FILE_BACKUP
        grep -E -hnr -i 'senior' $FILE_BACKUP --color=always
    elif [[ "$OS_TYPE" == "Linux" ]]; then
        echo -e "Replacing string Junior to Senior"
        sed -i 's/Junior/Senior/g' $FILE_BACKUP
        grep -E -hnr -i 'junior|senior' $FILE_BACKUP --color=always
    fi
    rm $DIR/$FILE_BACKUP
else 
    echo -e "A file was not passed. Please pass your file!"
    exit 1
fi