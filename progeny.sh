#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TEMPLATE_DIRECTORY=$SCRIPT_DIR

if [ -z "$1" ]; then # check if project name is null
echo "Project must have a name"
exit	
fi

PROJECT_NAME=$1

SCRIPT_DIR="$( cd -- "$( dirname -- "{BASH_SOURCE[0]}" )" &> /dev/null && pwd )" # create a variable to store location of script execution


CURRENT_DATE=$(date +"%D %T")
echo $CURRENT_DATE
#rm -r $1 # test code, deletes project if recreated

mkdir $PROJECT_NAME || exit
cp -a $TEMPLATE_DIRECTORY/. $PROJECT_NAME/

#mkdir app || exit
cd $PROJECT_NAME || exit


#sed -i "s/"'PROGENY_PROJECT_NAME'"/$1/g" ./* ## replace placeholder values with project name
#sed -i "s*"'PROGENY_CURRENT_DATE'"*$CURRENT_DATE*g" ./* ## replace placeholder values with project creation date

find . -type f -exec sed -i "s%PROGENY_PROJECT_NAME%$1%g" {} \;
find . -type f -exec sed -i "s%PROGENY_CURRENT_DATE%$CURRENT_DATE%g" {} \;

mv library/src/PROGENY_PROJECT_NAME.cpp library/src/$1.cpp
mv library/inc/PROGENY_PROJECT_NAME.h library/inc/$1.h

#copy gitignore template
rm -rf .git
rm -rf .gitmodules
rm -r submodule/plog
rm -r submodule/CLI11
rm progeny.sh

git init #create git repo

git submodule add git@github.com:SergiusTheBest/plog.git submodule/plog
git submodule add git@github.com:CLIUtils/CLI11.git submodule/CLI11

git add .
git commit -m "Initial commit by PROGENY upon creation of repo"

#cd build
#cmake ..
#make -j4

#cd ..

echo "Done with setup"

if [ $2 == "-g" ]
then # -gh flag creates a new github repo for the project
	echo "Creating GitHub repo"
	echo "\n" | gh repo create $PROJECT_NAME --private --source=. --remote=upstream
	#echo $1 # description is name of project
	#echo "Yes" # agree to add origin remote to local repository
	echo ""
	if [ $? -eq 0 ]
 	   then
	   echo OK
	   git remote add origin git@github.com:buster-jangle/$PROJECT_NAME.git
	   git push --set-upstream origin master
	else
	   echo "Failed to create GitHub repo"
	   exit
	fi
fi

#cd $PROJECT_NAME





