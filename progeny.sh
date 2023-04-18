#!/bin/bash

TEMPLATE_DIRECTORY="$HOME/Documents/CPPDEV/templates"

if [ -z "$1" ]; then # check if project name is null
echo "Project must have a name"
exitcd /Doc	
fi

PROJECT_NAME=$1

SCRIPT_DIR="$( cd -- "$( dirname -- "{BASH_SOURCE[0]}" )" &> /dev/null && pwd )" # create a variable to store location of script execution


CURRENT_DATE=$(date +"%D %T")
echo $CURRENT_DATE
#rm -r $1 # test code, deletes project if recreated

mkdir $PROJECT_NAME || exit
cp -R templates/*  $PROJECT_NAME

#mkdir app || exit
cd $PROJECT_NAME

#mkdir bin
##mkdir build
#mkdir doc
#mkdir inc
#mkdir src
#mkdir experiments

#cd ..

#mkdir library || exit
#cd library

#mkdir build
#mkdir doc
#mkdir inc
#mkdir src
#mkdir lib

#create gir ignore, to ignore compiled files
echo "
# Ignore the build and lib dirs
build
lib
# Ignore any executables

bin

# Ignore Mac specific files
.DS_Store
" > .gitignore

#create cmake template
sed -i "s/"'$PROJECT_NAME'"/$1/g" CMakeLists.txt ## replace placeholder values with
sed -i "s/"'$PROJECT_NAME'"/$1/g" application/CMakeLists.txt ## replace placeholder values with
sed -i "s/"'$PROJECT_NAME'"/$1/g" library/CMakeLists.txt ## replace placeholder values with project name

#create main.cpp template
sed -i "s/"'$PROJECT_NAME'"/$1/g" application/src/main.cpp ## replace placeholder values with project name
sed -i "s*"'$CURRENT_DATE'"*$CURRENT_DATE*g" application/src/main.cpp ## replace placeholder values with project name

#create main.h template
sed -i "s/"'$PROJECT_NAME'"/$1/g" application/inc/main.h ## replace placeholder values with project name
sed -i "s*"'$CURRENT_DATE'"*$CURRENT_DATE*g" application/inc/main.h ## replace placeholder values with project name

#create lib.cpp template
mv library/src/lib.cpp library/src/$PROJECT_NAME.cpp
sed -i "s/"'$PROJECT_NAME'"/$1/g" library/src/$PROJECT_NAME.cpp ## replace placeholder values with project name
sed -i "s*"'$CURRENT_DATE'"*$CURRENT_DATE*g" library/src/$PROJECT_NAME.cpp ## replace placeholder values with project name

#create lib.h template
mv library/inc/lib.h library/inc/$PROJECT_NAME.h
sed -i "s/"'$PROJECT_NAME'"/$1/g" library/inc/$PROJECT_NAME.h ## replace placeholder values with project name
sed -i "s*"'$CURRENT_DATE'"*$CURRENT_DATE*g" library/inc/$PROJECT_NAME.h ## replace placeholder values with project name

#create the compile&run script
sed -i "s/"'$PROJECT_NAME'"/$1/g" compileAndRun.sh ## replace placeholder values with project name
sed -i "s*"'$CURRENT_DATE'"*$CURRENT_DATE*g" compileAndRun.sh ## replace placeholder values with project name

#copy gitignore template

git init #create git repo
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





