#!/bin/bash
yum -y install java-1.8.0-openjdk
yum -y remove java-1.7.0-openjdk

GATLING_VERSION="3.1.1"

curl -L -v https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${GATLING_VERSION}/gatling-charts-highcharts-bundle-${GATLING_VERSION}-bundle.zip  -o gatling-bundle-${GATLING_VERSION}-bundle.zip \
    && unzip gatling-bundle-${GATLING_VERSION}-bundle.zip \
    && rm gatling-bundle-${GATLING_VERSION}-bundle.zip \
    && mv gatling-charts-highcharts-bundle-${GATLING_VERSION} /opt/ \
    && chown -R ec2-user:ec2-user /opt/gatling-charts-highcharts-bundle-${GATLING_VERSION} \
    && echo "export PATH=\$PATH:/opt/gatling-charts-highcharts-bundle-${GATLING_VERSION}/bin" >> /home/ec2-user/.bashrc