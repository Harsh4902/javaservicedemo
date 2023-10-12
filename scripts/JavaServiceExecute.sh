#!/usr/bin/env sh

# name and version
serviceName=JavaService
version=1.0

echo "Using serviceName: $serviceName and version: $version"

# Directories
jarDir=/var/lib/$serviceName
propDir=$jarDir/properties
logDir=/var/log/$serviceName

echo "Using application dir: $jarDir, properties dir: $propDir, log dir: $logDir"

# Console
sysOutLog=$logDir/systemOut.log
sysErrLog=$logDir/systemErr.log

echo "Redirecting Console output out: $sysOutLog and error: $sysErrLog"

jarName="$serviceName"Demo-$version.jar
echo "Using jar name: $jarName"

echo "Using java version: $($(which java) --version)"

javaOptions=" -Xms384m -Xmx768m -server "
echo "Using java options: $javaOptions"

# Properties
serverPortProp=--server.port=8090
export LOG_CONFIG_FILE="$propDir"/log4j2.xml
logFileNameProp=--spring.config.name=application
logFileLocProp=--spring.config.location=file://$propDir/
logConfigFileProp=-Dlog4j2.configurationFile=$LOG_CONFIG_FILE
echo "Using properties: $serverPortProp $logConfigFileProp $logFileLocProp"

echo "Starting Application..."

exec /usr/bin/java $javaOptions -jar $jarDir/$jarName $logConfigFileProp $serverPortProp $logFileNameProp $logFileLocProp > $sysOutLog 2> $sysErrLog &

echo "running on process: $!"

echo "Done"