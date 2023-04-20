#!/bin/bash

TEMPLATE_DIRECTORY=.

if [ -z "$1" ]; then # check if project name is null
echo "Project must have a name"
exit	
fi

PROJECT_NAME=$1
SCRIPT_DIR="$( cd -- "$( dirname -- "{BASH_SOURCE[0]}" )" &> /dev/null && pwd )" # create a variable to store location of script execution
TEMPLATE_DIRECTORY=$SCRIPT_DIR

CURRENT_DATE=$(date +"%D %T")
echo $CURRENT_DATE


#sed -i "s/"'PROGENY_PROJECT_NAME'"/$1/g" ./* ## replace placeholder values with project name
#sed -i "s*"'PROGENY_CURRENT_DATE'"*$CURRENT_DATE*g" ./* ## replace placeholder values with project creation date

find . -type f -exec sed -i "s%PROGENY_PROJECT_NAME%$1%g" {} \; #Update project name in scripts
find . -type f -exec sed -i "s%PROGENY_CURRENT_DATE%$CURRENT_DATE%g" {} \;

mv library/src/PROGENY_PROJECT_NAME.cpp library/src/$1.cpp #Rename library files
mv library/inc/PROGENY_PROJECT_NAME.h library/inc/$1.h

# delete leftover files
rm progeny.sh
echo "Done with setup"






