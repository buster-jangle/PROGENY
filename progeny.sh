#!/bin/bash

TEMPLATE_DIRECTORY=.

PROJECT_NAME=$(basename $PWD)
echo "Creating: $PROJECT_NAME"

SCRIPT_DIR="$( cd -- "$( dirname -- "{BASH_SOURCE[0]}" )" &> /dev/null && pwd )" # create a variable to store location of script execution
TEMPLATE_DIRECTORY=$SCRIPT_DIR

CURRENT_DATE=$(date +"%D %T")
echo $CURRENT_DATE


#sed -i "s/"'PROGENY_PROJECT_NAME'"/$PROJECT_NAME/g" ./* ## replace placeholder values with project name
#sed -i "s*"'PROGENY_CURRENT_DATE'"*$CURRENT_DATE*g" ./* ## replace placeholder values with project creation date

find . -type f -exec sed -i "s%PROGENY_PROJECT_NAME%$PROJECT_NAME%g" {} \; #Update project name in scripts
find . -type f -exec sed -i "s%PROGENY_CURRENT_DATE%$CURRENT_DATE%g" {} \;

mv library/src/PROGENY_PROJECT_NAME.cpp library/src/$PROJECT_NAME.cpp #Rename library files
mv library/inc/PROGENY_PROJECT_NAME.h library/inc/$PROJECT_NAME.h

#reset git index
rm -f .git/index
git reset

# delete leftover files
rm progeny.sh
echo "Done with setup"






