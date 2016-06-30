#!/bin/bash

export ENV_MULE_ESB_VERSION="3.8.0"
export ENV_MULE_AGENT_VERSION="1.4.2"

if [ ! -f ./mule-ee-distribution-standalone-${ENV_MULE_ESB_VERSION}.zip ]; then
  echo "mule-ee-distribution-standalone-${ENV_MULE_ESB_VERSION}.zip not found!. Downloading..."
	wget https://repository-master.mulesoft.org/nexus/content/repositories/ci-releases/com/mulesoft/muleesb/distributions/mule-ee-distribution-standalone/${ENV_MULE_ESB_VERSION}/mule-ee-distribution-standalone-${ENV_MULE_ESB_VERSION}.zip
else
	echo "mule-ee-distribution-standalone-${ENV_MULE_ESB_VERSION}.zip found!."
fi

if [ ! -f ./agent-setup-${ENV_MULE_AGENT_VERSION}.zip ]; then
  echo "agent-setup-${ENV_MULE_AGENT_VERSION}.zip not found!. Downloading..."
	wget http://mule-agent.s3.amazonaws.com/${ENV_MULE_AGENT_VERSION}/agent-setup-${ENV_MULE_AGENT_VERSION}.zip
else
	echo "agent-setup-${ENV_MULE_AGENT_VERSION}.zip found!."
fi

docker build -t mule_${ENV_MULE_ESB_VERSION}:latest . --build-arg MULE_ESB_VERSION=${ENV_MULE_ESB_VERSION} --build-arg MULE_AGENT_VERSION=${ENV_MULE_AGENT_VERSION}
