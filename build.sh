#!/usr/bin/env bash

BUILD_DIR="build"
SOURCE_DIR="src"
DIST_FILE="watchface.watch"

# Remove previous build artifact
if [ -f ${DIST_FILE} ]; then
    echo Removing old build artifact
    rm ${DIST_FILE}
fi

# Remove build directory
if [ -d ${BUILD_DIR} ]; then
    echo Removing old build directory
    rm -r ${BUILD_DIR}
fi

# Create build directory
echo Creating build directory
mkdir ${BUILD_DIR}

# Copy files to the build directory
echo Copying files to directory
cp -r ${SOURCE_DIR}/* ${BUILD_DIR}

# Put all lua files into scripts/script.txt
echo Building script.txt
find ${BUILD_DIR}/scripts -name \*.txt | xargs cat > ${BUILD_DIR}/scripts/script.txt
rm ${BUILD_DIR}/scripts/**/*.lua 2> /dev/null
rm ${BUILD_DIR}/scripts/*.lua 2> /dev/null

# Zip contents of directory
echo Creating watchfile
cd ${BUILD_DIR}
zip -r ../temp.zip .
cd ..
mv temp.zip ${DIST_FILE}

# Remove build directory
echo Removing build directory
rm -r ${BUILD_DIR}
