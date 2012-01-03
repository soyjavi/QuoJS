#!/bin/bash
VERSION="1.0"

#define paths
COMPILER=google-compiler/compiler.jar
LUNGO_SOURCES=../src/
LUNGO_NAMESPACE=quo.
BUILDPATH=../release/
MINIFIED="min"
PACKED="packed"

#script
clear
echo -e "\033[0m"============================ QUOJS COMPILER ============================
## Files to compile
FILES_TO_COMPILE=""
FILES_TO_JOIN=""

#Main
DIR=$LUNGO_SOURCES$LUNGO_NAMESPACE
echo -e "\033[33m  [DIR]: "$LUNGO_SOURCES
FILES=(js core.js environment.js query.js style.js element.js ajax.js events.js events.manager.js events.gestures.js)
for file in "${FILES[@]}"
do
    FILES_TO_COMPILE=$FILES_TO_COMPILE" --js "$DIR$file
    FILES_TO_JOIN=$FILES_TO_JOIN" "$DIR$file
done

#UNCOMPRESED Version
#cat $FILES_TO_JOIN > $BUILDPATH/quo-$VERSION.js
#echo -e "\033[32m  [BUILD]: quo-"$VERSION.js"\033[0m"

#MINIFIED Version
java -jar $COMPILER $FILES_TO_COMPILE --js_output_file $BUILDPATH/quo-$VERSION.$MINIFIED.js
echo -e "\033[32m  [BUILD]: quo-"$VERSION.$MINIFIED.js"\033[0m"
echo ============================ /QUOJS COMPILER ============================