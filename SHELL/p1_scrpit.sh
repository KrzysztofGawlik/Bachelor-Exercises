#!/bin/bash
set -o history

# Pause function (gives user more control)
function pause(){
   read -p "$*"
}

function find_and_copy(){
    DST_FILE="test.txt"
    echo "************************************************"
    echo "Available files:"
    ls -1
    echo "Enter the name of the file you want to copy from: "
    read USER_FILE
    if [ -f "$USER_FILE" ]; then
        echo "### File ${USER_FILE} found. Copying content..."
        > $DST_FILE
        while read LINE; do
            echo "$LINE" >> "$DST_FILE"
        done < $USER_FILE
    else
        pause "There is no such file! Try again..."
        find_and_copy
    fi
}

# Creating .txt, *dok* and other files
echo "### Creating some .txt files..."
QTY=3
while [ "$QTY" -gt 0 ]; do
    echo "Automatically generated txt file no. $QTY" > text_file_${QTY}.txt
    echo "text_file_${QTY} created."
    let QTY--
done
QTY=3
while [ "$QTY" -gt 0 ]; do
    echo "Automatically generated pdf file no. $QTY" > dok_file_${QTY}.pdf
    echo "dok_file_${QTY} created."
    let QTY--
done
QTY=3
while [ "$QTY" -gt 0 ]; do
    echo "Automatically generated odt file no. $QTY" > odt_file_${QTY}.odt
    echo "odt_file_${QTY} created."
    let QTY--
done
pause "Press any key to create new directory and move .txt files and named with *dok*..."

# Creating directory and moving .txt and *dok* files to it
DIR_NAME="tekstowe"
echo "### Creating '${DIR_NAME}' directory..."
mkdir $DIR_NAME
echo "Directory named '${DIR_NAME}' created."
echo "### Moving .txt and *dok* files..."
find . -type f -name "*.txt" > temp.txt
find . -type f -name "*dok*" >> temp.txt
while read FILE_NAME; do
    if [ $FILE_NAME != "./temp.txt" ]; then
        mv $FILE_NAME $DIR_NAME
        echo "File ${FILE_NAME} moved to ${DIR_NAME} directory."
    fi
done < temp.txt
rm temp.txt
pause "Press any key to copy content from one file to another..."

# Reading file name form user and copying content to 'test' file
cd tekstowe
find_and_copy
cd ..
echo "Copying finished. Destination file: '${DST_FILE}'."
pause "Press any key to add writing privileges for all users for all files..."

# Changing privileges - write for all users for all files
echo "Adding writing privileges to all files in this directory..."
find ./$DIR_NAME/ -type f -exec chmod ugo+w {} \;
pause "Press any key to save and display logs and other information..."

# Printing and saving
echo -e "\n************************************************"
echo "COMMANDS HISTORY SAVED TO $1"
echo "************************************************"
history -a $1

# - wyświetlenie zawartości właśnie wykonywanego skryptu
echo -e "\n************************************************"
echo "CONTENT OF EXECUTED SCRIPT"
echo "************************************************"
while read LINE; do
    echo -e "\033[3m${LINE}\033[0m"
done < ${0##*/}

# - wyświetlenie szczegółowych danych o zawartości aktualnego katalogu
echo -e "\n************************************************"
echo "DETAILS OF CURRENT DIRECTORY CONTENT"
echo "************************************************"
ls -l

# - zapisanie wyświetlonych informacji w statystyka.dat
ls -l > statystyka.dat

# - przeniesienie tego pliku do katalogu domowego użytkownika
mv ./statystyka.dat ~/
echo -e "\n************************************************"
echo "DETAILS SAVED IN 'statystyka.dat' AND MOVED TO HOME DIRECTORY"
echo "************************************************"

pause "Press Enter to quit..."
exit 0