#!/usr/bin/env sh

serviceName=JavaService
jarDir=/var/lib/$serviceName
sysOutLog=/var/log/$serviceName/systemout.log
sysErrLog=/var/log/$serviceName/systemerr.log
javaOptions=" -Xms256m -Xmx512m -server "
jarName=JavaServiceDemo-1.0.jar
appOptions=" -Drun.arguments=--server.port=8090 "

exec /usr/bin/java "$javaOptions" -jar $jarDir/$jarName "$appOptions" >> $sysOutLog 2>> $sysErrLog