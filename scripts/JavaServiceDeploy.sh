#!/usr/bin/env sh

# How to use:
# See documents/DeploymentSteps.md in the code base

set -euXo pipefail

# set variables
applicationName=JavaService
version=$1
jarFile=$applicationName-$version.jar
tmpDir=/tmp/"$applicationName"
workDir=/var/lib/$applicationName
logDir=/var/log/$applicationName
propDir=$workDir/properties
scriptDir=$workDir/scripts
currentTimeStamp="$(date -d "today" +"%Y%m%d%H%M")"


# create directories
echo "Creating working directory if it does not exist: $workDir"
mkdir -pv $workDir

echo "Creating log directory if it does not exist: $logDir"
mkdir -pv $logDir

echo "Creating properties directory if it does not exist: $propDir"
mkdir -pv $propDir

echo "Create old-artifact directory if it does not exist"
mkdir -pv $workDir/oldArtifacts


# take backup
echo "Moving old artifacts to oldArtifacts directory (with current timestamp)"
mkdir -pv $workDir/oldArtifacts/"$currentTimeStamp"
mv -fv $workDir/* $workDir/oldArtifacts/"$currentTimeStamp"/


# copy files from package to working directory
echo "Copying jar file from temp directory to working directory $workDir"
cp -fv "$tmpDir"/"$jarFile" $workDir/"$jarFile"

echo "Copying properties files from temp directory to properties directory $propDir"
cp -frv "$tmpDir"/properties/* $propDir/

echo "Copying script files from temp directory to scripts directory $scriptDir"
cp -frv "$tmpDir"/scripts/* $scriptDir/

echo "Granting read and execute permissions to application files"
chmod +rx $workDir/"$jarFile"
chmod +rx -R $scriptDir/*


# Any pre-start-tasks go here


# Restart service
echo "Restarting $applicationName Service"
systemctl stop $applicationName
systemctl start $applicationName


# Any post-start-tasks go here.

echo "$applicationName deployment completed"