#!/usr/bin/env sh

set -euXo pipefail

# set variables
applicationName=JavaService
version=$1
jarFile=$applicationName-$version.jar
tmpDir=/tmp/$applicationName
workDir=/var/lib/$applicationName
logDir=/var/log/$applicationName
propDir=$workDir/properties
scriptDir=$workDir/scripts

# create directories
echo "Creating temp directory if it does not exist: $tmpDir"
mkdir -pv $tmpDir

echo "Creating working directory if it does not exist: $workDir"
mkdir -pv $workDir

echo "Creating log directory if it does not exist: $logDir"
mkdir -pv $logDir

echo "Creating properties directory if it does not exist: $propDir"
mkdir -pv $propDir

# copy files from package to working directory
echo "Copying jar file from temp directory to working directory $workDir"
cp -fv $tmpDir/$jarFile $workDir/$jarFile

echo "Copying properties files from temp directory to properties directory $propDir"
cp -frv $tmpDir/properties/* $propDir/

echo "Copying script files from temp directory to scripts directory $scriptDir"
cp -frv $tmpDir/scripts/* $scriptDir/

# grant read and execute permissions to files
chmod +rx $workDir/$jarFile
chmod +rx -R $scriptDir/*

# Any pre-start-tasks go here

# Restart service
echo "Restarting $applicationName Service"
systemctl stop $applicationName
systemctl start $applicationName

# Any post-start-tasks go here.


echo "$applicationName deployment completed"