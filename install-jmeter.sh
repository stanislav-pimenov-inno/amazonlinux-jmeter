#!/bin/bash
yum -y install java-1.8.0-openjdk
yum -y remove java-1.7.0-openjdk

JMETER_VERSION="5.1"
CMDRUNNER_VERSION="2.2"

curl -fsSL --compressed -o /tmp/jmeter.tgz https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz \
    && tar -C /opt -xzf /tmp/jmeter.tgz \
    && rm /tmp/jmeter.tgz \
    && curl -fsSL --compressed -o /opt/apache-jmeter-$JMETER_VERSION/lib/ext/jmeter-plugins-manager.jar https://jmeter-plugins.org/get \
    && curl -fsSL --compressed -o /opt/apache-jmeter-$JMETER_VERSION/lib/cmdrunner-$CMDRUNNER_VERSION.jar http://central.maven.org/maven2/kg/apc/cmdrunner/$CMDRUNNER_VERSION/cmdrunner-$CMDRUNNER_VERSION.jar \
    && java -cp /opt/apache-jmeter-$JMETER_VERSION/lib/ext/jmeter-plugins-manager.jar org.jmeterplugins.repository.PluginManagerCMDInstaller \
    && /opt/apache-jmeter-$JMETER_VERSION/bin/PluginsManagerCMD.sh install-all-except jpgc-hadoop,jpgc-oauth \
    && sleep 2 \
    && /opt/apache-jmeter-$JMETER_VERSION/bin/PluginsManagerCMD.sh status

echo "Setting environment variable JMETER_HOME and adding \$JMETER_HOME/bin to the .bashrc" \
  && echo "export JMETER_HOME=/opt/apache-jmeter-$JMETER_VERSION" >> ~/.bashrc \
  && echo "export PATH=\$PATH:/opt/apache-jmeter-$JMETER_VERSION/bin" >> ~/.bashrc \
  && source ~/.bashrc