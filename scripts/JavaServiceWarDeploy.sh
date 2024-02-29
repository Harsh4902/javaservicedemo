#!/usr/bin bash

tomcatHome=/opt/homebrew/Cellar/tomcat/10.1.19/libexec/bin

#stop tomcat
$tomcatHome/shutdown.sh

#start tomcat
$tomcatHome/startup.sh