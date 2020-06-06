#!/bin/bash

echo "=============================="
echo "Open JDK 8 installation"
echo "=============================="

function installJava {
	echo "*** INSTALLING JAVA"
	sudo apt install -y openjdk-8-jdk
}

function setJavaEnviromentVariables {
	echo "*** SETTING AMBIENT VARIABLES"
	touch /home/vagrant/.bash_profile
	echo export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 >> /home/vagrant/.bash_profile
}

installJava
setJavaEnviromentVariables
