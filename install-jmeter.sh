#!/bin/bash
sudo yum -y install java-1.8.0-openjdk
sudo yum -y remove java-1.7.0-openjdk

JMETER_VERSION="5.1"
CMDRUNNER_VERSION="2.2"

curl -fsSL --compressed -o /tmp/jmeter.tgz https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz \
    && sudo tar -C /opt -xzf /tmp/jmeter.tgz \
    && rm /tmp/jmeter.tgz \
    && sudo curl -fsSL --compressed -o /opt/apache-jmeter-$JMETER_VERSION/lib/ext/jmeter-plugins-manager.jar https://jmeter-plugins.org/get \
    && sudo curl -fsSL --compressed -o /opt/apache-jmeter-$JMETER_VERSION/lib/cmdrunner-$CMDRUNNER_VERSION.jar http://central.maven.org/maven2/kg/apc/cmdrunner/$CMDRUNNER_VERSION/cmdrunner-$CMDRUNNER_VERSION.jar \
    && sudo java -cp /opt/apache-jmeter-$JMETER_VERSION/lib/ext/jmeter-plugins-manager.jar org.jmeterplugins.repository.PluginManagerCMDInstaller \
    && sudo /opt/apache-jmeter-$JMETER_VERSION/bin/PluginsManagerCMD.sh install-all-except jpgc-hadoop,jpgc-oauth \
    && sleep 2 \
    && sudo /opt/apache-jmeter-$JMETER_VERSION/bin/PluginsManagerCMD.sh status

echo "export JMETER_HOME=/opt/apache-jmeter-$JMETER_VERSION" >> /home/ec2-user/.bashrc \
  && echo "export PATH=\$PATH:/opt/apache-jmeter-$JMETER_VERSION/bin" >> /home/ec2-user/.bashrc